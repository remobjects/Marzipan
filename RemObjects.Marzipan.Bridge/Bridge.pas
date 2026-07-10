namespace RemObjects.Marzipan.Bridge;

interface

uses
  System,
  System.Collections,
  System.Collections.Generic,
  System.Globalization,
  System.IO,
  System.Linq,
  System.Reflection,
  System.Runtime.InteropServices,
  System.Runtime.Loader;

type
  MethodBridge = assembly class
  public
    property &Type: System.Type;
    property ReflectedMethod: MethodBase;
    property Parameters: array of ParameterInfo;
  end;

  CallFrame = assembly class
  public
    property BridgeMethod: MethodBridge;
    property Target: Object;
    property Arguments: array of Object;
    property ReturnValue: Object;
    property Exception: Exception;
  end;

  Handles = assembly static class
  public
    class method Alloc(aValue: Object): IntPtr;
    class method Target(aHandle: IntPtr): Object;
    class method Target<T>(aHandle: IntPtr): T; where T is class;
    class method Free(aHandle: IntPtr);
  end;

  Utf16 = assembly static class
  public
    class method FromNative(aChars: IntPtr; aLength: Integer): String;
  end;

  Safe = assembly static class
  public
    class method Value<T>(aAction: Func<T>; aFallback: T): T;
    class method &Void(aAction: Action);
    class method LogUnhandledBridgeException(aException: Exception);
  end;

  RuntimeState = assembly static class
  private
    class var fAssembliesByName: Dictionary<String, System.Reflection.&Assembly> := new Dictionary<String, System.Reflection.&Assembly>(StringComparer.OrdinalIgnoreCase);
    class var fAssembliesByPath: Dictionary<String, System.Reflection.&Assembly> := new Dictionary<String, System.Reflection.&Assembly>(StringComparer.OrdinalIgnoreCase);
    class var fAssemblySearchPaths: HashSet<String> := new HashSet<String>(StringComparer.OrdinalIgnoreCase);
    class var fTypes: Dictionary<String, System.Type> := new Dictionary<String, System.Type>(StringComparer.Ordinal);
    class var fMethods: Dictionary<String, MethodBridge> := new Dictionary<String, MethodBridge>(StringComparer.Ordinal);

    class constructor;
    class method CacheLoadedAssembly(aFullPath: String; aAssembly: System.Reflection.&Assembly): System.Reflection.&Assembly;
    class method RegisterAssemblySearchPath(aPath: String);
    class method ResolveAssemblyFromRegisteredPaths(aContext: AssemblyLoadContext; aName: AssemblyName): System.Reflection.&Assembly;
    class method ResolveTrustedPlatformAssembly(aName: AssemblyName): String;
    class method SimpleAssemblyName(aAssemblyName: String): String;
  public
    class method LoadAssembly(aPath: String): System.Reflection.&Assembly;
    class method ResolveType(aAssemblyName: String; aTypeName: String): System.Type;
    class method ResolveMethod(aAssemblyName: String; aTypeName: String; aSignature: String): MethodBridge;
  end;

  MethodSignature = assembly class
  private
    class method SplitArgs(aText: String): List<String>;
    class method ToMonoSignature(aType: System.Type): String;
  public
    property Name: String;
    property Parameters: List<String>;

    class method Parse(aSignature: String): MethodSignature;
    class method Matches(aMethod: MethodBase; aSignature: MethodSignature): Boolean;
  end;

  ObjectHelpers = public static class
  public
    [UnmanagedCallersOnly(EntryPoint := 'MZ_GCHandle_Free')]
    class method FreeHandle(aHandle: IntPtr);

    [UnmanagedCallersOnly(EntryPoint := 'MZ_Object_Equals')]
    class method Equals(aInstance: IntPtr; aOther: IntPtr): Byte;

    [UnmanagedCallersOnly(EntryPoint := 'MZ_Object_ToString')]
    class method ToString(aInstance: IntPtr): IntPtr;

    [UnmanagedCallersOnly(EntryPoint := 'MZ_Object_ExceptionToString')]
    class method ExceptionToString(aException: IntPtr): IntPtr;

    [UnmanagedCallersOnly(EntryPoint := 'MZ_Object_ForceGarbageCollection')]
    class method ForceGarbageCollection: IntPtr;
  end;

  RuntimeHelpers = public static class
  public
    [UnmanagedCallersOnly(EntryPoint := 'MZ_Runtime_GetBridgeBuildInfo')]
    class method GetBridgeBuildInfo: IntPtr;

    [UnmanagedCallersOnly(EntryPoint := 'MZ_Runtime_LoadAssemblyHandle')]
    class method LoadAssemblyHandle(aPathHandle: IntPtr): IntPtr;

    [UnmanagedCallersOnly(EntryPoint := 'MZ_Runtime_LoadAssembly')]
    class method LoadAssembly(aPathChars: IntPtr; aPathLength: Integer): IntPtr;
  end;

  StringHelpers = public static class
  public
    [UnmanagedCallersOnly(EntryPoint := 'MZ_String_GetLength')]
    class method GetLength(aInstance: IntPtr): Integer;

    [UnmanagedCallersOnly(EntryPoint := 'MZ_String_GetChars')]
    class method GetChars(aInstance: IntPtr; aOutChars: IntPtr; aOutLength: IntPtr): IntPtr;

    [UnmanagedCallersOnly(EntryPoint := 'MZ_String_ReleaseChars')]
    class method ReleaseChars(aHandle: IntPtr);

    [UnmanagedCallersOnly(EntryPoint := 'MZ_String_FromUTF16')]
    class method FromUTF16(aChars: IntPtr; aLength: Integer): IntPtr;
  end;

  ArrayHelpers = public static class
  public
    [UnmanagedCallersOnly(EntryPoint := 'MZ_Array_GetCount')]
    class method GetCount(aArray: IntPtr): Integer;

    [UnmanagedCallersOnly(EntryPoint := 'MZ_Array_GetElement')]
    class method GetElement(aArray: IntPtr; aIndex: Integer): IntPtr;

    [UnmanagedCallersOnly(EntryPoint := 'MZ_Array_SetElement')]
    class method SetElement(aArray: IntPtr; aIndex: Integer; aValue: IntPtr);

    [UnmanagedCallersOnly(EntryPoint := 'MZ_Array_FromNSArray')]
    class method FromNSArray(aArray: IntPtr): IntPtr;

    [UnmanagedCallersOnly(EntryPoint := 'MZ_Array_FromObjectArray')]
    class method FromObjectArray(aObjects: IntPtr; aCount: Integer): IntPtr;

    [UnmanagedCallersOnly(EntryPoint := 'MZ_Array_FromStringArray')]
    class method FromStringArray(aStrings: IntPtr; aCount: Integer): IntPtr;
  end;

  ListHelpers = public static class
  public
    [UnmanagedCallersOnly(EntryPoint := 'MZ_List_GetCount')]
    class method GetCount(aList: IntPtr): Integer;

    [UnmanagedCallersOnly(EntryPoint := 'MZ_List_GetElement')]
    class method GetElement(aList: IntPtr; aIndex: Integer): IntPtr;

    [UnmanagedCallersOnly(EntryPoint := 'MZ_List_Clear')]
    class method Clear(aList: IntPtr);

    [UnmanagedCallersOnly(EntryPoint := 'MZ_List_FromNSArray')]
    class method FromNSArray(aArray: IntPtr): IntPtr;

    [UnmanagedCallersOnly(EntryPoint := 'MZ_List_FromObject')]
    class method FromObject(aValue: IntPtr): IntPtr;
  end;

  [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
  VoidCallback = public delegate(aUserData: IntPtr);

  [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
  IntCallback = public delegate(aUserData: IntPtr; aValue: Integer);

  [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
  ObjectCallback = public delegate(aUserData: IntPtr; aValue: IntPtr);

  [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
  StringCallback = public delegate(aUserData: IntPtr; aValue: IntPtr);

  [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
  TwoStringCallback = public delegate(aUserData: IntPtr; aFirst: IntPtr; aSecond: IntPtr);

  [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
  ObjectStringCallback = public delegate(aUserData: IntPtr; aFirst: IntPtr; aSecond: IntPtr);

  [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
  TwoObjectCallback = public delegate(aUserData: IntPtr; aFirst: IntPtr; aSecond: IntPtr);

  [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
  RemoteFileNeededCallback = public delegate(aUserData: IntPtr; aRemoteFileName: IntPtr): IntPtr;

  [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
  BreakExceptionCallback = public delegate(aUserData: IntPtr; aThread: IntPtr; aFatal: Byte; aType: IntPtr; aMessage: IntPtr);

  [UnmanagedFunctionPointer(CallingConvention.Cdecl)]
  DebugProgressCallback = public delegate(aUserData: IntPtr; aPercentage: Integer; aMessage: IntPtr);

  DebugEngineCallbackBridge = assembly class
  private
    fDebugEngine: Object;
    fUserData: IntPtr;
    fDebugProgress: DebugProgressCallback;
    fThreadStarted: ObjectCallback;
    fThreadFinished: ObjectCallback;
    fThreadRenamed: ObjectCallback;
    fProcessTerminated: IntCallback;
    fProcessStarted: VoidCallback;
    fProcessReady: VoidCallback;
    fProcessFailedToStart: StringCallback;
    fLog: TwoStringCallback;
    fStdOut: StringCallback;
    fStdErr: StringCallback;
    fBreakStop: TwoObjectCallback;
    fBreakpointResolved: ObjectCallback;
    fBreakpointSignal: ObjectStringCallback;
    fRemoteFileNeeded: RemoteFileNeededCallback;
    fBreakException: BreakExceptionCallback;
    fDisposed: VoidCallback;
    fModuleLoad: ObjectCallback;
    fModuleUnload: ObjectCallback;

    class method Callback<T>(aValue: IntPtr): T; where T is class;
    method Add(aName: String; aHandler: System.Delegate): Boolean;
    method EmitLog(aMessage: String);
  public
    constructor(aDebugEngine: Object; aUserData: IntPtr; aDebugProgress: IntPtr; aThreadStarted: IntPtr; aThreadFinished: IntPtr; aThreadRenamed: IntPtr; aProcessTerminated: IntPtr; aProcessStarted: IntPtr; aProcessReady: IntPtr; aProcessFailedToStart: IntPtr; aLog: IntPtr; aStdOut: IntPtr; aStdErr: IntPtr; aBreakStop: IntPtr; aBreakpointResolved: IntPtr; aBreakpointSignal: IntPtr; aRemoteFileNeeded: IntPtr; aBreakException: IntPtr; aDisposed: IntPtr; aModuleLoad: IntPtr; aModuleUnload: IntPtr);
    method Attach;
    finalizer;
  end;

  DebugEngineCallbackHelpers = public static class
  public
    [UnmanagedCallersOnly(EntryPoint := 'MZ_DebugEngine_AttachCallbacks')]
    class method AttachCallbacks(aDebugEngine: IntPtr; aUserData: IntPtr; aDebugProgress: IntPtr; aThreadStarted: IntPtr; aThreadFinished: IntPtr; aThreadRenamed: IntPtr; aProcessTerminated: IntPtr; aProcessStarted: IntPtr; aProcessReady: IntPtr; aProcessFailedToStart: IntPtr; aLog: IntPtr; aStdOut: IntPtr; aStdErr: IntPtr; aBreakStop: IntPtr; aBreakpointResolved: IntPtr; aBreakpointSignal: IntPtr; aRemoteFileNeeded: IntPtr; aBreakException: IntPtr; aDisposed: IntPtr; aModuleLoad: IntPtr; aModuleUnload: IntPtr): IntPtr;
  end;

  TypeHelpers = public static class
  public
    [UnmanagedCallersOnly(EntryPoint := 'MZ_Type_GetMethodHandle')]
    class method GetMethodHandle(aAssemblyHandle: IntPtr; aTypeHandle: IntPtr; aSignatureHandle: IntPtr): IntPtr;

    [UnmanagedCallersOnly(EntryPoint := 'MZ_Type_GetMethod')]
    class method GetMethod(aAssemblyChars: IntPtr; aAssemblyLength: Integer; aTypeChars: IntPtr; aTypeLength: Integer; aSignatureChars: IntPtr; aSignatureLength: Integer): IntPtr;

    [UnmanagedCallersOnly(EntryPoint := 'MZ_Type_InstantiateHandle')]
    class method InstantiateHandle(aAssemblyHandle: IntPtr; aTypeHandle: IntPtr): IntPtr;

    [UnmanagedCallersOnly(EntryPoint := 'MZ_Type_Instantiate')]
    class method Instantiate(aAssemblyChars: IntPtr; aAssemblyLength: Integer; aTypeChars: IntPtr; aTypeLength: Integer): IntPtr;
  end;

  CallFrameHelpers = public static class
  private
    class method SetValue(aFrameHandle: IntPtr; aIndex: Integer; aValue: Object);
    class method GetArgument(aFrameHandle: IntPtr; aIndex: Integer): Object;
    class method ConvertArguments(aParameters: array of ParameterInfo; aArguments: array of Object): array of Object;
    class method ConvertArgument(aValue: Object; aParameterType: System.Type): Object;
  public
    [UnmanagedCallersOnly(EntryPoint := 'MZ_CallFrame_Create')]
    class method Create(aMethodHandle: IntPtr; aTargetHandle: IntPtr; aArgumentCount: Integer): IntPtr;

    [UnmanagedCallersOnly(EntryPoint := 'MZ_CallFrame_SetObject')]
    class method SetObject(aFrameHandle: IntPtr; aIndex: Integer; aValueHandle: IntPtr);

    [UnmanagedCallersOnly(EntryPoint := 'MZ_CallFrame_SetString')]
    class method SetString(aFrameHandle: IntPtr; aIndex: Integer; aValueHandle: IntPtr);

    [UnmanagedCallersOnly(EntryPoint := 'MZ_CallFrame_SetBoolean')]
    class method SetBoolean(aFrameHandle: IntPtr; aIndex: Integer; aValue: Byte);

    [UnmanagedCallersOnly(EntryPoint := 'MZ_CallFrame_SetI4')]
    class method SetI4(aFrameHandle: IntPtr; aIndex: Integer; aValue: Integer);

    [UnmanagedCallersOnly(EntryPoint := 'MZ_CallFrame_SetU4')]
    class method SetU4(aFrameHandle: IntPtr; aIndex: Integer; aValue: UInt32);

    [UnmanagedCallersOnly(EntryPoint := 'MZ_CallFrame_SetI8')]
    class method SetI8(aFrameHandle: IntPtr; aIndex: Integer; aValue: Int64);

    [UnmanagedCallersOnly(EntryPoint := 'MZ_CallFrame_SetU8')]
    class method SetU8(aFrameHandle: IntPtr; aIndex: Integer; aValue: UInt64);

    [UnmanagedCallersOnly(EntryPoint := 'MZ_CallFrame_SetR4')]
    class method SetR4(aFrameHandle: IntPtr; aIndex: Integer; aValue: Single);

    [UnmanagedCallersOnly(EntryPoint := 'MZ_CallFrame_SetR8')]
    class method SetR8(aFrameHandle: IntPtr; aIndex: Integer; aValue: Double);

    [UnmanagedCallersOnly(EntryPoint := 'MZ_CallFrame_SetIntPtr')]
    class method SetIntPtr(aFrameHandle: IntPtr; aIndex: Integer; aValue: IntPtr);

    [UnmanagedCallersOnly(EntryPoint := 'MZ_CallFrame_SetDateTime')]
    class method SetDateTime(aFrameHandle: IntPtr; aIndex: Integer; aTicks: Int64);

    [UnmanagedCallersOnly(EntryPoint := 'MZ_CallFrame_Invoke')]
    class method Invoke(aFrameHandle: IntPtr): IntPtr;

    [UnmanagedCallersOnly(EntryPoint := 'MZ_CallFrame_GetResultObject')]
    class method GetResultObject(aFrameHandle: IntPtr): IntPtr;

    [UnmanagedCallersOnly(EntryPoint := 'MZ_CallFrame_GetResultString')]
    class method GetResultString(aFrameHandle: IntPtr): IntPtr;

    [UnmanagedCallersOnly(EntryPoint := 'MZ_CallFrame_GetResultBoolean')]
    class method GetResultBoolean(aFrameHandle: IntPtr): Byte;

    [UnmanagedCallersOnly(EntryPoint := 'MZ_CallFrame_GetResultI4')]
    class method GetResultI4(aFrameHandle: IntPtr): Integer;

    [UnmanagedCallersOnly(EntryPoint := 'MZ_CallFrame_GetResultU4')]
    class method GetResultU4(aFrameHandle: IntPtr): UInt32;

    [UnmanagedCallersOnly(EntryPoint := 'MZ_CallFrame_GetResultI8')]
    class method GetResultI8(aFrameHandle: IntPtr): Int64;

    [UnmanagedCallersOnly(EntryPoint := 'MZ_CallFrame_GetResultU8')]
    class method GetResultU8(aFrameHandle: IntPtr): UInt64;

    [UnmanagedCallersOnly(EntryPoint := 'MZ_CallFrame_GetResultR4')]
    class method GetResultR4(aFrameHandle: IntPtr): Single;

    [UnmanagedCallersOnly(EntryPoint := 'MZ_CallFrame_GetResultR8')]
    class method GetResultR8(aFrameHandle: IntPtr): Double;

    [UnmanagedCallersOnly(EntryPoint := 'MZ_CallFrame_GetResultIntPtr')]
    class method GetResultIntPtr(aFrameHandle: IntPtr): IntPtr;

    [UnmanagedCallersOnly(EntryPoint := 'MZ_CallFrame_GetResultDateTime')]
    class method GetResultDateTime(aFrameHandle: IntPtr): Int64;

    [UnmanagedCallersOnly(EntryPoint := 'MZ_CallFrame_GetArgumentObject')]
    class method GetArgumentObject(aFrameHandle: IntPtr; aIndex: Integer): IntPtr;

    [UnmanagedCallersOnly(EntryPoint := 'MZ_CallFrame_GetArgumentString')]
    class method GetArgumentString(aFrameHandle: IntPtr; aIndex: Integer): IntPtr;

    [UnmanagedCallersOnly(EntryPoint := 'MZ_CallFrame_GetArgumentBoolean')]
    class method GetArgumentBoolean(aFrameHandle: IntPtr; aIndex: Integer): Byte;

    [UnmanagedCallersOnly(EntryPoint := 'MZ_CallFrame_GetArgumentI4')]
    class method GetArgumentI4(aFrameHandle: IntPtr; aIndex: Integer): Integer;

    [UnmanagedCallersOnly(EntryPoint := 'MZ_CallFrame_GetArgumentU4')]
    class method GetArgumentU4(aFrameHandle: IntPtr; aIndex: Integer): UInt32;

    [UnmanagedCallersOnly(EntryPoint := 'MZ_CallFrame_GetArgumentI8')]
    class method GetArgumentI8(aFrameHandle: IntPtr; aIndex: Integer): Int64;

    [UnmanagedCallersOnly(EntryPoint := 'MZ_CallFrame_GetArgumentU8')]
    class method GetArgumentU8(aFrameHandle: IntPtr; aIndex: Integer): UInt64;

    [UnmanagedCallersOnly(EntryPoint := 'MZ_CallFrame_GetArgumentR4')]
    class method GetArgumentR4(aFrameHandle: IntPtr; aIndex: Integer): Single;

    [UnmanagedCallersOnly(EntryPoint := 'MZ_CallFrame_GetArgumentR8')]
    class method GetArgumentR8(aFrameHandle: IntPtr; aIndex: Integer): Double;

    [UnmanagedCallersOnly(EntryPoint := 'MZ_CallFrame_GetArgumentIntPtr')]
    class method GetArgumentIntPtr(aFrameHandle: IntPtr; aIndex: Integer): IntPtr;

    [UnmanagedCallersOnly(EntryPoint := 'MZ_CallFrame_GetArgumentDateTime')]
    class method GetArgumentDateTime(aFrameHandle: IntPtr; aIndex: Integer): Int64;
  end;

implementation

class method Handles.Alloc(aValue: Object): IntPtr;
begin
  if aValue = nil then
    exit IntPtr.Zero;
  result := GCHandle.ToIntPtr(GCHandle.Alloc(aValue, GCHandleType.Normal));
end;

class method Handles.Target(aHandle: IntPtr): Object;
begin
  if aHandle = IntPtr.Zero then
    exit nil;
  result := GCHandle.FromIntPtr(aHandle).Target;
end;

class method Handles.Target<T>(aHandle: IntPtr): T;
begin
  var lValue := Target(aHandle);
  if lValue is T then
    result := T(lValue)
  else
    result := nil;
end;

class method Handles.Free(aHandle: IntPtr);
begin
  if aHandle <> IntPtr.Zero then
    GCHandle.FromIntPtr(aHandle).Free();
end;

class method Utf16.FromNative(aChars: IntPtr; aLength: Integer): String;
begin
  if aLength < 0 then
    exit nil;
  if aLength = 0 then
    exit '';
  if aChars = IntPtr.Zero then
    exit nil;
  result := Marshal.PtrToStringUni(aChars, aLength);
end;

class method Safe.Value<T>(aAction: Func<T>; aFallback: T): T;
begin
  try
    result := aAction();
  except
    on e: Exception do begin
      LogUnhandledBridgeException(e);
      result := aFallback;
    end;
  end;
end;

class method Safe.&Void(aAction: Action);
begin
  try
    aAction();
  except
    on e: Exception do
      LogUnhandledBridgeException(e);
  end;
end;

class method Safe.LogUnhandledBridgeException(aException: Exception);
begin
  try
    Console.Error.WriteLine('[MarzipanBridge] Suppressed exception escaping unmanaged callback:');
    Console.Error.WriteLine(aException);
  except
    // Logging must never be the thing that escapes an unmanaged callback.
  end;
end;

class constructor RuntimeState;
begin
  // The native side loads product assemblies from an app-provided compiler folder
  // instead of a normal .deps.json application layout. CoreCLR will happily load
  // those explicit assemblies, but later dependency binds still need a resolver.
  AssemblyLoadContext.Default.Resolving += @ResolveAssemblyFromRegisteredPaths;
end;

class method RuntimeState.LoadAssembly(aPath: String): System.Reflection.&Assembly;
begin
  var lFullPath := Path.GetFullPath(aPath);
  locking fAssembliesByPath do begin
    var lExisting: System.Reflection.&Assembly;
    if fAssembliesByPath.TryGetValue(lFullPath, out lExisting) then
      exit lExisting;

    RegisterAssemblySearchPath(Path.GetDirectoryName(lFullPath));
    var lAssembly := AssemblyLoadContext.Default.LoadFromAssemblyPath(lFullPath);
    fAssembliesByPath[lFullPath] := lAssembly;
    fAssembliesByName[coalesce(lAssembly.GetName().Name, Path.GetFileNameWithoutExtension(lFullPath))] := lAssembly;
    result := lAssembly;
  end;
end;

class method RuntimeState.CacheLoadedAssembly(aFullPath: String; aAssembly: System.Reflection.&Assembly): System.Reflection.&Assembly;
begin
  fAssembliesByPath[aFullPath] := aAssembly;
  fAssembliesByName[coalesce(aAssembly.GetName().Name, Path.GetFileNameWithoutExtension(aFullPath))] := aAssembly;
  result := aAssembly;
end;

class method RuntimeState.RegisterAssemblySearchPath(aPath: String);
begin
  if String.IsNullOrWhiteSpace(aPath) then
    exit;

  locking fAssemblySearchPaths do
    fAssemblySearchPaths.Add(Path.GetFullPath(aPath));
end;

class method RuntimeState.ResolveAssemblyFromRegisteredPaths(aContext: AssemblyLoadContext; aName: AssemblyName): System.Reflection.&Assembly;
begin
  try
    var lSimpleName := aName.Name;
    if String.IsNullOrWhiteSpace(lSimpleName) then
      exit nil;

    locking fAssembliesByName do begin
      var lAlreadyLoaded: System.Reflection.&Assembly;
      if fAssembliesByName.TryGetValue(lSimpleName, out lAlreadyLoaded) then
        exit lAlreadyLoaded;
    end;

    for each lLoadedAssembly in AppDomain.CurrentDomain.GetAssemblies() do begin
      var lLoadedName := lLoadedAssembly.GetName();
      if String.Equals(lLoadedName.Name, lSimpleName, StringComparison.OrdinalIgnoreCase) then begin
        locking fAssembliesByName do
          fAssembliesByName[lSimpleName] := lLoadedAssembly;
        exit lLoadedAssembly;
      end;
    end;

    var lTrustedPath := ResolveTrustedPlatformAssembly(aName);
    if not String.IsNullOrWhiteSpace(lTrustedPath) and File.Exists(lTrustedPath) then begin
      locking fAssembliesByPath do begin
        var lExistingTrusted: System.Reflection.&Assembly;
        if fAssembliesByPath.TryGetValue(lTrustedPath, out lExistingTrusted) then
          exit lExistingTrusted;

        // Framework assemblies such as System.ObjectModel are listed in the
        // trusted platform assembly set, but not necessarily in the product
        // compiler folder.  Resolve them from CoreCLR's own TPA list before
        // falling back to app-provided directories.
        exit CacheLoadedAssembly(lTrustedPath, aContext.LoadFromAssemblyPath(lTrustedPath));
      end;
    end;

    var lSearchPaths: array of String;
    locking fAssemblySearchPaths do
      lSearchPaths := fAssemblySearchPaths.ToArray();

    for each lFolder in lSearchPaths do begin
      var lCandidate := Path.GetFullPath(Path.Combine(lFolder, lSimpleName + '.dll'));
      if not File.Exists(lCandidate) then
        continue;

      locking fAssembliesByPath do begin
        var lExisting: System.Reflection.&Assembly;
        if fAssembliesByPath.TryGetValue(lCandidate, out lExisting) then
          exit lExisting;

        // Do not call LoadAssembly from the Resolving event. Keep the resolver
        // non-throwing and load directly into the requesting context.
        RegisterAssemblySearchPath(Path.GetDirectoryName(lCandidate));
        exit CacheLoadedAssembly(lCandidate, aContext.LoadFromAssemblyPath(lCandidate));
      end;
    end;
  except
    // Let CoreCLR continue its normal failure path rather than letting arbitrary
    // IO/bind exceptions escape out through AssemblyLoadContext.Resolving.
  end;
end;

class method RuntimeState.ResolveTrustedPlatformAssembly(aName: AssemblyName): String;
begin
  var lTpa := AppContext.GetData('TRUSTED_PLATFORM_ASSEMBLIES') as String;
  if String.IsNullOrWhiteSpace(lTpa) or String.IsNullOrWhiteSpace(aName:Name) then
    exit nil;

  var lFileName := aName.Name + '.dll';
  for each lPath in lTpa.Split([Path.PathSeparator]) do
    if String.Equals(Path.GetFileName(lPath), lFileName, StringComparison.OrdinalIgnoreCase) then
      exit lPath;
  exit nil;
end;

class method RuntimeState.ResolveType(aAssemblyName: String; aTypeName: String): System.Type;
begin
  var lKey := aAssemblyName + '|' + aTypeName;
  locking fTypes do begin
    var lExisting: System.Type;
    if fTypes.TryGetValue(lKey, out lExisting) then
      exit lExisting;

    var lType: System.Type := nil;
    var lAssembly: System.Reflection.&Assembly;
    if fAssembliesByName.TryGetValue(SimpleAssemblyName(aAssemblyName), out lAssembly) then
      lType := lAssembly.GetType(aTypeName, false);

    if lType = nil then
      lType := System.Type.GetType(aTypeName + ', ' + aAssemblyName, false);

    if lType = nil then begin
      for each lLoadedAssembly in AppDomain.CurrentDomain.GetAssemblies() do begin
        lType := Safe.Value<System.Type>(method begin
          result := lLoadedAssembly.GetType(aTypeName, false);
        end, nil);
        if lType <> nil then
          break;
      end;
    end;

    if lType = nil then
      raise new TypeLoadException($"Could not resolve type '{aTypeName}, {aAssemblyName}'.");

    fTypes[lKey] := lType;
    result := lType;
  end;
end;

class method RuntimeState.ResolveMethod(aAssemblyName: String; aTypeName: String; aSignature: String): MethodBridge;
begin
  var lKey := aAssemblyName + '|' + aTypeName + '|' + aSignature;
  locking fMethods do begin
    var lExisting: MethodBridge;
    if fMethods.TryGetValue(lKey, out lExisting) then
      exit lExisting;

    var lType := ResolveType(aAssemblyName, aTypeName);
    var lParsed := MethodSignature.Parse(aSignature);
    var lFlags := BindingFlags.Public or BindingFlags.NonPublic or BindingFlags.Static or BindingFlags.Instance;
    var lCandidates := new List<MethodBase>;

    if lParsed.Name = '.ctor' then begin
      for each lConstructor in lType.GetConstructors(lFlags) do
        lCandidates.Add(lConstructor);
    end
    else begin
      for each lMethod in lType.GetMethods(lFlags) do
        if lMethod.Name = lParsed.Name then
          lCandidates.Add(lMethod);
    end;

    var lMethod: MethodBase := nil;
    for each lCandidate in lCandidates do
      if MethodSignature.Matches(lCandidate, lParsed) then begin
        lMethod := lCandidate;
        break;
      end;

    if lMethod = nil then begin
      for each lCandidate in lCandidates do
        if lCandidate.GetParameters().Length = lParsed.Parameters.Count then begin
          lMethod := lCandidate;
          break;
        end;
    end;

    if lMethod = nil then
      raise new MissingMethodException(lType.FullName, aSignature);

    var lBridge := new MethodBridge(&Type := lType, ReflectedMethod := lMethod, Parameters := lMethod.GetParameters());
    fMethods[lKey] := lBridge;
    result := lBridge;
  end;
end;

class method RuntimeState.SimpleAssemblyName(aAssemblyName: String): String;
begin
  var lComma := aAssemblyName.IndexOf(',');
  result := if lComma >= 0 then aAssemblyName.Substring(0, lComma).Trim() else aAssemblyName.Trim();
end;

class method MethodSignature.Parse(aSignature: String): MethodSignature;
begin
  var lText := aSignature.Trim();
  if lText.StartsWith(':', StringComparison.Ordinal) then
    lText := lText.Substring(1);

  var lOpen := lText.IndexOf('(');
  var lClose := lText.LastIndexOf(')');
  var lName := if lOpen >= 0 then lText.Substring(0, lOpen) else lText;
  var lArgsText := if (lOpen >= 0) and (lClose > lOpen) then lText.Substring(lOpen + 1, lClose - lOpen - 1) else '';
  result := new MethodSignature(Name := lName, Parameters := SplitArgs(lArgsText));
end;

class method MethodSignature.Matches(aMethod: MethodBase; aSignature: MethodSignature): Boolean;
begin
  var lParameters := aMethod.GetParameters();
  if lParameters.Length <> aSignature.Parameters.Count then
    exit false;

  for i: Integer := 0 to lParameters.Length - 1 do begin
    var lActual := ToMonoSignature(lParameters[i].ParameterType);
    if not String.Equals(lActual, aSignature.Parameters[i], StringComparison.Ordinal) then
      exit false;
  end;
  result := true;
end;

class method MethodSignature.SplitArgs(aText: String): List<String>;
begin
  result := new List<String>;
  if String.IsNullOrWhiteSpace(aText) then
    exit;

  var lDepth := 0;
  var lStart := 0;
  for i: Integer := 0 to aText.Length - 1 do begin
    if aText[i] = '<' then
      inc(lDepth)
    else if aText[i] = '>' then
      dec(lDepth)
    else if (aText[i] = ',') and (lDepth = 0) then begin
      result.Add(aText.Substring(lStart, i - lStart).Trim());
      lStart := i + 1;
    end;
  end;
  result.Add(aText.Substring(lStart).Trim());
end;

class method MethodSignature.ToMonoSignature(aType: System.Type): String;
begin
  if aType.IsByRef then
    exit ToMonoSignature(aType.GetElementType()) + '&';
  if aType.IsPointer then
    exit ToMonoSignature(aType.GetElementType()) + '*';
  if aType.IsArray then
    exit ToMonoSignature(aType.GetElementType()) + '[]';

  if aType = typeOf(Void) then exit 'void';
  if aType = typeOf(Boolean) then exit 'bool';
  if aType = typeOf(Byte) then exit 'byte';
  if aType = typeOf(SByte) then exit 'sbyte';
  if aType = typeOf(Int16) then exit 'short';
  if aType = typeOf(UInt16) then exit 'ushort';
  if aType = typeOf(Integer) then exit 'int';
  if aType = typeOf(UInt32) then exit 'uint';
  if aType = typeOf(Int64) then exit 'long';
  if aType = typeOf(UInt64) then exit 'ulong';
  if aType = typeOf(Char) then exit 'char';
  if aType = typeOf(Single) then exit 'single';
  if aType = typeOf(Double) then exit 'double';
  if aType = typeOf(IntPtr) then exit 'intptr';
  if aType = typeOf(UIntPtr) then exit 'uintptr';
  if aType = typeOf(Object) then exit 'object';
  if aType = typeOf(String) then exit 'string';

  if aType.IsGenericType then begin
    var lDefinition := aType.GetGenericTypeDefinition();
    var lArguments := new List<String>;
    for each lArgument in aType.GetGenericArguments() do
      lArguments.Add(ToMonoSignature(lArgument));
    exit lDefinition.FullName + '<' + String.Join(',', lArguments) + '>';
  end;

  result := coalesce(aType.FullName, aType.Name);
end;

class method ObjectHelpers.FreeHandle(aHandle: IntPtr);
begin
  Safe.&Void(method begin
    Handles.Free(aHandle);
  end);
end;

class method ObjectHelpers.Equals(aInstance: IntPtr; aOther: IntPtr): Byte;
begin
  result := Safe.Value<Byte>(method begin
    result := if Object.Equals(Handles.Target(aInstance), Handles.Target(aOther)) then Byte(1) else Byte(0);
  end, 0);
end;

class method ObjectHelpers.ToString(aInstance: IntPtr): IntPtr;
begin
  result := Safe.Value<IntPtr>(method begin
    var lValue := coalesce(Handles.Target(aInstance):ToString(), '');
    result := Handles.Alloc(lValue);
  end, IntPtr.Zero);
end;

class method ObjectHelpers.ExceptionToString(aException: IntPtr): IntPtr;
begin
  result := Safe.Value<IntPtr>(method begin
    var lValue := coalesce(Handles.Target(aException):ToString(), 'Exception');
    result := Handles.Alloc(lValue);
  end, IntPtr.Zero);
end;

class method ObjectHelpers.ForceGarbageCollection: IntPtr;
begin
  result := Safe.Value<IntPtr>(method begin
    var lBeforeUsed := GC.GetTotalMemory(false);
    var lMaxGeneration := GC.MaxGeneration;
    var lBeforeCollections := CollectionCounts(lMaxGeneration);

    GC.Collect(lMaxGeneration, GCCollectionMode.Forced, true, true);
    GC.WaitForPendingFinalizers();
    GC.Collect(lMaxGeneration, GCCollectionMode.Forced, true, true);

    var lAfterUsed := GC.GetTotalMemory(false);
    var lAfterCollections := CollectionCounts(lMaxGeneration);

    result := Handles.Alloc($".NET GC forced.\nUsed: {lBeforeUsed.ToString('n0', CultureInfo.InvariantCulture)} bytes -> {lAfterUsed.ToString('n0', CultureInfo.InvariantCulture)} bytes\nCollections: {lBeforeCollections} -> {lAfterCollections}");
  end, IntPtr.Zero);
end;

method CollectionCounts(aMaxGeneration: Integer): String;
begin
  var lResult := new List<String>;
  for lGeneration: Integer := 0 to aMaxGeneration do
    lResult.Add($"{lGeneration}:{GC.CollectionCount(lGeneration)}");
  result := String.Join(', ', lResult);
end;

class method RuntimeHelpers.GetBridgeBuildInfo: IntPtr;
begin
  result := Safe.Value<IntPtr>(method begin
    result := Handles.Alloc('RemObjects.Marzipan.Bridge build 2026-07-10 oxygene-bridge');
  end, IntPtr.Zero);
end;

class method RuntimeHelpers.LoadAssemblyHandle(aPathHandle: IntPtr): IntPtr;
begin
  try
    var lPath := Handles.Target<String>(aPathHandle);
    if String.IsNullOrEmpty(lPath) then
      exit Handles.Alloc(new ArgumentException('Assembly path is required.'));
    RuntimeState.LoadAssembly(lPath);
    result := IntPtr.Zero;
  except
    on e: Exception do
      result := Handles.Alloc(e);
  end;
end;

class method RuntimeHelpers.LoadAssembly(aPathChars: IntPtr; aPathLength: Integer): IntPtr;
begin
  try
    var lPath := Utf16.FromNative(aPathChars, aPathLength);
    if String.IsNullOrEmpty(lPath) then
      exit Handles.Alloc(new ArgumentException('Assembly path is required.'));
    RuntimeState.LoadAssembly(lPath);
    result := IntPtr.Zero;
  except
    on e: Exception do
      result := Handles.Alloc(e);
  end;
end;

class method StringHelpers.GetLength(aInstance: IntPtr): Integer;
begin
  result := Safe.Value<Integer>(method begin
    result := coalesce(Handles.Target<String>(aInstance):Length, 0);
  end, 0);
end;

class method StringHelpers.GetChars(aInstance: IntPtr; aOutChars: IntPtr; aOutLength: IntPtr): IntPtr;
begin
  result := Safe.Value<IntPtr>(method begin
    var lValue := Handles.Target<String>(aInstance);
    if (lValue = nil) or (aOutChars = IntPtr.Zero) or (aOutLength = IntPtr.Zero) then
      exit IntPtr.Zero;

    var lPin := GCHandle.Alloc(lValue, GCHandleType.Pinned);
    Marshal.WriteIntPtr(aOutChars, lPin.AddrOfPinnedObject());
    Marshal.WriteInt32(aOutLength, lValue.Length);
    result := GCHandle.ToIntPtr(lPin);
  end, IntPtr.Zero);
end;

class method StringHelpers.ReleaseChars(aHandle: IntPtr);
begin
  Safe.&Void(method begin
    Handles.Free(aHandle);
  end);
end;

class method StringHelpers.FromUTF16(aChars: IntPtr; aLength: Integer): IntPtr;
begin
  result := Safe.Value<IntPtr>(method begin
    result := Handles.Alloc(coalesce(Utf16.FromNative(aChars, aLength), ''));
  end, IntPtr.Zero);
end;

class method ArrayHelpers.GetCount(aArray: IntPtr): Integer;
begin
  result := Safe.Value<Integer>(method begin
    result := coalesce(Handles.Target<System.Array>(aArray):Length, 0);
  end, 0);
end;

class method ArrayHelpers.GetElement(aArray: IntPtr; aIndex: Integer): IntPtr;
begin
  result := Safe.Value<IntPtr>(method begin
    var lValue := Handles.Target<System.Array>(aArray);
    result := if lValue = nil then IntPtr.Zero else Handles.Alloc(lValue.GetValue(aIndex));
  end, IntPtr.Zero);
end;

class method ArrayHelpers.SetElement(aArray: IntPtr; aIndex: Integer; aValue: IntPtr);
begin
  Safe.&Void(method begin
    var lValue := Handles.Target<System.Array>(aArray);
    if lValue <> nil then
      lValue.SetValue(Handles.Target(aValue), aIndex);
  end);
end;

class method ArrayHelpers.FromNSArray(aArray: IntPtr): IntPtr;
begin
  result := Safe.Value<IntPtr>(method begin
    // The bridge is pure managed .NET and deliberately has no Cocoa dependency,
    // so native code should read NSArray and call typed helpers such as
    // FromStringArray. This keeps older generic wrappers from failing lookup.
    result := Handles.Alloc(new Object[0]);
  end, IntPtr.Zero);
end;

class method ArrayHelpers.FromObjectArray(aObjects: IntPtr; aCount: Integer): IntPtr;
begin
  result := Safe.Value<IntPtr>(method begin
    if (aObjects = IntPtr.Zero) or (aCount <= 0) then
      exit Handles.Alloc(new Object[0]);

    var lResult := new Object[aCount];
    for i: Integer := 0 to aCount - 1 do begin
      var lHandle := Marshal.ReadIntPtr(aObjects, i * IntPtr.Size);
      lResult[i] := Handles.Target(lHandle);
    end;
    result := Handles.Alloc(lResult);
  end, IntPtr.Zero);
end;

class method ArrayHelpers.FromStringArray(aStrings: IntPtr; aCount: Integer): IntPtr;
begin
  result := Safe.Value<IntPtr>(method begin
    if (aStrings = IntPtr.Zero) or (aCount <= 0) then
      exit Handles.Alloc(new String[0]);

    var lResult := new String[aCount];
    for i: Integer := 0 to aCount - 1 do begin
      var lHandle := Marshal.ReadIntPtr(aStrings, i * IntPtr.Size);
      lResult[i] := Handles.Target<String>(lHandle);
    end;
    result := Handles.Alloc(lResult);
  end, IntPtr.Zero);
end;

class method ListHelpers.GetCount(aList: IntPtr): Integer;
begin
  result := Safe.Value<Integer>(method begin
    result := coalesce(Handles.Target<IList>(aList):Count, 0);
  end, 0);
end;

class method ListHelpers.GetElement(aList: IntPtr; aIndex: Integer): IntPtr;
begin
  result := Safe.Value<IntPtr>(method begin
    var lValue := Handles.Target<IList>(aList);
    result := if lValue = nil then IntPtr.Zero else Handles.Alloc(lValue[aIndex]);
  end, IntPtr.Zero);
end;

class method ListHelpers.Clear(aList: IntPtr);
begin
  Safe.&Void(method begin
    Handles.Target<IList>(aList):Clear();
  end);
end;

class method ListHelpers.FromNSArray(aArray: IntPtr): IntPtr;
begin
  result := Safe.Value<IntPtr>(method begin
    result := Handles.Alloc(new ArrayList);
  end, IntPtr.Zero);
end;

class method ListHelpers.FromObject(aValue: IntPtr): IntPtr;
begin
  result := Safe.Value<IntPtr>(method begin
    var lList := new ArrayList;
    lList.Add(Handles.Target(aValue));
    result := Handles.Alloc(lList);
  end, IntPtr.Zero);
end;

constructor DebugEngineCallbackBridge(aDebugEngine: Object; aUserData: IntPtr; aDebugProgress: IntPtr; aThreadStarted: IntPtr; aThreadFinished: IntPtr; aThreadRenamed: IntPtr; aProcessTerminated: IntPtr; aProcessStarted: IntPtr; aProcessReady: IntPtr; aProcessFailedToStart: IntPtr; aLog: IntPtr; aStdOut: IntPtr; aStdErr: IntPtr; aBreakStop: IntPtr; aBreakpointResolved: IntPtr; aBreakpointSignal: IntPtr; aRemoteFileNeeded: IntPtr; aBreakException: IntPtr; aDisposed: IntPtr; aModuleLoad: IntPtr; aModuleUnload: IntPtr);
begin
  if aDebugEngine = nil then
    raise new ArgumentNullException('aDebugEngine');

  fDebugEngine := aDebugEngine;
  fUserData := aUserData;
  fDebugProgress := Callback<DebugProgressCallback>(aDebugProgress);
  fThreadStarted := Callback<ObjectCallback>(aThreadStarted);
  fThreadFinished := Callback<ObjectCallback>(aThreadFinished);
  fThreadRenamed := Callback<ObjectCallback>(aThreadRenamed);
  fProcessTerminated := Callback<IntCallback>(aProcessTerminated);
  fProcessStarted := Callback<VoidCallback>(aProcessStarted);
  fProcessReady := Callback<VoidCallback>(aProcessReady);
  fProcessFailedToStart := Callback<StringCallback>(aProcessFailedToStart);
  fLog := Callback<TwoStringCallback>(aLog);
  fStdOut := Callback<StringCallback>(aStdOut);
  fStdErr := Callback<StringCallback>(aStdErr);
  fBreakStop := Callback<TwoObjectCallback>(aBreakStop);
  fBreakpointResolved := Callback<ObjectCallback>(aBreakpointResolved);
  fBreakpointSignal := Callback<ObjectStringCallback>(aBreakpointSignal);
  fRemoteFileNeeded := Callback<RemoteFileNeededCallback>(aRemoteFileNeeded);
  fBreakException := Callback<BreakExceptionCallback>(aBreakException);
  fDisposed := Callback<VoidCallback>(aDisposed);
  fModuleLoad := Callback<ObjectCallback>(aModuleLoad);
  fModuleUnload := Callback<ObjectCallback>(aModuleUnload);
end;

method DebugEngineCallbackBridge.Attach;
begin
  // Mirrors the old Mono internal-call callback hookup with explicit unmanaged callbacks.
  var lAttached := 0;
  var lAttempted := 0;

  if Add('DebugProgress', new Action<Integer,String>(method(aPercentage: Integer; aMessage: String) begin fDebugProgress:Invoke(fUserData, aPercentage, Handles.Alloc(aMessage)); end)) then inc(lAttached); inc(lAttempted);
  if Add('ThreadStarted', new Action<Object>(method(aThread: Object) begin fThreadStarted:Invoke(fUserData, Handles.Alloc(aThread)); end)) then inc(lAttached); inc(lAttempted);
  if Add('ThreadFinished', new Action<Object>(method(aThread: Object) begin fThreadFinished:Invoke(fUserData, Handles.Alloc(aThread)); end)) then inc(lAttached); inc(lAttempted);
  if Add('ThreadRenamed', new Action<Object>(method(aThread: Object) begin fThreadRenamed:Invoke(fUserData, Handles.Alloc(aThread)); end)) then inc(lAttached); inc(lAttempted);
  if Add('ProcessTerminated', new Action<Integer>(method(aExitCode: Integer) begin fProcessTerminated:Invoke(fUserData, aExitCode); end)) then inc(lAttached); inc(lAttempted);
  if Add('ProcessStarted', new Action(method begin fProcessStarted:Invoke(fUserData); end)) then inc(lAttached); inc(lAttempted);
  if Add('ProcessReady', new Action(method begin fProcessReady:Invoke(fUserData); end)) then inc(lAttached); inc(lAttempted);
  if Add('ProcessFailedToStart', new Action<String>(method(aMessage: String) begin fProcessFailedToStart:Invoke(fUserData, Handles.Alloc(aMessage)); end)) then inc(lAttached); inc(lAttempted);
  if Add('Log', new Action<String,String>(method(aSource: String; aMessage: String) begin fLog:Invoke(fUserData, Handles.Alloc(aSource), Handles.Alloc(aMessage)); end)) then inc(lAttached); inc(lAttempted);
  if Add('STDOut', new Action<String>(method(aMessage: String) begin fStdOut:Invoke(fUserData, Handles.Alloc(aMessage)); end)) then inc(lAttached); inc(lAttempted);
  if Add('STDErr', new Action<String>(method(aMessage: String) begin fStdErr:Invoke(fUserData, Handles.Alloc(aMessage)); end)) then inc(lAttached); inc(lAttempted);
  if Add('BreakStop', new Action<Object,Object>(method(aThread: Object; aBreakpoint: Object) begin fBreakStop:Invoke(fUserData, Handles.Alloc(aThread), Handles.Alloc(aBreakpoint)); end)) then inc(lAttached); inc(lAttempted);
  if Add('BreakpointResolved', new Action<Object>(method(aBreakpoint: Object) begin fBreakpointResolved:Invoke(fUserData, Handles.Alloc(aBreakpoint)); end)) then inc(lAttached); inc(lAttempted);
  if Add('BreakpointSignal', new Action<Object,String>(method(aThread: Object; aSignal: String) begin fBreakpointSignal:Invoke(fUserData, Handles.Alloc(aThread), Handles.Alloc(aSignal)); end)) then inc(lAttached); inc(lAttempted);
  if Add('RemoteFileNeeded', new Func<String,String>(method(aRemoteFileName: String): String begin
    if fRemoteFileNeeded = nil then
      exit aRemoteFileName;

    var lResultHandle := fRemoteFileNeeded(fUserData, Handles.Alloc(aRemoteFileName));
    try
      result := coalesce(Handles.Target<String>(lResultHandle), aRemoteFileName);
    finally
      Handles.Free(lResultHandle);
    end;
  end)) then inc(lAttached); inc(lAttempted);
  if Add('BreakException', new Action<Object,Boolean,String,String>(method(aThread: Object; aFatal: Boolean; aType: String; aMessage: String) begin fBreakException:Invoke(fUserData, Handles.Alloc(aThread), if aFatal then Byte(1) else Byte(0), Handles.Alloc(aType), Handles.Alloc(aMessage)); end)) then inc(lAttached); inc(lAttempted);
  if Add('ModuleLoad', new Action<Object>(method(aModule: Object) begin fModuleLoad:Invoke(fUserData, Handles.Alloc(aModule)); end)) then inc(lAttached); inc(lAttempted);
  if Add('ModuleUnload', new Action<Object>(method(aModule: Object) begin fModuleUnload:Invoke(fUserData, Handles.Alloc(aModule)); end)) then inc(lAttached); inc(lAttempted);

  EmitLog($"Debug callback bridge attached {lAttached}/{lAttempted} events to {fDebugEngine.GetType().FullName}.");
end;

finalizer DebugEngineCallbackBridge;
begin
  fDisposed:Invoke(fUserData);
end;

class method DebugEngineCallbackBridge.Callback<T>(aValue: IntPtr): T;
begin
  if aValue = IntPtr.Zero then
    exit nil;
  result := Marshal.GetDelegateForFunctionPointer(aValue, typeOf(T)) as T;
end;

method DebugEngineCallbackBridge.Add(aName: String; aHandler: System.Delegate): Boolean;
begin
  var lEventInfo := fDebugEngine.GetType().GetEvent(aName, BindingFlags.Public or BindingFlags.Instance);
  if lEventInfo = nil then begin
    EmitLog($"Debug callback event missing: {fDebugEngine.GetType().FullName}.{aName}");
    exit false;
  end;

  try
    var lTypedHandler: System.Delegate := aHandler;
    if aHandler.GetType() <> lEventInfo.EventHandlerType then
      lTypedHandler := System.Delegate.CreateDelegate(lEventInfo.EventHandlerType, aHandler.Target, aHandler.Method);

    lEventInfo.AddEventHandler(fDebugEngine, lTypedHandler);
    result := true;
  except
    on e: Exception do begin
      EmitLog($"Debug callback attach failed for {aName}: event handler type {lEventInfo.EventHandlerType:FullName}, native bridge handler type {aHandler.GetType().FullName}: {e.GetType().FullName}: {e.Message}");
      result := false;
    end;
  end;
end;

method DebugEngineCallbackBridge.EmitLog(aMessage: String);
begin
  try
    if fLog <> nil then
      fLog(fUserData, Handles.Alloc('MarzipanBridge'), Handles.Alloc(aMessage))
    else
      Console.Error.WriteLine('[MarzipanBridge] ' + aMessage);
  except
    // Diagnostics must never be able to break debugger startup.
  end;
end;

class method DebugEngineCallbackHelpers.AttachCallbacks(aDebugEngine: IntPtr; aUserData: IntPtr; aDebugProgress: IntPtr; aThreadStarted: IntPtr; aThreadFinished: IntPtr; aThreadRenamed: IntPtr; aProcessTerminated: IntPtr; aProcessStarted: IntPtr; aProcessReady: IntPtr; aProcessFailedToStart: IntPtr; aLog: IntPtr; aStdOut: IntPtr; aStdErr: IntPtr; aBreakStop: IntPtr; aBreakpointResolved: IntPtr; aBreakpointSignal: IntPtr; aRemoteFileNeeded: IntPtr; aBreakException: IntPtr; aDisposed: IntPtr; aModuleLoad: IntPtr; aModuleUnload: IntPtr): IntPtr;
begin
  result := Safe.Value<IntPtr>(method begin
    var lBridge := new DebugEngineCallbackBridge(Handles.Target(aDebugEngine), aUserData, aDebugProgress, aThreadStarted, aThreadFinished, aThreadRenamed, aProcessTerminated, aProcessStarted, aProcessReady, aProcessFailedToStart, aLog, aStdOut, aStdErr, aBreakStop, aBreakpointResolved, aBreakpointSignal, aRemoteFileNeeded, aBreakException, aDisposed, aModuleLoad, aModuleUnload);
    lBridge.Attach();
    result := Handles.Alloc(lBridge);
  end, IntPtr.Zero);
end;

class method TypeHelpers.GetMethodHandle(aAssemblyHandle: IntPtr; aTypeHandle: IntPtr; aSignatureHandle: IntPtr): IntPtr;
begin
  try
    var lAssembly := coalesce(Handles.Target<String>(aAssemblyHandle), '');
    var lType := coalesce(Handles.Target<String>(aTypeHandle), '');
    var lSignature := coalesce(Handles.Target<String>(aSignatureHandle), '');
    result := Handles.Alloc(RuntimeState.ResolveMethod(lAssembly, lType, lSignature));
  except
    on e: Exception do
      result := Handles.Alloc(e);
  end;
end;

class method TypeHelpers.GetMethod(aAssemblyChars: IntPtr; aAssemblyLength: Integer; aTypeChars: IntPtr; aTypeLength: Integer; aSignatureChars: IntPtr; aSignatureLength: Integer): IntPtr;
begin
  try
    var lAssembly := coalesce(Utf16.FromNative(aAssemblyChars, aAssemblyLength), '');
    var lType := coalesce(Utf16.FromNative(aTypeChars, aTypeLength), '');
    var lSignature := coalesce(Utf16.FromNative(aSignatureChars, aSignatureLength), '');
    result := Handles.Alloc(RuntimeState.ResolveMethod(lAssembly, lType, lSignature));
  except
    on e: Exception do
      result := Handles.Alloc(e);
  end;
end;

class method TypeHelpers.InstantiateHandle(aAssemblyHandle: IntPtr; aTypeHandle: IntPtr): IntPtr;
begin
  try
    var lAssembly := coalesce(Handles.Target<String>(aAssemblyHandle), '');
    var lTypeName := coalesce(Handles.Target<String>(aTypeHandle), '');
    var lType := RuntimeState.ResolveType(lAssembly, lTypeName);
    result := Handles.Alloc(Activator.CreateInstance(lType));
  except
    on e: Exception do
      result := Handles.Alloc(e);
  end;
end;

class method TypeHelpers.Instantiate(aAssemblyChars: IntPtr; aAssemblyLength: Integer; aTypeChars: IntPtr; aTypeLength: Integer): IntPtr;
begin
  try
    var lAssembly := coalesce(Utf16.FromNative(aAssemblyChars, aAssemblyLength), '');
    var lTypeName := coalesce(Utf16.FromNative(aTypeChars, aTypeLength), '');
    var lType := RuntimeState.ResolveType(lAssembly, lTypeName);
    result := Handles.Alloc(Activator.CreateInstance(lType));
  except
    on e: Exception do
      result := Handles.Alloc(e);
  end;
end;

class method CallFrameHelpers.Create(aMethodHandle: IntPtr; aTargetHandle: IntPtr; aArgumentCount: Integer): IntPtr;
begin
  result := Safe.Value<IntPtr>(method begin
    var lMethod := Handles.Target<MethodBridge>(aMethodHandle);
    if lMethod = nil then
      exit IntPtr.Zero;

    var lArgumentCount := Math.Max(aArgumentCount, lMethod.Parameters.Length);
    result := Handles.Alloc(new CallFrame(BridgeMethod := lMethod, Target := Handles.Target(aTargetHandle), Arguments := new Object[lArgumentCount]));
  end, IntPtr.Zero);
end;

class method CallFrameHelpers.SetObject(aFrameHandle: IntPtr; aIndex: Integer; aValueHandle: IntPtr);
begin
  Safe.&Void(method begin
    SetValue(aFrameHandle, aIndex, Handles.Target(aValueHandle));
  end);
end;

class method CallFrameHelpers.SetString(aFrameHandle: IntPtr; aIndex: Integer; aValueHandle: IntPtr);
begin
  Safe.&Void(method begin
    SetValue(aFrameHandle, aIndex, Handles.Target<String>(aValueHandle));
  end);
end;

class method CallFrameHelpers.SetBoolean(aFrameHandle: IntPtr; aIndex: Integer; aValue: Byte);
begin
  Safe.&Void(method begin
    SetValue(aFrameHandle, aIndex, aValue <> 0);
  end);
end;

class method CallFrameHelpers.SetI4(aFrameHandle: IntPtr; aIndex: Integer; aValue: Integer);
begin
  Safe.&Void(method begin SetValue(aFrameHandle, aIndex, aValue); end);
end;

class method CallFrameHelpers.SetU4(aFrameHandle: IntPtr; aIndex: Integer; aValue: UInt32);
begin
  Safe.&Void(method begin SetValue(aFrameHandle, aIndex, aValue); end);
end;

class method CallFrameHelpers.SetI8(aFrameHandle: IntPtr; aIndex: Integer; aValue: Int64);
begin
  Safe.&Void(method begin SetValue(aFrameHandle, aIndex, aValue); end);
end;

class method CallFrameHelpers.SetU8(aFrameHandle: IntPtr; aIndex: Integer; aValue: UInt64);
begin
  Safe.&Void(method begin SetValue(aFrameHandle, aIndex, aValue); end);
end;

class method CallFrameHelpers.SetR4(aFrameHandle: IntPtr; aIndex: Integer; aValue: Single);
begin
  Safe.&Void(method begin SetValue(aFrameHandle, aIndex, aValue); end);
end;

class method CallFrameHelpers.SetR8(aFrameHandle: IntPtr; aIndex: Integer; aValue: Double);
begin
  Safe.&Void(method begin SetValue(aFrameHandle, aIndex, aValue); end);
end;

class method CallFrameHelpers.SetIntPtr(aFrameHandle: IntPtr; aIndex: Integer; aValue: IntPtr);
begin
  Safe.&Void(method begin SetValue(aFrameHandle, aIndex, aValue); end);
end;

class method CallFrameHelpers.SetDateTime(aFrameHandle: IntPtr; aIndex: Integer; aTicks: Int64);
begin
  Safe.&Void(method begin SetValue(aFrameHandle, aIndex, new DateTime(aTicks)); end);
end;

class method CallFrameHelpers.Invoke(aFrameHandle: IntPtr): IntPtr;
begin
  var lFrame := Handles.Target<CallFrame>(aFrameHandle);
  if lFrame = nil then
    exit IntPtr.Zero;

  try
    lFrame.Exception := nil;
    var lArgs := ConvertArguments(lFrame.BridgeMethod.Parameters, lFrame.Arguments);
    if lFrame.BridgeMethod.ReflectedMethod is ConstructorInfo then
      lFrame.ReturnValue := ConstructorInfo(lFrame.BridgeMethod.ReflectedMethod).Invoke(lArgs)
    else
      lFrame.ReturnValue := MethodInfo(lFrame.BridgeMethod.ReflectedMethod).Invoke(lFrame.Target, lArgs);
    System.Array.Copy(lArgs, lFrame.Arguments, Math.Min(lArgs.Length, lFrame.Arguments.Length));
  except
    on e: TargetInvocationException do
      lFrame.Exception := coalesce(e.InnerException, e);
    on e: Exception do
      lFrame.Exception := e;
  end;

  result := if lFrame.Exception = nil then IntPtr.Zero else Handles.Alloc(lFrame.Exception);
end;

class method CallFrameHelpers.GetResultObject(aFrameHandle: IntPtr): IntPtr;
begin
  try
    result := Handles.Alloc(Handles.Target<CallFrame>(aFrameHandle):ReturnValue);
  except
    on e: Exception do begin
      Safe.LogUnhandledBridgeException(e);
      result := IntPtr.Zero;
    end;
  end;
end;

class method CallFrameHelpers.GetResultString(aFrameHandle: IntPtr): IntPtr;
begin
  try
    result := Handles.Alloc(Handles.Target<CallFrame>(aFrameHandle):ReturnValue as String);
  except
    on e: Exception do begin
      Safe.LogUnhandledBridgeException(e);
      result := IntPtr.Zero;
    end;
  end;
end;

class method CallFrameHelpers.GetResultBoolean(aFrameHandle: IntPtr): Byte;
begin
  try
    result := if Convert.ToBoolean(Handles.Target<CallFrame>(aFrameHandle):ReturnValue, CultureInfo.InvariantCulture) then Byte(1) else Byte(0);
  except
    on e: Exception do begin
      Safe.LogUnhandledBridgeException(e);
      result := 0;
    end;
  end;
end;

class method CallFrameHelpers.GetResultI4(aFrameHandle: IntPtr): Integer;
begin
  try
    result := Convert.ToInt32(Handles.Target<CallFrame>(aFrameHandle):ReturnValue, CultureInfo.InvariantCulture);
  except
    on e: Exception do begin
      Safe.LogUnhandledBridgeException(e);
      result := 0;
    end;
  end;
end;

class method CallFrameHelpers.GetResultU4(aFrameHandle: IntPtr): UInt32;
begin
  try
    result := Convert.ToUInt32(Handles.Target<CallFrame>(aFrameHandle):ReturnValue, CultureInfo.InvariantCulture);
  except
    on e: Exception do begin
      Safe.LogUnhandledBridgeException(e);
      result := 0;
    end;
  end;
end;

class method CallFrameHelpers.GetResultI8(aFrameHandle: IntPtr): Int64;
begin
  try
    result := Convert.ToInt64(Handles.Target<CallFrame>(aFrameHandle):ReturnValue, CultureInfo.InvariantCulture);
  except
    on e: Exception do begin
      Safe.LogUnhandledBridgeException(e);
      result := 0;
    end;
  end;
end;

class method CallFrameHelpers.GetResultU8(aFrameHandle: IntPtr): UInt64;
begin
  try
    result := Convert.ToUInt64(Handles.Target<CallFrame>(aFrameHandle):ReturnValue, CultureInfo.InvariantCulture);
  except
    on e: Exception do begin
      Safe.LogUnhandledBridgeException(e);
      result := 0;
    end;
  end;
end;

class method CallFrameHelpers.GetResultR4(aFrameHandle: IntPtr): Single;
begin
  try
    result := Convert.ToSingle(Handles.Target<CallFrame>(aFrameHandle):ReturnValue, CultureInfo.InvariantCulture);
  except
    on e: Exception do begin
      Safe.LogUnhandledBridgeException(e);
      result := 0.0;
    end;
  end;
end;

class method CallFrameHelpers.GetResultR8(aFrameHandle: IntPtr): Double;
begin
  try
    result := Convert.ToDouble(Handles.Target<CallFrame>(aFrameHandle):ReturnValue, CultureInfo.InvariantCulture);
  except
    on e: Exception do begin
      Safe.LogUnhandledBridgeException(e);
      result := 0.0;
    end;
  end;
end;

class method CallFrameHelpers.GetResultIntPtr(aFrameHandle: IntPtr): IntPtr;
begin
  try
    var lResult := Handles.Target<CallFrame>(aFrameHandle):ReturnValue;
    if lResult is IntPtr then
      exit IntPtr(lResult);
    if lResult is UIntPtr then
      exit new IntPtr(Int64(UIntPtr(lResult).ToUInt64()));
    result := new IntPtr(Convert.ToInt64(lResult, CultureInfo.InvariantCulture));
  except
    on e: Exception do begin
      Safe.LogUnhandledBridgeException(e);
      result := IntPtr.Zero;
    end;
  end;
end;

class method CallFrameHelpers.GetResultDateTime(aFrameHandle: IntPtr): Int64;
begin
  try
    var lResult := Handles.Target<CallFrame>(aFrameHandle):ReturnValue;
    if lResult is DateTime then
      exit DateTime(lResult).Ticks;
    result := 0;
  except
    on e: Exception do begin
      Safe.LogUnhandledBridgeException(e);
      result := 0;
    end;
  end;
end;

class method CallFrameHelpers.GetArgumentObject(aFrameHandle: IntPtr; aIndex: Integer): IntPtr;
begin
  try
    result := Handles.Alloc(GetArgument(aFrameHandle, aIndex));
  except
    on e: Exception do begin
      Safe.LogUnhandledBridgeException(e);
      result := IntPtr.Zero;
    end;
  end;
end;

class method CallFrameHelpers.GetArgumentString(aFrameHandle: IntPtr; aIndex: Integer): IntPtr;
begin
  try
    result := Handles.Alloc(GetArgument(aFrameHandle, aIndex) as String);
  except
    on e: Exception do begin
      Safe.LogUnhandledBridgeException(e);
      result := IntPtr.Zero;
    end;
  end;
end;

class method CallFrameHelpers.GetArgumentBoolean(aFrameHandle: IntPtr; aIndex: Integer): Byte;
begin
  try
    result := if Convert.ToBoolean(GetArgument(aFrameHandle, aIndex), CultureInfo.InvariantCulture) then Byte(1) else Byte(0);
  except
    on e: Exception do begin
      Safe.LogUnhandledBridgeException(e);
      result := 0;
    end;
  end;
end;

class method CallFrameHelpers.GetArgumentI4(aFrameHandle: IntPtr; aIndex: Integer): Integer;
begin
  try
    result := Convert.ToInt32(GetArgument(aFrameHandle, aIndex), CultureInfo.InvariantCulture);
  except
    on e: Exception do begin
      Safe.LogUnhandledBridgeException(e);
      result := 0;
    end;
  end;
end;

class method CallFrameHelpers.GetArgumentU4(aFrameHandle: IntPtr; aIndex: Integer): UInt32;
begin
  try
    result := Convert.ToUInt32(GetArgument(aFrameHandle, aIndex), CultureInfo.InvariantCulture);
  except
    on e: Exception do begin
      Safe.LogUnhandledBridgeException(e);
      result := 0;
    end;
  end;
end;

class method CallFrameHelpers.GetArgumentI8(aFrameHandle: IntPtr; aIndex: Integer): Int64;
begin
  try
    result := Convert.ToInt64(GetArgument(aFrameHandle, aIndex), CultureInfo.InvariantCulture);
  except
    on e: Exception do begin
      Safe.LogUnhandledBridgeException(e);
      result := 0;
    end;
  end;
end;

class method CallFrameHelpers.GetArgumentU8(aFrameHandle: IntPtr; aIndex: Integer): UInt64;
begin
  try
    result := Convert.ToUInt64(GetArgument(aFrameHandle, aIndex), CultureInfo.InvariantCulture);
  except
    on e: Exception do begin
      Safe.LogUnhandledBridgeException(e);
      result := 0;
    end;
  end;
end;

class method CallFrameHelpers.GetArgumentR4(aFrameHandle: IntPtr; aIndex: Integer): Single;
begin
  try
    result := Convert.ToSingle(GetArgument(aFrameHandle, aIndex), CultureInfo.InvariantCulture);
  except
    on e: Exception do begin
      Safe.LogUnhandledBridgeException(e);
      result := 0;
    end;
  end;
end;

class method CallFrameHelpers.GetArgumentR8(aFrameHandle: IntPtr; aIndex: Integer): Double;
begin
  try
    result := Convert.ToDouble(GetArgument(aFrameHandle, aIndex), CultureInfo.InvariantCulture);
  except
    on e: Exception do begin
      Safe.LogUnhandledBridgeException(e);
      result := 0;
    end;
  end;
end;

class method CallFrameHelpers.GetArgumentIntPtr(aFrameHandle: IntPtr; aIndex: Integer): IntPtr;
begin
  try
    var lResult := GetArgument(aFrameHandle, aIndex);
    if lResult = nil then
      exit IntPtr.Zero;
    result := if lResult is IntPtr then IntPtr(lResult) else new IntPtr(Convert.ToInt64(lResult, CultureInfo.InvariantCulture));
  except
    on e: Exception do begin
      Safe.LogUnhandledBridgeException(e);
      result := IntPtr.Zero;
    end;
  end;
end;

class method CallFrameHelpers.GetArgumentDateTime(aFrameHandle: IntPtr; aIndex: Integer): Int64;
begin
  try
    var lResult := GetArgument(aFrameHandle, aIndex);
    result := if lResult is DateTime then DateTime(lResult).Ticks else 0;
  except
    on e: Exception do begin
      Safe.LogUnhandledBridgeException(e);
      result := 0;
    end;
  end;
end;

class method CallFrameHelpers.SetValue(aFrameHandle: IntPtr; aIndex: Integer; aValue: Object);
begin
  var lFrame := Handles.Target<CallFrame>(aFrameHandle);
  if (lFrame = nil) or (aIndex < 0) or (aIndex >= lFrame.Arguments.Length) then
    exit;
  lFrame.Arguments[aIndex] := aValue;
end;

class method CallFrameHelpers.GetArgument(aFrameHandle: IntPtr; aIndex: Integer): Object;
begin
  var lFrame := Handles.Target<CallFrame>(aFrameHandle);
  if (lFrame = nil) or (aIndex < 0) or (aIndex >= lFrame.Arguments.Length) then
    exit nil;
  result := lFrame.Arguments[aIndex];
end;

class method CallFrameHelpers.ConvertArguments(aParameters: array of ParameterInfo; aArguments: array of Object): array of Object;
begin
  result := new Object[aParameters.Length];
  for i: Integer := 0 to aParameters.Length - 1 do
    result[i] := ConvertArgument(if aArguments.Length > i then aArguments[i] else nil, aParameters[i].ParameterType);
end;

class method CallFrameHelpers.ConvertArgument(aValue: Object; aParameterType: System.Type): Object;
begin
  var lTargetType := if aParameterType.IsByRef then aParameterType.GetElementType() else aParameterType;
  if aValue = nil then
    exit if lTargetType.IsValueType then Activator.CreateInstance(lTargetType) else nil;
  if lTargetType.IsInstanceOfType(aValue) then
    exit aValue;
  if lTargetType.IsArray and (aValue is System.Array) then begin
    var lSource := System.Array(aValue);
    var lElementType := lTargetType.GetElementType();
    var lResult := System.Array.CreateInstance(lElementType, lSource.Length);
    for i: Integer := 0 to lSource.Length - 1 do
      lResult.SetValue(ConvertArgument(lSource.GetValue(i), lElementType), i);
    exit lResult;
  end;
  if lTargetType.IsEnum then
    exit Enum.ToObject(lTargetType, aValue);
  if (lTargetType = typeOf(IntPtr)) or (lTargetType = typeOf(UIntPtr)) then
    exit aValue;
  result := Convert.ChangeType(aValue, coalesce(System.Nullable.GetUnderlyingType(lTargetType), lTargetType), CultureInfo.InvariantCulture);
end;

end.
