using System;
using System.Collections;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Runtime.InteropServices;
using System.Runtime.Loader;

namespace RemObjects.Marzipan.Bridge
{
    internal sealed class MethodBridge
    {
        public Type Type { get; set; }
        public MethodBase Method { get; set; }
        public ParameterInfo[] Parameters { get; set; }
    }

    internal sealed class CallFrame
    {
        public MethodBridge Method { get; set; }
        public object Target { get; set; }
        public object[] Arguments { get; set; }
        public object Result { get; set; }
        public Exception Exception { get; set; }
    }

    internal static class Handles
    {
        public static IntPtr Alloc(object value) =>
            value == null ? IntPtr.Zero : GCHandle.ToIntPtr(GCHandle.Alloc(value, GCHandleType.Normal));

        public static object Target(IntPtr handle) =>
            handle == IntPtr.Zero ? null : GCHandle.FromIntPtr(handle).Target;

        public static T Target<T>(IntPtr handle) where T : class =>
            Target(handle) as T;

        public static void Free(IntPtr handle)
        {
            if (handle != IntPtr.Zero)
                GCHandle.FromIntPtr(handle).Free();
        }
    }

    internal static class Utf16
    {
        public static string FromNative(IntPtr chars, int length)
        {
            if (length < 0)
                return null;
            if (length == 0)
                return "";
            if (chars == IntPtr.Zero)
                return null;
            return Marshal.PtrToStringUni(chars, length);
        }
    }

    internal static class RuntimeState
    {
        private static readonly Dictionary<string, Assembly> AssembliesByName = new(StringComparer.OrdinalIgnoreCase);
        private static readonly Dictionary<string, Assembly> AssembliesByPath = new(StringComparer.OrdinalIgnoreCase);
        private static readonly Dictionary<string, Type> Types = new(StringComparer.Ordinal);
        private static readonly Dictionary<string, MethodBridge> Methods = new(StringComparer.Ordinal);

        public static Assembly LoadAssembly(string path)
        {
            var fullPath = Path.GetFullPath(path);
            lock (AssembliesByPath)
            {
                if (AssembliesByPath.TryGetValue(fullPath, out var existing))
                    return existing;

                var assembly = AssemblyLoadContext.Default.LoadFromAssemblyPath(fullPath);
                AssembliesByPath[fullPath] = assembly;
                AssembliesByName[assembly.GetName().Name ?? Path.GetFileNameWithoutExtension(fullPath)] = assembly;
                return assembly;
            }
        }

        public static Type ResolveType(string assemblyName, string typeName)
        {
            var key = assemblyName + "|" + typeName;
            lock (Types)
            {
                if (Types.TryGetValue(key, out var existing))
                    return existing;

                Type type = null;
                if (AssembliesByName.TryGetValue(SimpleAssemblyName(assemblyName), out var assembly))
                    type = assembly.GetType(typeName, false);

                if (type == null)
                    type = Type.GetType(typeName + ", " + assemblyName, false);
                if (type == null)
                    type = AppDomain.CurrentDomain.GetAssemblies()
                    .Select(a => a.GetType(typeName, false))
                    .FirstOrDefault(t => t != null);

                if (type == null)
                    throw new TypeLoadException($"Could not resolve type '{typeName}, {assemblyName}'.");

                Types[key] = type;
                return type;
            }
        }

        public static MethodBridge ResolveMethod(string assemblyName, string typeName, string signature)
        {
            var key = assemblyName + "|" + typeName + "|" + signature;
            lock (Methods)
            {
                if (Methods.TryGetValue(key, out var existing))
                    return existing;

                var type = ResolveType(assemblyName, typeName);
                var parsed = MethodSignature.Parse(signature);
                var flags = BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.Static | BindingFlags.Instance;
                var candidates = parsed.Name == ".ctor"
                    ? type.GetConstructors(flags).Cast<MethodBase>()
                    : type.GetMethods(flags).Where(m => m.Name == parsed.Name).Cast<MethodBase>();

                var method = candidates.FirstOrDefault(m => MethodSignature.Matches(m, parsed));
                method ??= candidates.FirstOrDefault(m => m.GetParameters().Length == parsed.Parameters.Count);
                if (method == null)
                    throw new MissingMethodException(type.FullName, signature);

                var bridge = new MethodBridge
                {
                    Type = type,
                    Method = method,
                    Parameters = method.GetParameters()
                };
                Methods[key] = bridge;
                return bridge;
            }
        }

        private static string SimpleAssemblyName(string assemblyName)
        {
            var comma = assemblyName.IndexOf(',');
            return comma >= 0 ? assemblyName.Substring(0, comma).Trim() : assemblyName.Trim();
        }
    }

    internal sealed class MethodSignature
    {
        public string Name { get; set; }
        public List<string> Parameters { get; set; }

        public static MethodSignature Parse(string signature)
        {
            var text = signature.Trim();
            if (text.StartsWith(":", StringComparison.Ordinal))
                text = text.Substring(1);

            var open = text.IndexOf('(');
            var close = text.LastIndexOf(')');
            var name = open >= 0 ? text.Substring(0, open) : text;
            var argsText = open >= 0 && close > open ? text.Substring(open + 1, close - open - 1) : "";
            return new MethodSignature { Name = name, Parameters = SplitArgs(argsText) };
        }

        public static bool Matches(MethodBase method, MethodSignature signature)
        {
            var parameters = method.GetParameters();
            if (parameters.Length != signature.Parameters.Count)
                return false;

            for (var i = 0; i < parameters.Length; i++)
            {
                var actual = ToMonoSignature(parameters[i].ParameterType);
                if (!string.Equals(actual, signature.Parameters[i], StringComparison.Ordinal))
                    return false;
            }
            return true;
        }

        private static List<string> SplitArgs(string text)
        {
            var result = new List<string>();
            if (string.IsNullOrWhiteSpace(text))
                return result;

            var depth = 0;
            var start = 0;
            for (var i = 0; i < text.Length; i++)
            {
                if (text[i] == '<') depth++;
                else if (text[i] == '>') depth--;
                else if (text[i] == ',' && depth == 0)
                {
                    result.Add(text.Substring(start, i - start).Trim());
                    start = i + 1;
                }
            }
            result.Add(text.Substring(start).Trim());
            return result;
        }

        private static string ToMonoSignature(Type type)
        {
            if (type.IsByRef)
                return ToMonoSignature(type.GetElementType()) + "&";
            if (type.IsPointer)
                return ToMonoSignature(type.GetElementType()) + "*";
            if (type.IsArray)
                return ToMonoSignature(type.GetElementType()) + "[]";

            if (type == typeof(void)) return "void";
            if (type == typeof(bool)) return "bool";
            if (type == typeof(byte)) return "byte";
            if (type == typeof(sbyte)) return "sbyte";
            if (type == typeof(short)) return "short";
            if (type == typeof(ushort)) return "ushort";
            if (type == typeof(int)) return "int";
            if (type == typeof(uint)) return "uint";
            if (type == typeof(long)) return "long";
            if (type == typeof(ulong)) return "ulong";
            if (type == typeof(char)) return "char";
            if (type == typeof(float)) return "single";
            if (type == typeof(double)) return "double";
            if (type == typeof(IntPtr)) return "intptr";
            if (type == typeof(UIntPtr)) return "uintptr";
            if (type == typeof(object)) return "object";
            if (type == typeof(string)) return "string";

            if (type.IsGenericType)
            {
                var definition = type.GetGenericTypeDefinition();
                return definition.FullName + "<" + string.Join(",", type.GetGenericArguments().Select(ToMonoSignature)) + ">";
            }

            return type.FullName ?? type.Name;
        }
    }

    public static class ObjectHelpers
    {
        [UnmanagedCallersOnly(EntryPoint = "MZ_GCHandle_Free")]
        public static void FreeHandle(IntPtr handle) => Handles.Free(handle);

        [UnmanagedCallersOnly(EntryPoint = "MZ_Object_Equals")]
        public static bool Equals(IntPtr instance, IntPtr other) =>
            object.Equals(Handles.Target(instance), Handles.Target(other));

        [UnmanagedCallersOnly(EntryPoint = "MZ_Object_ToString")]
        public static IntPtr ToString(IntPtr instance)
        {
            var value = Handles.Target(instance)?.ToString() ?? "";
            return Handles.Alloc(value);
        }

        [UnmanagedCallersOnly(EntryPoint = "MZ_Object_ExceptionToString")]
        public static IntPtr ExceptionToString(IntPtr exception)
        {
            var value = Handles.Target(exception)?.ToString() ?? "Exception";
            return Handles.Alloc(value);
        }
    }

    public static class RuntimeHelpers
    {
        [UnmanagedCallersOnly(EntryPoint = "MZ_Runtime_LoadAssemblyHandle")]
        public static IntPtr LoadAssemblyHandle(IntPtr pathHandle)
        {
            try
            {
                var path = Handles.Target<string>(pathHandle);
                if (string.IsNullOrEmpty(path))
                    return Handles.Alloc(new ArgumentException("Assembly path is required."));
                RuntimeState.LoadAssembly(path);
                return IntPtr.Zero;
            }
            catch (Exception ex)
            {
                return Handles.Alloc(ex);
            }
        }

        [UnmanagedCallersOnly(EntryPoint = "MZ_Runtime_LoadAssembly")]
        public static IntPtr LoadAssembly(IntPtr pathChars, int pathLength)
        {
            try
            {
                var path = Utf16.FromNative(pathChars, pathLength);
                if (string.IsNullOrEmpty(path))
                    return Handles.Alloc(new ArgumentException("Assembly path is required."));
                RuntimeState.LoadAssembly(path);
                return IntPtr.Zero;
            }
            catch (Exception ex)
            {
                return Handles.Alloc(ex);
            }
        }
    }

    public static class StringHelpers
    {
        [UnmanagedCallersOnly(EntryPoint = "MZ_String_GetLength")]
        public static int GetLength(IntPtr instance) => Handles.Target<string>(instance)?.Length ?? 0;

        [UnmanagedCallersOnly(EntryPoint = "MZ_String_GetChars")]
        public static IntPtr GetChars(IntPtr instance, IntPtr outChars, IntPtr outLength)
        {
            var value = Handles.Target<string>(instance);
            if (value == null || outChars == IntPtr.Zero || outLength == IntPtr.Zero)
                return IntPtr.Zero;

            var pin = GCHandle.Alloc(value, GCHandleType.Pinned);
            Marshal.WriteIntPtr(outChars, pin.AddrOfPinnedObject());
            Marshal.WriteInt32(outLength, value.Length);
            return GCHandle.ToIntPtr(pin);
        }

        [UnmanagedCallersOnly(EntryPoint = "MZ_String_ReleaseChars")]
        public static void ReleaseChars(IntPtr handle) => Handles.Free(handle);

        [UnmanagedCallersOnly(EntryPoint = "MZ_String_FromUTF16")]
        public static IntPtr FromUTF16(IntPtr chars, int length) => Handles.Alloc(Utf16.FromNative(chars, length) ?? "");
    }

    public static class ArrayHelpers
    {
        [UnmanagedCallersOnly(EntryPoint = "MZ_Array_GetCount")]
        public static int GetCount(IntPtr array) => Handles.Target<Array>(array)?.Length ?? 0;

        [UnmanagedCallersOnly(EntryPoint = "MZ_Array_GetElement")]
        public static IntPtr GetElement(IntPtr array, int index)
        {
            var value = Handles.Target<Array>(array);
            return value == null ? IntPtr.Zero : Handles.Alloc(value.GetValue(index));
        }

        [UnmanagedCallersOnly(EntryPoint = "MZ_Array_SetElement")]
        public static void SetElement(IntPtr array, int index, IntPtr value)
        {
            Handles.Target<Array>(array)?.SetValue(Handles.Target(value), index);
        }

        [UnmanagedCallersOnly(EntryPoint = "MZ_Array_FromStringArray")]
        public static IntPtr FromStringArray(IntPtr strings, int count)
        {
            if (strings == IntPtr.Zero || count <= 0)
                return Handles.Alloc(Array.Empty<string>());
            var result = new string[count];
            for (var i = 0; i < count; i++)
            {
                var handle = Marshal.ReadIntPtr(strings, i * IntPtr.Size);
                result[i] = Handles.Target<string>(handle);
            }
            return Handles.Alloc(result);
        }
    }

    public static class ListHelpers
    {
        [UnmanagedCallersOnly(EntryPoint = "MZ_List_GetCount")]
        public static int GetCount(IntPtr list) => Handles.Target<IList>(list)?.Count ?? 0;

        [UnmanagedCallersOnly(EntryPoint = "MZ_List_GetElement")]
        public static IntPtr GetElement(IntPtr list, int index)
        {
            var value = Handles.Target<IList>(list);
            return value == null ? IntPtr.Zero : Handles.Alloc(value[index]);
        }

        [UnmanagedCallersOnly(EntryPoint = "MZ_List_Clear")]
        public static void Clear(IntPtr list) => Handles.Target<IList>(list)?.Clear();

        [UnmanagedCallersOnly(EntryPoint = "MZ_List_FromObject")]
        public static IntPtr FromObject(IntPtr value) => Handles.Alloc(new ArrayList { Handles.Target(value) });
    }

    public static class TypeHelpers
    {
        [UnmanagedCallersOnly(EntryPoint = "MZ_Type_GetMethodHandle")]
        public static IntPtr GetMethodHandle(IntPtr assemblyHandle, IntPtr typeHandle, IntPtr signatureHandle)
        {
            try
            {
                var assembly = Handles.Target<string>(assemblyHandle) ?? "";
                var type = Handles.Target<string>(typeHandle) ?? "";
                var signature = Handles.Target<string>(signatureHandle) ?? "";
                return Handles.Alloc(RuntimeState.ResolveMethod(assembly, type, signature));
            }
            catch (Exception ex)
            {
                return Handles.Alloc(ex);
            }
        }

        [UnmanagedCallersOnly(EntryPoint = "MZ_Type_GetMethod")]
        public static IntPtr GetMethod(IntPtr assemblyChars, int assemblyLength, IntPtr typeChars, int typeLength, IntPtr signatureChars, int signatureLength)
        {
            try
            {
                var assembly = Utf16.FromNative(assemblyChars, assemblyLength) ?? "";
                var type = Utf16.FromNative(typeChars, typeLength) ?? "";
                var signature = Utf16.FromNative(signatureChars, signatureLength) ?? "";
                return Handles.Alloc(RuntimeState.ResolveMethod(assembly, type, signature));
            }
            catch (Exception ex)
            {
                return Handles.Alloc(ex);
            }
        }

        [UnmanagedCallersOnly(EntryPoint = "MZ_Type_InstantiateHandle")]
        public static IntPtr InstantiateHandle(IntPtr assemblyHandle, IntPtr typeHandle)
        {
            try
            {
                var assembly = Handles.Target<string>(assemblyHandle) ?? "";
                var typeName = Handles.Target<string>(typeHandle) ?? "";
                var type = RuntimeState.ResolveType(assembly, typeName);
                return Handles.Alloc(Activator.CreateInstance(type));
            }
            catch (Exception ex)
            {
                return Handles.Alloc(ex);
            }
        }

        [UnmanagedCallersOnly(EntryPoint = "MZ_Type_Instantiate")]
        public static IntPtr Instantiate(IntPtr assemblyChars, int assemblyLength, IntPtr typeChars, int typeLength)
        {
            try
            {
                var assembly = Utf16.FromNative(assemblyChars, assemblyLength) ?? "";
                var typeName = Utf16.FromNative(typeChars, typeLength) ?? "";
                var type = RuntimeState.ResolveType(assembly, typeName);
                return Handles.Alloc(Activator.CreateInstance(type));
            }
            catch (Exception ex)
            {
                return Handles.Alloc(ex);
            }
        }
    }

    public static class CallFrameHelpers
    {
        [UnmanagedCallersOnly(EntryPoint = "MZ_CallFrame_Create")]
        public static IntPtr Create(IntPtr methodHandle, IntPtr targetHandle, int argumentCount)
        {
            var method = Handles.Target<MethodBridge>(methodHandle);
            if (method == null)
                return IntPtr.Zero;

            return Handles.Alloc(new CallFrame
            {
                Method = method,
                Target = Handles.Target(targetHandle),
                Arguments = new object[Math.Max(argumentCount, method.Parameters.Length)]
            });
        }

        [UnmanagedCallersOnly(EntryPoint = "MZ_CallFrame_SetObject")]
        public static void SetObject(IntPtr frameHandle, int index, IntPtr valueHandle) =>
            Set(frameHandle, index, Handles.Target(valueHandle));

        [UnmanagedCallersOnly(EntryPoint = "MZ_CallFrame_SetString")]
        public static void SetString(IntPtr frameHandle, int index, IntPtr valueHandle) =>
            Set(frameHandle, index, Handles.Target<string>(valueHandle));

        [UnmanagedCallersOnly(EntryPoint = "MZ_CallFrame_SetBoolean")]
        public static void SetBoolean(IntPtr frameHandle, int index, bool value) => Set(frameHandle, index, value);

        [UnmanagedCallersOnly(EntryPoint = "MZ_CallFrame_SetI4")]
        public static void SetI4(IntPtr frameHandle, int index, int value) => Set(frameHandle, index, value);

        [UnmanagedCallersOnly(EntryPoint = "MZ_CallFrame_SetU4")]
        public static void SetU4(IntPtr frameHandle, int index, uint value) => Set(frameHandle, index, value);

        [UnmanagedCallersOnly(EntryPoint = "MZ_CallFrame_SetI8")]
        public static void SetI8(IntPtr frameHandle, int index, long value) => Set(frameHandle, index, value);

        [UnmanagedCallersOnly(EntryPoint = "MZ_CallFrame_SetU8")]
        public static void SetU8(IntPtr frameHandle, int index, ulong value) => Set(frameHandle, index, value);

        [UnmanagedCallersOnly(EntryPoint = "MZ_CallFrame_SetR4")]
        public static void SetR4(IntPtr frameHandle, int index, float value) => Set(frameHandle, index, value);

        [UnmanagedCallersOnly(EntryPoint = "MZ_CallFrame_SetR8")]
        public static void SetR8(IntPtr frameHandle, int index, double value) => Set(frameHandle, index, value);

        [UnmanagedCallersOnly(EntryPoint = "MZ_CallFrame_SetIntPtr")]
        public static void SetIntPtr(IntPtr frameHandle, int index, IntPtr value) => Set(frameHandle, index, value);

        [UnmanagedCallersOnly(EntryPoint = "MZ_CallFrame_SetDateTime")]
        public static void SetDateTime(IntPtr frameHandle, int index, long ticks) => Set(frameHandle, index, new DateTime(ticks));

        [UnmanagedCallersOnly(EntryPoint = "MZ_CallFrame_Invoke")]
        public static IntPtr Invoke(IntPtr frameHandle)
        {
            var frame = Handles.Target<CallFrame>(frameHandle);
            if (frame == null)
                return IntPtr.Zero;

            try
            {
                frame.Exception = null;
                var args = ConvertArguments(frame.Method.Parameters, frame.Arguments);
                if (frame.Method.Method is ConstructorInfo constructor)
                    frame.Result = constructor.Invoke(args);
                else
                    frame.Result = ((MethodInfo)frame.Method.Method).Invoke(frame.Target, args);
                Array.Copy(args, frame.Arguments, Math.Min(args.Length, frame.Arguments.Length));
            }
            catch (TargetInvocationException ex)
            {
                frame.Exception = ex.InnerException ?? ex;
            }
            catch (Exception ex)
            {
                frame.Exception = ex;
            }
            return frame.Exception == null ? IntPtr.Zero : Handles.Alloc(frame.Exception);
        }

        [UnmanagedCallersOnly(EntryPoint = "MZ_CallFrame_GetResultObject")]
        public static IntPtr GetResultObject(IntPtr frameHandle) => Handles.Alloc(Handles.Target<CallFrame>(frameHandle)?.Result);

        [UnmanagedCallersOnly(EntryPoint = "MZ_CallFrame_GetResultString")]
        public static IntPtr GetResultString(IntPtr frameHandle) => Handles.Alloc(Handles.Target<CallFrame>(frameHandle)?.Result as string);

        [UnmanagedCallersOnly(EntryPoint = "MZ_CallFrame_GetResultBoolean")]
        public static bool GetResultBoolean(IntPtr frameHandle) => Convert.ToBoolean(Handles.Target<CallFrame>(frameHandle)?.Result, CultureInfo.InvariantCulture);

        [UnmanagedCallersOnly(EntryPoint = "MZ_CallFrame_GetResultI4")]
        public static int GetResultI4(IntPtr frameHandle) => Convert.ToInt32(Handles.Target<CallFrame>(frameHandle)?.Result, CultureInfo.InvariantCulture);

        [UnmanagedCallersOnly(EntryPoint = "MZ_CallFrame_GetResultU4")]
        public static uint GetResultU4(IntPtr frameHandle) => Convert.ToUInt32(Handles.Target<CallFrame>(frameHandle)?.Result, CultureInfo.InvariantCulture);

        [UnmanagedCallersOnly(EntryPoint = "MZ_CallFrame_GetResultI8")]
        public static long GetResultI8(IntPtr frameHandle) => Convert.ToInt64(Handles.Target<CallFrame>(frameHandle)?.Result, CultureInfo.InvariantCulture);

        [UnmanagedCallersOnly(EntryPoint = "MZ_CallFrame_GetResultU8")]
        public static ulong GetResultU8(IntPtr frameHandle) => Convert.ToUInt64(Handles.Target<CallFrame>(frameHandle)?.Result, CultureInfo.InvariantCulture);

        [UnmanagedCallersOnly(EntryPoint = "MZ_CallFrame_GetResultR4")]
        public static float GetResultR4(IntPtr frameHandle) => Convert.ToSingle(Handles.Target<CallFrame>(frameHandle)?.Result, CultureInfo.InvariantCulture);

        [UnmanagedCallersOnly(EntryPoint = "MZ_CallFrame_GetResultR8")]
        public static double GetResultR8(IntPtr frameHandle) => Convert.ToDouble(Handles.Target<CallFrame>(frameHandle)?.Result, CultureInfo.InvariantCulture);

        [UnmanagedCallersOnly(EntryPoint = "MZ_CallFrame_GetResultIntPtr")]
        public static IntPtr GetResultIntPtr(IntPtr frameHandle)
        {
            var result = Handles.Target<CallFrame>(frameHandle)?.Result;
            if (result is IntPtr value)
                return value;
            if (result is UIntPtr unsignedValue)
                return new IntPtr(unchecked((long)unsignedValue.ToUInt64()));
            return new IntPtr(Convert.ToInt64(result, CultureInfo.InvariantCulture));
        }

        [UnmanagedCallersOnly(EntryPoint = "MZ_CallFrame_GetResultDateTime")]
        public static long GetResultDateTime(IntPtr frameHandle)
        {
            var result = Handles.Target<CallFrame>(frameHandle)?.Result;
            if (result is DateTime value)
                return value.Ticks;
            return 0;
        }

        [UnmanagedCallersOnly(EntryPoint = "MZ_CallFrame_GetArgumentObject")]
        public static IntPtr GetArgumentObject(IntPtr frameHandle, int index) => Handles.Alloc(GetArgument(frameHandle, index));

        [UnmanagedCallersOnly(EntryPoint = "MZ_CallFrame_GetArgumentString")]
        public static IntPtr GetArgumentString(IntPtr frameHandle, int index) => Handles.Alloc(GetArgument(frameHandle, index) as string);

        [UnmanagedCallersOnly(EntryPoint = "MZ_CallFrame_GetArgumentI4")]
        public static int GetArgumentI4(IntPtr frameHandle, int index) => Convert.ToInt32(GetArgument(frameHandle, index), CultureInfo.InvariantCulture);

        private static void Set(IntPtr frameHandle, int index, object value)
        {
            var frame = Handles.Target<CallFrame>(frameHandle);
            if (frame == null || index < 0 || index >= frame.Arguments.Length)
                return;
            frame.Arguments[index] = value;
        }

        private static object GetArgument(IntPtr frameHandle, int index)
        {
            var frame = Handles.Target<CallFrame>(frameHandle);
            if (frame == null || index < 0 || index >= frame.Arguments.Length)
                return null;
            return frame.Arguments[index];
        }

        private static object[] ConvertArguments(ParameterInfo[] parameters, object[] arguments)
        {
            var result = new object[parameters.Length];
            for (var i = 0; i < parameters.Length; i++)
                result[i] = ConvertArgument(arguments.Length > i ? arguments[i] : null, parameters[i].ParameterType);
            return result;
        }

        private static object ConvertArgument(object value, Type parameterType)
        {
            var targetType = parameterType.IsByRef ? parameterType.GetElementType() : parameterType;
            if (value == null)
                return targetType.IsValueType ? Activator.CreateInstance(targetType) : null;
            if (targetType.IsInstanceOfType(value))
                return value;
            if (targetType.IsEnum)
                return Enum.ToObject(targetType, value);
            if (targetType == typeof(IntPtr) || targetType == typeof(UIntPtr))
                return value;
            return Convert.ChangeType(value, Nullable.GetUnderlyingType(targetType) ?? targetType, CultureInfo.InvariantCulture);
        }
    }
}
