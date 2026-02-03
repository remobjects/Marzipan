namespace RemObjects.Marzipan.Bridge;

interface

uses
  System,
  System.Collections,
  System.Runtime.InteropServices;

type
  ObjectHelpers = public static class
  public
    // Frees a GCHandle that was created by any bridge method returning IntPtr handles.
    // The native side owns the lifetime and must call this when done.
    [UnmanagedCallersOnly(EntryPoint := 'MZ_GCHandle_Free')]
    class method FreeHandle(aHandle: IntPtr);

    [UnmanagedCallersOnly(EntryPoint := 'MZ_Object_Equals')]
    class method Equals(aInstance: IntPtr; aOther: IntPtr): Boolean;

    [UnmanagedCallersOnly(EntryPoint := 'MZ_Object_ToString')]
    class method ToString(aInstance: IntPtr): IntPtr;

    [UnmanagedCallersOnly(EntryPoint := 'MZ_Object_ExceptionToString')]
    class method ExceptionToString(aException: IntPtr): IntPtr;
  end;

  StringHelpers = public static class
  public
    // Fast path: returns string length without materializing a copy.
    [UnmanagedCallersOnly(EntryPoint := 'MZ_String_GetLength')]
    class method GetLength(aInstance: IntPtr): Integer;

    // Pins the managed string and returns a handle to the pin. The UTF-16 pointer is written to aOutChars,
    // and the length (in UTF-16 code units) is written to aOutLength. Caller must release via ReleaseChars.
    [UnmanagedCallersOnly(EntryPoint := 'MZ_String_GetChars')]
    class method GetChars(aInstance: IntPtr; aOutChars: IntPtr; aOutLength: IntPtr): IntPtr;

    // Releases a handle returned by GetChars.
    [UnmanagedCallersOnly(EntryPoint := 'MZ_String_ReleaseChars')]
    class method ReleaseChars(aHandle: IntPtr);

    // Creates a managed string from UTF-16 characters without additional transcoding.
    // The returned IntPtr is a GCHandle to the managed string.
    [UnmanagedCallersOnly(EntryPoint := 'MZ_String_FromUTF16')]
    class method FromUTF16(aChars: IntPtr; aLength: Integer): IntPtr;

    [UnmanagedCallersOnly(EntryPoint := 'MZ_String_FromNSString')]
    class method FromNSString(aNSString: IntPtr): IntPtr;

    [UnmanagedCallersOnly(EntryPoint := 'MZ_String_ToNSString')]
    class method ToNSString(aNetString: IntPtr): IntPtr;
  end;

  ArrayHelpers = public static class
  public
    [UnmanagedCallersOnly(EntryPoint := 'MZ_Array_GetCount')]
    class method GetCount(aArray: IntPtr): Integer;

    [UnmanagedCallersOnly(EntryPoint := 'MZ_Array_GetElement')]
    class method GetElement(aArray: IntPtr; aIndex: Integer): IntPtr;

    [UnmanagedCallersOnly(EntryPoint := 'MZ_Array_SetElement')]
    class method SetElement(aArray: IntPtr; aIndex: Integer; aValue: IntPtr);

    [UnmanagedCallersOnly(EntryPoint := 'MZ_Array_ToNSArray')]
    class method ToNSArray(aArray: IntPtr): IntPtr;

    [UnmanagedCallersOnly(EntryPoint := 'MZ_Array_FromNSArray')]
    class method FromNSArray(aNSArray: IntPtr): IntPtr;

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

    [UnmanagedCallersOnly(EntryPoint := 'MZ_List_ToNSArray')]
    class method ToNSArray(aList: IntPtr): IntPtr;

    [UnmanagedCallersOnly(EntryPoint := 'MZ_List_FromNSArray')]
    class method FromNSArray(aNSArray: IntPtr): IntPtr;

    [UnmanagedCallersOnly(EntryPoint := 'MZ_List_FromObject')]
    class method FromObject(aObject: IntPtr): IntPtr;
  end;

  TypeHelpers = public static class
  public
    [UnmanagedCallersOnly(EntryPoint := 'MZ_Type_GetMethod')]
    class method GetMethod(aAssemblyName: IntPtr; aTypeName: IntPtr; aSignature: IntPtr): IntPtr;

    [UnmanagedCallersOnly(EntryPoint := 'MZ_Type_GetMethodThunk')]
    class method GetMethodThunk(aAssemblyName: IntPtr; aTypeName: IntPtr; aSignature: IntPtr): IntPtr;

    [UnmanagedCallersOnly(EntryPoint := 'MZ_Type_Instantiate')]
    class method Instantiate(aAssemblyName: IntPtr; aTypeName: IntPtr): IntPtr;
  end;

implementation

class method ObjectHelpers.FreeHandle(aHandle: IntPtr);
begin
  if aHandle = IntPtr.Zero then exit;
  GCHandle.FromIntPtr(aHandle).Free();
end;

class method ObjectHelpers.Equals(aInstance: IntPtr; aOther: IntPtr): Boolean;
begin
  if aInstance = IntPtr.Zero then exit aOther = IntPtr.Zero;
  var lObj := GCHandle.FromIntPtr(aInstance).Target;
  var lOther := if aOther = IntPtr.Zero then nil else GCHandle.FromIntPtr(aOther).Target;
  exit Object.Equals(lObj, lOther);
end;

class method ObjectHelpers.ToString(aInstance: IntPtr): IntPtr;
begin
  if aInstance = IntPtr.Zero then exit IntPtr.Zero;
  var lObj := GCHandle.FromIntPtr(aInstance).Target;
  var lStr := if lObj = nil then '' else lObj.ToString();
  var lHandle := GCHandle.Alloc(lStr, GCHandleType.Pinned);
  exit GCHandle.ToIntPtr(lHandle);
end;

class method ObjectHelpers.ExceptionToString(aException: IntPtr): IntPtr;
begin
  if aException = IntPtr.Zero then exit IntPtr.Zero;
  var lEx := GCHandle.FromIntPtr(aException).Target as Exception;
  var lStr := if lEx = nil then 'Exception' else lEx.ToString();
  var lHandle := GCHandle.Alloc(lStr, GCHandleType.Pinned);
  exit GCHandle.ToIntPtr(lHandle);
end;

class method StringHelpers.GetLength(aInstance: IntPtr): Integer;
begin
  if aInstance = IntPtr.Zero then exit 0;
  var lStr := GCHandle.FromIntPtr(aInstance).Target as String;
  exit if lStr = nil then 0 else lStr.Length;
end;

class method StringHelpers.GetChars(aInstance: IntPtr; aOutChars: IntPtr; aOutLength: IntPtr): IntPtr;
begin
  if (aInstance = IntPtr.Zero) or (aOutChars = IntPtr.Zero) or (aOutLength = IntPtr.Zero) then exit IntPtr.Zero;
  var lStr := GCHandle.FromIntPtr(aInstance).Target as String;
  if lStr = nil then exit IntPtr.Zero;
  var lHandle := GCHandle.Alloc(lStr, GCHandleType.Pinned);
  Marshal.WriteIntPtr(aOutChars, lHandle.AddrOfPinnedObject());
  Marshal.WriteInt32(aOutLength, lStr.Length);
  exit GCHandle.ToIntPtr(lHandle);
end;

class method StringHelpers.ReleaseChars(aHandle: IntPtr);
begin
  if aHandle = IntPtr.Zero then exit;
  GCHandle.FromIntPtr(aHandle).Free();
end;

class method StringHelpers.FromUTF16(aChars: IntPtr; aLength: Integer): IntPtr;
begin
  if aLength < 0 then exit IntPtr.Zero;
  var lStr: String;
  if aLength = 0 then
    lStr := ''
  else if aChars = IntPtr.Zero then
    lStr := ''
  else
    lStr := Marshal.PtrToStringUni(aChars, aLength);
  var lHandle := GCHandle.Alloc(lStr, GCHandleType.Normal);
  exit GCHandle.ToIntPtr(lHandle);
end;

class method StringHelpers.FromNSString(aNSString: IntPtr): IntPtr;
begin
  // Placeholder: native side should marshal NSString to UTF-16 bytes before calling.
  // This will be replaced with proper interop once the native <-> managed bridge is finalized.
  exit IntPtr.Zero;
end;

class method StringHelpers.ToNSString(aNetString: IntPtr): IntPtr;
begin
  // Placeholder: native side should allocate NSString from UTF-16 bytes.
  exit IntPtr.Zero;
end;

class method ArrayHelpers.GetCount(aArray: IntPtr): Integer;
begin
  if aArray = IntPtr.Zero then exit 0;
  var lArray := GCHandle.FromIntPtr(aArray).Target as Array;
  exit if lArray = nil then 0 else lArray.Length;
end;

class method ArrayHelpers.GetElement(aArray: IntPtr; aIndex: Integer): IntPtr;
begin
  if aArray = IntPtr.Zero then exit IntPtr.Zero;
  var lArray := GCHandle.FromIntPtr(aArray).Target as Array;
  if lArray = nil then exit IntPtr.Zero;
  var lItem := lArray.GetValue(aIndex);
  var lHandle := GCHandle.Alloc(lItem, GCHandleType.Normal);
  exit GCHandle.ToIntPtr(lHandle);
end;

class method ArrayHelpers.SetElement(aArray: IntPtr; aIndex: Integer; aValue: IntPtr);
begin
  if aArray = IntPtr.Zero then exit;
  var lArray := GCHandle.FromIntPtr(aArray).Target as Array;
  if lArray = nil then exit;
  var lValue := if aValue = IntPtr.Zero then nil else GCHandle.FromIntPtr(aValue).Target;
  lArray.SetValue(lValue, aIndex);
end;

class method ArrayHelpers.ToNSArray(aArray: IntPtr): IntPtr;
begin
  // Placeholder: requires Foundation interop on managed side.
  exit IntPtr.Zero;
end;

class method ArrayHelpers.FromNSArray(aNSArray: IntPtr): IntPtr;
begin
  // Placeholder: requires Foundation interop on managed side.
  exit IntPtr.Zero;
end;

class method ArrayHelpers.FromStringArray(aStrings: IntPtr; aCount: Integer): IntPtr;
begin
  // Placeholder: native side will pass array of GCHandles or UTF-16 pointers.
  exit IntPtr.Zero;
end;

class method ListHelpers.GetCount(aList: IntPtr): Integer;
begin
  if aList = IntPtr.Zero then exit 0;
  var lList := GCHandle.FromIntPtr(aList).Target as System.Collections.IList;
  exit if lList = nil then 0 else lList.Count;
end;

class method ListHelpers.GetElement(aList: IntPtr; aIndex: Integer): IntPtr;
begin
  if aList = IntPtr.Zero then exit IntPtr.Zero;
  var lList := GCHandle.FromIntPtr(aList).Target as System.Collections.IList;
  if lList = nil then exit IntPtr.Zero;
  var lItem := lList[aIndex];
  var lHandle := GCHandle.Alloc(lItem, GCHandleType.Normal);
  exit GCHandle.ToIntPtr(lHandle);
end;

class method ListHelpers.Clear(aList: IntPtr);
begin
  if aList = IntPtr.Zero then exit;
  var lList := GCHandle.FromIntPtr(aList).Target as System.Collections.IList;
  if lList = nil then exit;
  lList.Clear();
end;

class method ListHelpers.ToNSArray(aList: IntPtr): IntPtr;
begin
  // Placeholder: requires Foundation interop on managed side.
  exit IntPtr.Zero;
end;

class method ListHelpers.FromNSArray(aNSArray: IntPtr): IntPtr;
begin
  // Placeholder: requires Foundation interop on managed side.
  exit IntPtr.Zero;
end;

class method ListHelpers.FromObject(aObject: IntPtr): IntPtr;
begin
  if aObject = IntPtr.Zero then exit IntPtr.Zero;
  var lObj := GCHandle.FromIntPtr(aObject).Target;
  var lList := new ArrayList();
  lList.Add(lObj);
  var lHandle := GCHandle.Alloc(lList, GCHandleType.Normal);
  exit GCHandle.ToIntPtr(lHandle);
end;

class method TypeHelpers.GetMethod(aAssemblyName: IntPtr; aTypeName: IntPtr; aSignature: IntPtr): IntPtr;
begin
  // Placeholder: to be implemented once method signature parsing is defined.
  exit IntPtr.Zero;
end;

class method TypeHelpers.GetMethodThunk(aAssemblyName: IntPtr; aTypeName: IntPtr; aSignature: IntPtr): IntPtr;
begin
  // Placeholder: use UnmanagedCallersOnly method lookups or DynamicMethod stubs.
  exit IntPtr.Zero;
end;

class method TypeHelpers.Instantiate(aAssemblyName: IntPtr; aTypeName: IntPtr): IntPtr;
begin
  // Placeholder: resolve type, create instance, return GCHandle.
  exit IntPtr.Zero;
end;

end.
