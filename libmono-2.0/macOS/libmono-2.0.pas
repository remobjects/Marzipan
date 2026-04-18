type
  mono_bool = int32_t;

  mono_byte = uint8_t;

  mono_unichar2 = uint16_t;

  mono_unichar4 = uint32_t;

  mono.utils.MonoFunc = block(data: ^Void; user_data: ^Void): Void;

  mono.utils.MonoHFunc = block(key: ^Void; value: ^Void; user_data: ^Void): Void;

  mono.utils.__Global = class
  private

    class method mono_free(Param0: ^Void): Void; public;
    begin
    end;
    class method mono_set_allocator_vtable(vtable: ^mono.utils.MonoAllocatorVTable): mono_bool; public;
    begin
    end;
    class var MONO_COUNTER_INT: Int32; public;
    class var MONO_COUNTER_UINT: Int32; public;
    class var MONO_COUNTER_WORD: Int32; public;
    class var MONO_COUNTER_LONG: Int32; public;
    class var MONO_COUNTER_ULONG: Int32; public;
    class var MONO_COUNTER_DOUBLE: Int32; public;
    class var MONO_COUNTER_STRING: Int32; public;
    class var MONO_COUNTER_TIME_INTERVAL: Int32; public;
    class var MONO_COUNTER_TYPE_MASK: Int32; public;
    class var MONO_COUNTER_CALLBACK: Int32; public;
    class var MONO_COUNTER_SECTION_MASK: Int32; public;
    class var MONO_COUNTER_JIT: Int64; public;
    class var MONO_COUNTER_GC: Int64; public;
    class var MONO_COUNTER_METADATA: Int64; public;
    class var MONO_COUNTER_GENERICS: Int64; public;
    class var MONO_COUNTER_SECURITY: Int64; public;
    class var MONO_COUNTER_RUNTIME: Int64; public;
    class var MONO_COUNTER_SYSTEM: Int64; public;
    class var MONO_COUNTER_PERFCOUNTERS: Int64; public;
    class var MONO_COUNTER_PROFILER: Int64; public;
    class var MONO_COUNTER_LAST_SECTION: Int32; public;
    class var MONO_COUNTER_UNIT_SHIFT: Int32; public;
    class var MONO_COUNTER_UNIT_MASK: Int64; public;
    class var MONO_COUNTER_RAW: Int64; public;
    class var MONO_COUNTER_BYTES: Int64; public;
    class var MONO_COUNTER_TIME: Int64; public;
    class var MONO_COUNTER_COUNT: Int64; public;
    class var MONO_COUNTER_PERCENTAGE: Int64; public;
    class var MONO_COUNTER_VARIANCE_SHIFT: Int32; public;
    class var MONO_COUNTER_VARIANCE_MASK: Int64; public;
    class var MONO_COUNTER_MONOTONIC: Int64; public;
    class var MONO_COUNTER_CONSTANT: Int64; public;
    class var MONO_COUNTER_VARIABLE: Int64; public;
    class method mono_counters_enable(section_mask: Int32): Void; public;
    begin
    end;
    class method mono_counters_init: Void; public;
    begin
    end;
    class method mono_counters_register(descr: ^AnsiChar; &type: Int32; addr: ^Void): Void; public;
    begin
    end;
    class method mono_counters_register_with_size(name: ^AnsiChar; &type: Int32; addr: ^Void; size: Int32): Void; public;
    begin
    end;
    class method mono_counters_on_register(callback: method(Param0: ^MonoCounter): Void): Void; public;
    begin
    end;
    class method mono_counters_dump(section_mask: Int32; outfile: ^FILE): Void; public;
    begin
    end;
    class method mono_counters_cleanup: Void; public;
    begin
    end;
    class method mono_counters_foreach(cb: method(counter: ^MonoCounter; user_data: ^Void): mono_bool; user_data: ^Void): Void; public;
    begin
    end;
    class method mono_counters_sample(counter: ^MonoCounter; buffer: ^Void; buffer_size: Int32): Int32; public;
    begin
    end;
    class method mono_counter_get_name(name: ^MonoCounter): ^AnsiChar; public;
    begin
    end;
    class method mono_counter_get_type(counter: ^MonoCounter): Int32; public;
    begin
    end;
    class method mono_counter_get_section(counter: ^MonoCounter): Int32; public;
    begin
    end;
    class method mono_counter_get_unit(counter: ^MonoCounter): Int32; public;
    begin
    end;
    class method mono_counter_get_variance(counter: ^MonoCounter): Int32; public;
    begin
    end;
    class method mono_counter_get_size(counter: ^MonoCounter): size_t; public;
    begin
    end;
    class method mono_runtime_resource_limit(resource_type: Int32; soft_limit: uintptr_t; hard_limit: uintptr_t): Int32; public;
    begin
    end;
    class method mono_runtime_resource_set_callback(callback: method(resource_type: Int32; value: uintptr_t; is_soft: Int32): Void): Void; public;
    begin
    end;
    class method mono_runtime_resource_check_limit(resource_type: Int32; value: uintptr_t): Void; public;
    begin
    end;
    class var MONO_DL_EAGER: Int32; public;
    class var MONO_DL_LAZY: Int32; public;
    class var MONO_DL_LOCAL: Int32; public;
    class var MONO_DL_MASK: Int32; public;
    class method mono_dl_fallback_register(load_func: method(name: ^AnsiChar; &flags: Int32; err: ^^AnsiChar; user_data: ^Void): ^Void; symbol_func: method(handle: ^Void; name: ^AnsiChar; err: ^^AnsiChar; user_data: ^Void): ^Void; close_func: method(handle: ^Void; user_data: ^Void): ^Void; user_data: ^Void): ^MonoDlFallbackHandler; public;
    begin
    end;
    class method mono_dl_fallback_unregister(handler: ^MonoDlFallbackHandler): Void; public;
    begin
    end;
    class var MONO_ERROR_FREE_STRINGS: Int32; public;
    class var MONO_ERROR_INCOMPLETE: Int32; public;
    class var MONO_ERROR_NONE: Int32; public;
    class var MONO_ERROR_MISSING_METHOD: Int32; public;
    class var MONO_ERROR_MISSING_FIELD: Int32; public;
    class var MONO_ERROR_TYPE_LOAD: Int32; public;
    class var MONO_ERROR_FILE_NOT_FOUND: Int32; public;
    class var MONO_ERROR_BAD_IMAGE: Int32; public;
    class var MONO_ERROR_OUT_OF_MEMORY: Int32; public;
    class var MONO_ERROR_ARGUMENT: Int32; public;
    class var MONO_ERROR_ARGUMENT_NULL: Int32; public;
    class var MONO_ERROR_NOT_VERIFIABLE: Int32; public;
    class var MONO_ERROR_INVALID_PROGRAM: Int32; public;
    class var MONO_ERROR_GENERIC: Int32; public;
    class var MONO_ERROR_EXCEPTION_INSTANCE: Int32; public;
    class var MONO_ERROR_CLEANUP_CALLED_SENTINEL: Int32; public;
    class method mono_error_init(error: ^mono.utils.MonoError): Void; public;
    begin
    end;
    class method mono_error_init_flags(error: ^mono.utils.MonoError; &flags: UInt16): Void; public;
    begin
    end;
    class method mono_error_cleanup(error: ^mono.utils.MonoError): Void; public;
    begin
    end;
    class method mono_error_ok(error: ^mono.utils.MonoError): mono_bool; public;
    begin
    end;
    class method mono_error_get_error_code(error: ^mono.utils.MonoError): UInt16; public;
    begin
    end;
    class method mono_error_get_message(error: ^mono.utils.MonoError): ^AnsiChar; public;
    begin
    end;
    class method mono_trace_set_level_string(value: ^AnsiChar): Void; public;
    begin
    end;
    class method mono_trace_set_mask_string(value: ^AnsiChar): Void; public;
    begin
    end;
    class method mono_trace_set_log_handler(callback: method(log_domain: ^AnsiChar; log_level: ^AnsiChar; message: ^AnsiChar; fatal: mono_bool; user_data: ^Void): Void; user_data: ^Void): Void; public;
    begin
    end;
    class method mono_trace_set_print_handler(callback: method(string: ^AnsiChar; is_stdout: mono_bool): Void): Void; public;
    begin
    end;
    class method mono_trace_set_printerr_handler(callback: method(string: ^AnsiChar; is_stdout: mono_bool): Void): Void; public;
    begin
    end;
    class var MONO_ALLOCATOR_VTABLE_VERSION: Int32; public;
    class var MONO_ZERO_LEN_ARRAY: Int32; public;

  end;

  mono.utils.MonoAllocatorVTable = record
  private

    var version: Int32; public;
    var malloc: method(size: size_t): ^Void; public;
    var realloc: method(mem: ^Void; count: size_t): ^Void; public;
    var free: method(mem: ^Void): Void; public;
    var calloc: method(count: size_t; size: size_t): ^Void; public;

  end;

  MonoCounter = Void;

  mono.utils.MonoCounterRegisterCallback = block(Param0: ^MonoCounter): Void;

  mono.utils.CountersEnumCallback = block(counter: ^MonoCounter; user_data: ^Void): mono_bool;

  mono.utils.MonoResourceType = enum (MONO_RESOURCE_JIT_CODE = 0, MONO_RESOURCE_METADATA = 1, MONO_RESOURCE_GC_HEAP = 2, MONO_RESOURCE_COUNT = 3);

  mono.utils.MonoResourceCallback = block(resource_type: Int32; value: uintptr_t; is_soft: Int32): Void;

  MonoDlFallbackHandler = Void;

  mono.utils.MonoDlFallbackLoad = block(name: ^AnsiChar; &flags: Int32; err: ^^AnsiChar; user_data: ^Void): ^Void;

  mono.utils.MonoDlFallbackSymbol = block(handle: ^Void; name: ^AnsiChar; err: ^^AnsiChar; user_data: ^Void): ^Void;

  mono.utils.MonoDlFallbackClose = block(handle: ^Void; user_data: ^Void): ^Void;

  mono.utils.MonoError = record
  private

    var error_code: UInt16; public;
    var hidden_0: UInt16; public;
    var hidden_1: array of ^Void; public;

  end;

  mono.utils.MonoError = record
  private

    var error_code: UInt16; public;
    var hidden_0: UInt16; public;
    var hidden_1: array of ^Void; public;

  end;

  mono.utils.MonoPrintCallback = block(string: ^AnsiChar; is_stdout: mono_bool): Void;

  mono.utils.MonoLogCallback = block(log_domain: ^AnsiChar; log_level: ^AnsiChar; message: ^AnsiChar; fatal: mono_bool; user_data: ^Void): Void;

  mono.metadata.MonoTypeEnum = enum (MONO_TYPE_END = 0, MONO_TYPE_VOID = 1, MONO_TYPE_BOOLEAN = 2, MONO_TYPE_CHAR = 3, MONO_TYPE_I1 = 4, MONO_TYPE_U1 = 5, MONO_TYPE_I2 = 6, MONO_TYPE_U2 = 7, MONO_TYPE_I4 = 33, MONO_TYPE_U4 = 35, MONO_TYPE_I8 = 36, MONO_TYPE_U8 = 32, MONO_TYPE_R4 = 34, MONO_TYPE_R8 = 38, MONO_TYPE_STRING = 39, MONO_TYPE_PTR = 8, MONO_TYPE_BYREF = 40, MONO_TYPE_VALUETYPE = 41, MONO_TYPE_CLASS = 42, MONO_TYPE_VAR = 43, MONO_TYPE_ARRAY = 44, MONO_TYPE_GENERICINST = 45, MONO_TYPE_TYPEDBYREF = 46, MONO_TYPE_I = 21, MONO_TYPE_U = 47, MONO_TYPE_FNPTR = 48, MONO_TYPE_OBJECT = 27, MONO_TYPE_SZARRAY = 49, MONO_TYPE_MVAR = 50, MONO_TYPE_CMOD_REQD = 51, MONO_TYPE_CMOD_OPT = 52, MONO_TYPE_INTERNAL = 53, MONO_TYPE_MODIFIER = 54, MONO_TYPE_SENTINEL = 55, MONO_TYPE_PINNED = 56, MONO_TYPE_ENUM = 57);

  mono.metadata.MonoMetaTableEnum = enum (MONO_TABLE_MODULE = 0, MONO_TABLE_TYPEREF = 1, MONO_TABLE_TYPEDEF = 2, MONO_TABLE_FIELD_POINTER = 3, MONO_TABLE_FIELD = 4, MONO_TABLE_METHOD_POINTER = 5, MONO_TABLE_METHOD = 6, MONO_TABLE_PARAM_POINTER = 7, MONO_TABLE_PARAM = 33, MONO_TABLE_INTERFACEIMPL = 35, MONO_TABLE_MEMBERREF = 36, MONO_TABLE_CONSTANT = 32, MONO_TABLE_CUSTOMATTRIBUTE = 34, MONO_TABLE_FIELDMARSHAL = 38, MONO_TABLE_DECLSECURITY = 39, MONO_TABLE_CLASSLAYOUT = 8, MONO_TABLE_FIELDLAYOUT = 40, MONO_TABLE_STANDALONESIG = 41, MONO_TABLE_EVENTMAP = 42, MONO_TABLE_EVENT_POINTER = 43, MONO_TABLE_EVENT = 44, MONO_TABLE_PROPERTYMAP = 45, MONO_TABLE_PROPERTY_POINTER = 46, MONO_TABLE_PROPERTY = 58, MONO_TABLE_METHODSEMANTICS = 21, MONO_TABLE_METHODIMPL = 47, MONO_TABLE_MODULEREF = 59, MONO_TABLE_TYPESPEC = 48, MONO_TABLE_IMPLMAP = 27, MONO_TABLE_FIELDRVA = 49, MONO_TABLE_UNUSED6 = 50, MONO_TABLE_UNUSED7 = 51, MONO_TABLE_ASSEMBLY = 52, MONO_TABLE_ASSEMBLYPROCESSOR = 53, MONO_TABLE_ASSEMBLYOS = 60, MONO_TABLE_ASSEMBLYREF = 61, MONO_TABLE_ASSEMBLYREFPROCESSOR = 62, MONO_TABLE_ASSEMBLYREFOS = 63, MONO_TABLE_FILE = 64, MONO_TABLE_EXPORTEDTYPE = 65, MONO_TABLE_MANIFESTRESOURCE = 66, MONO_TABLE_NESTEDCLASS = 67, MONO_TABLE_GENERICPARAM = 68, MONO_TABLE_METHODSPEC = 69, MONO_TABLE_GENERICPARAMCONSTRAINT = 70, MONO_TABLE_UNUSED8 = 71, MONO_TABLE_UNUSED9 = 72, MONO_TABLE_UNUSED10 = 73, MONO_TABLE_DOCUMENT = 74, MONO_TABLE_METHODBODY = 75, MONO_TABLE_LOCALSCOPE = 76, MONO_TABLE_LOCALVARIABLE = 77, MONO_TABLE_LOCALCONSTANT = 78, MONO_TABLE_IMPORTSCOPE = 79, MONO_TABLE_ASYNCMETHOD = 80, MONO_TABLE_CUSTOMDEBUGINFORMATION = 81);

  mono.metadata.__Global = class
  private

    class var MONO_ASSEMBLY_HASH_ALG: Int32; public;
    class var MONO_ASSEMBLY_MAJOR_VERSION: Int32; public;
    class var MONO_ASSEMBLY_MINOR_VERSION: Int32; public;
    class var MONO_ASSEMBLY_BUILD_NUMBER: Int32; public;
    class var MONO_ASSEMBLY_REV_NUMBER: Int32; public;
    class var MONO_ASSEMBLY_FLAGS: Int32; public;
    class var MONO_ASSEMBLY_PUBLIC_KEY: Int32; public;
    class var MONO_ASSEMBLY_NAME: Int32; public;
    class var MONO_ASSEMBLY_CULTURE: Int32; public;
    class var MONO_ASSEMBLY_SIZE: Int32; public;
    class var MONO_ASSEMBLYOS_PLATFORM: Int32; public;
    class var MONO_ASSEMBLYOS_MAJOR_VERSION: Int32; public;
    class var MONO_ASSEMBLYOS_MINOR_VERSION: Int32; public;
    class var MONO_ASSEMBLYOS_SIZE: Int32; public;
    class var MONO_ASSEMBLY_PROCESSOR: Int32; public;
    class var MONO_ASSEMBLY_PROCESSOR_SIZE: Int32; public;
    class var MONO_ASSEMBLYREF_MAJOR_VERSION: Int32; public;
    class var MONO_ASSEMBLYREF_MINOR_VERSION: Int32; public;
    class var MONO_ASSEMBLYREF_BUILD_NUMBER: Int32; public;
    class var MONO_ASSEMBLYREF_REV_NUMBER: Int32; public;
    class var MONO_ASSEMBLYREF_FLAGS: Int32; public;
    class var MONO_ASSEMBLYREF_PUBLIC_KEY: Int32; public;
    class var MONO_ASSEMBLYREF_NAME: Int32; public;
    class var MONO_ASSEMBLYREF_CULTURE: Int32; public;
    class var MONO_ASSEMBLYREF_HASH_VALUE: Int32; public;
    class var MONO_ASSEMBLYREF_SIZE: Int32; public;
    class var MONO_ASSEMBLYREFOS_PLATFORM: Int32; public;
    class var MONO_ASSEMBLYREFOS_MAJOR_VERSION: Int32; public;
    class var MONO_ASSEMBLYREFOS_MINOR_VERSION: Int32; public;
    class var MONO_ASSEMBLYREFOS_ASSEMBLYREF: Int32; public;
    class var MONO_ASSEMBLYREFOS_SIZE: Int32; public;
    class var MONO_ASSEMBLYREFPROC_PROCESSOR: Int32; public;
    class var MONO_ASSEMBLYREFPROC_ASSEMBLYREF: Int32; public;
    class var MONO_ASSEMBLYREFPROC_SIZE: Int32; public;
    class var MONO_CLASS_LAYOUT_PACKING_SIZE: Int32; public;
    class var MONO_CLASS_LAYOUT_CLASS_SIZE: Int32; public;
    class var MONO_CLASS_LAYOUT_PARENT: Int32; public;
    class var MONO_CLASS_LAYOUT_SIZE: Int32; public;
    class var MONO_CONSTANT_TYPE: Int32; public;
    class var MONO_CONSTANT_PADDING: Int32; public;
    class var MONO_CONSTANT_PARENT: Int32; public;
    class var MONO_CONSTANT_VALUE: Int32; public;
    class var MONO_CONSTANT_SIZE: Int32; public;
    class var MONO_CUSTOM_ATTR_PARENT: Int32; public;
    class var MONO_CUSTOM_ATTR_TYPE: Int32; public;
    class var MONO_CUSTOM_ATTR_VALUE: Int32; public;
    class var MONO_CUSTOM_ATTR_SIZE: Int32; public;
    class var MONO_DECL_SECURITY_ACTION: Int32; public;
    class var MONO_DECL_SECURITY_PARENT: Int32; public;
    class var MONO_DECL_SECURITY_PERMISSIONSET: Int32; public;
    class var MONO_DECL_SECURITY_SIZE: Int32; public;
    class var MONO_EVENT_MAP_PARENT: Int32; public;
    class var MONO_EVENT_MAP_EVENTLIST: Int32; public;
    class var MONO_EVENT_MAP_SIZE: Int32; public;
    class var MONO_EVENT_FLAGS: Int32; public;
    class var MONO_EVENT_NAME: Int32; public;
    class var MONO_EVENT_TYPE: Int32; public;
    class var MONO_EVENT_SIZE: Int32; public;
    class var MONO_EVENT_POINTER_EVENT: Int32; public;
    class var MONO_EVENT_POINTER_SIZE: Int32; public;
    class var MONO_EXP_TYPE_FLAGS: Int32; public;
    class var MONO_EXP_TYPE_TYPEDEF: Int32; public;
    class var MONO_EXP_TYPE_NAME: Int32; public;
    class var MONO_EXP_TYPE_NAMESPACE: Int32; public;
    class var MONO_EXP_TYPE_IMPLEMENTATION: Int32; public;
    class var MONO_EXP_TYPE_SIZE: Int32; public;
    class var MONO_FIELD_FLAGS: Int32; public;
    class var MONO_FIELD_NAME: Int32; public;
    class var MONO_FIELD_SIGNATURE: Int32; public;
    class var MONO_FIELD_SIZE: Int32; public;
    class var MONO_FIELD_LAYOUT_OFFSET: Int32; public;
    class var MONO_FIELD_LAYOUT_FIELD: Int32; public;
    class var MONO_FIELD_LAYOUT_SIZE: Int32; public;
    class var MONO_FIELD_MARSHAL_PARENT: Int32; public;
    class var MONO_FIELD_MARSHAL_NATIVE_TYPE: Int32; public;
    class var MONO_FIELD_MARSHAL_SIZE: Int32; public;
    class var MONO_FIELD_POINTER_FIELD: Int32; public;
    class var MONO_FIELD_POINTER_SIZE: Int32; public;
    class var MONO_FIELD_RVA_RVA: Int32; public;
    class var MONO_FIELD_RVA_FIELD: Int32; public;
    class var MONO_FIELD_RVA_SIZE: Int32; public;
    class var MONO_FILE_FLAGS: Int32; public;
    class var MONO_FILE_NAME: Int32; public;
    class var MONO_FILE_HASH_VALUE: Int32; public;
    class var MONO_FILE_SIZE: Int32; public;
    class var MONO_IMPLMAP_FLAGS: Int32; public;
    class var MONO_IMPLMAP_MEMBER: Int32; public;
    class var MONO_IMPLMAP_NAME: Int32; public;
    class var MONO_IMPLMAP_SCOPE: Int32; public;
    class var MONO_IMPLMAP_SIZE: Int32; public;
    class var MONO_INTERFACEIMPL_CLASS: Int32; public;
    class var MONO_INTERFACEIMPL_INTERFACE: Int32; public;
    class var MONO_INTERFACEIMPL_SIZE: Int32; public;
    class var MONO_MANIFEST_OFFSET: Int32; public;
    class var MONO_MANIFEST_FLAGS: Int32; public;
    class var MONO_MANIFEST_NAME: Int32; public;
    class var MONO_MANIFEST_IMPLEMENTATION: Int32; public;
    class var MONO_MANIFEST_SIZE: Int32; public;
    class var MONO_MEMBERREF_CLASS: Int32; public;
    class var MONO_MEMBERREF_NAME: Int32; public;
    class var MONO_MEMBERREF_SIGNATURE: Int32; public;
    class var MONO_MEMBERREF_SIZE: Int32; public;
    class var MONO_METHOD_RVA: Int32; public;
    class var MONO_METHOD_IMPLFLAGS: Int32; public;
    class var MONO_METHOD_FLAGS: Int32; public;
    class var MONO_METHOD_NAME: Int32; public;
    class var MONO_METHOD_SIGNATURE: Int32; public;
    class var MONO_METHOD_PARAMLIST: Int32; public;
    class var MONO_METHOD_SIZE: Int32; public;
    class var MONO_METHODIMPL_CLASS: Int32; public;
    class var MONO_METHODIMPL_BODY: Int32; public;
    class var MONO_METHODIMPL_DECLARATION: Int32; public;
    class var MONO_METHODIMPL_SIZE: Int32; public;
    class var MONO_METHOD_POINTER_METHOD: Int32; public;
    class var MONO_METHOD_POINTER_SIZE: Int32; public;
    class var MONO_METHOD_SEMA_SEMANTICS: Int32; public;
    class var MONO_METHOD_SEMA_METHOD: Int32; public;
    class var MONO_METHOD_SEMA_ASSOCIATION: Int32; public;
    class var MONO_METHOD_SEMA_SIZE: Int32; public;
    class var MONO_MODULE_GENERATION: Int32; public;
    class var MONO_MODULE_NAME: Int32; public;
    class var MONO_MODULE_MVID: Int32; public;
    class var MONO_MODULE_ENC: Int32; public;
    class var MONO_MODULE_ENCBASE: Int32; public;
    class var MONO_MODULE_SIZE: Int32; public;
    class var MONO_MODULEREF_NAME: Int32; public;
    class var MONO_MODULEREF_SIZE: Int32; public;
    class var MONO_NESTED_CLASS_NESTED: Int32; public;
    class var MONO_NESTED_CLASS_ENCLOSING: Int32; public;
    class var MONO_NESTED_CLASS_SIZE: Int32; public;
    class var MONO_PARAM_FLAGS: Int32; public;
    class var MONO_PARAM_SEQUENCE: Int32; public;
    class var MONO_PARAM_NAME: Int32; public;
    class var MONO_PARAM_SIZE: Int32; public;
    class var MONO_PARAM_POINTER_PARAM: Int32; public;
    class var MONO_PARAM_POINTER_SIZE: Int32; public;
    class var MONO_PROPERTY_FLAGS: Int32; public;
    class var MONO_PROPERTY_NAME: Int32; public;
    class var MONO_PROPERTY_TYPE: Int32; public;
    class var MONO_PROPERTY_SIZE: Int32; public;
    class var MONO_PROPERTY_POINTER_PROPERTY: Int32; public;
    class var MONO_PROPERTY_POINTER_SIZE: Int32; public;
    class var MONO_PROPERTY_MAP_PARENT: Int32; public;
    class var MONO_PROPERTY_MAP_PROPERTY_LIST: Int32; public;
    class var MONO_PROPERTY_MAP_SIZE: Int32; public;
    class var MONO_STAND_ALONE_SIGNATURE: Int32; public;
    class var MONO_STAND_ALONE_SIGNATURE_SIZE: Int32; public;
    class var MONO_TYPEDEF_FLAGS: Int32; public;
    class var MONO_TYPEDEF_NAME: Int32; public;
    class var MONO_TYPEDEF_NAMESPACE: Int32; public;
    class var MONO_TYPEDEF_EXTENDS: Int32; public;
    class var MONO_TYPEDEF_FIELD_LIST: Int32; public;
    class var MONO_TYPEDEF_METHOD_LIST: Int32; public;
    class var MONO_TYPEDEF_SIZE: Int32; public;
    class var MONO_TYPEREF_SCOPE: Int32; public;
    class var MONO_TYPEREF_NAME: Int32; public;
    class var MONO_TYPEREF_NAMESPACE: Int32; public;
    class var MONO_TYPEREF_SIZE: Int32; public;
    class var MONO_TYPESPEC_SIGNATURE: Int32; public;
    class var MONO_TYPESPEC_SIZE: Int32; public;
    class var MONO_GENERICPARAM_NUMBER: Int32; public;
    class var MONO_GENERICPARAM_FLAGS: Int32; public;
    class var MONO_GENERICPARAM_OWNER: Int32; public;
    class var MONO_GENERICPARAM_NAME: Int32; public;
    class var MONO_GENERICPARAM_SIZE: Int32; public;
    class var MONO_METHODSPEC_METHOD: Int32; public;
    class var MONO_METHODSPEC_SIGNATURE: Int32; public;
    class var MONO_METHODSPEC_SIZE: Int32; public;
    class var MONO_GENPARCONSTRAINT_GENERICPAR: Int32; public;
    class var MONO_GENPARCONSTRAINT_CONSTRAINT: Int32; public;
    class var MONO_GENPARCONSTRAINT_SIZE: Int32; public;
    class var MONO_DOCUMENT_NAME: Int32; public;
    class var MONO_DOCUMENT_HASHALG: Int32; public;
    class var MONO_DOCUMENT_HASH: Int32; public;
    class var MONO_DOCUMENT_LANGUAGE: Int32; public;
    class var MONO_DOCUMENT_SIZE: Int32; public;
    class var MONO_METHODBODY_DOCUMENT: Int32; public;
    class var MONO_METHODBODY_SEQ_POINTS: Int32; public;
    class var MONO_METHODBODY_SIZE: Int32; public;
    class var MONO_LOCALSCOPE_METHOD: Int32; public;
    class var MONO_LOCALSCOPE_IMPORTSCOPE: Int32; public;
    class var MONO_LOCALSCOPE_VARIABLELIST: Int32; public;
    class var MONO_LOCALSCOPE_CONSTANTLIST: Int32; public;
    class var MONO_LOCALSCOPE_STARTOFFSET: Int32; public;
    class var MONO_LOCALSCOPE_LENGTH: Int32; public;
    class var MONO_LOCALSCOPE_SIZE: Int32; public;
    class var MONO_LOCALVARIABLE_ATTRIBUTES: Int32; public;
    class var MONO_LOCALVARIABLE_INDEX: Int32; public;
    class var MONO_LOCALVARIABLE_NAME: Int32; public;
    class var MONO_LOCALVARIABLE_SIZE: Int32; public;
    class var MONO_TYPEDEFORREF_TYPEDEF: Int32; public;
    class var MONO_TYPEDEFORREF_TYPEREF: Int32; public;
    class var MONO_TYPEDEFORREF_TYPESPEC: Int32; public;
    class var MONO_TYPEDEFORREF_BITS: Int32; public;
    class var MONO_TYPEDEFORREF_MASK: Int32; public;
    class var MONO_HASCONSTANT_FIEDDEF: Int32; public;
    class var MONO_HASCONSTANT_PARAM: Int32; public;
    class var MONO_HASCONSTANT_PROPERTY: Int32; public;
    class var MONO_HASCONSTANT_BITS: Int32; public;
    class var MONO_HASCONSTANT_MASK: Int32; public;
    class var MONO_CUSTOM_ATTR_METHODDEF: Int32; public;
    class var MONO_CUSTOM_ATTR_FIELDDEF: Int32; public;
    class var MONO_CUSTOM_ATTR_TYPEREF: Int32; public;
    class var MONO_CUSTOM_ATTR_TYPEDEF: Int32; public;
    class var MONO_CUSTOM_ATTR_PARAMDEF: Int32; public;
    class var MONO_CUSTOM_ATTR_INTERFACE: Int32; public;
    class var MONO_CUSTOM_ATTR_MEMBERREF: Int32; public;
    class var MONO_CUSTOM_ATTR_MODULE: Int32; public;
    class var MONO_CUSTOM_ATTR_PERMISSION: Int32; public;
    class var MONO_CUSTOM_ATTR_PROPERTY: Int32; public;
    class var MONO_CUSTOM_ATTR_EVENT: Int32; public;
    class var MONO_CUSTOM_ATTR_SIGNATURE: Int32; public;
    class var MONO_CUSTOM_ATTR_MODULEREF: Int32; public;
    class var MONO_CUSTOM_ATTR_TYPESPEC: Int32; public;
    class var MONO_CUSTOM_ATTR_ASSEMBLY: Int32; public;
    class var MONO_CUSTOM_ATTR_ASSEMBLYREF: Int32; public;
    class var MONO_CUSTOM_ATTR_FILE: Int32; public;
    class var MONO_CUSTOM_ATTR_EXP_TYPE: Int32; public;
    class var MONO_CUSTOM_ATTR_MANIFEST: Int32; public;
    class var MONO_CUSTOM_ATTR_GENERICPAR: Int32; public;
    class var MONO_CUSTOM_ATTR_BITS: Int32; public;
    class var MONO_CUSTOM_ATTR_MASK: Int32; public;
    class var MONO_HAS_FIELD_MARSHAL_FIELDSREF: Int32; public;
    class var MONO_HAS_FIELD_MARSHAL_PARAMDEF: Int32; public;
    class var MONO_HAS_FIELD_MARSHAL_BITS: Int32; public;
    class var MONO_HAS_FIELD_MARSHAL_MASK: Int32; public;
    class var MONO_HAS_DECL_SECURITY_TYPEDEF: Int32; public;
    class var MONO_HAS_DECL_SECURITY_METHODDEF: Int32; public;
    class var MONO_HAS_DECL_SECURITY_ASSEMBLY: Int32; public;
    class var MONO_HAS_DECL_SECURITY_BITS: Int32; public;
    class var MONO_HAS_DECL_SECURITY_MASK: Int32; public;
    class var MONO_MEMBERREF_PARENT_TYPEDEF: Int32; public;
    class var MONO_MEMBERREF_PARENT_TYPEREF: Int32; public;
    class var MONO_MEMBERREF_PARENT_MODULEREF: Int32; public;
    class var MONO_MEMBERREF_PARENT_METHODDEF: Int32; public;
    class var MONO_MEMBERREF_PARENT_TYPESPEC: Int32; public;
    class var MONO_MEMBERREF_PARENT_BITS: Int32; public;
    class var MONO_MEMBERREF_PARENT_MASK: Int32; public;
    class var MONO_HAS_SEMANTICS_EVENT: Int32; public;
    class var MONO_HAS_SEMANTICS_PROPERTY: Int32; public;
    class var MONO_HAS_SEMANTICS_BITS: Int32; public;
    class var MONO_HAS_SEMANTICS_MASK: Int32; public;
    class var MONO_METHODDEFORREF_METHODDEF: Int32; public;
    class var MONO_METHODDEFORREF_METHODREF: Int32; public;
    class var MONO_METHODDEFORREF_BITS: Int32; public;
    class var MONO_METHODDEFORREF_MASK: Int32; public;
    class var MONO_MEMBERFORWD_FIELDDEF: Int32; public;
    class var MONO_MEMBERFORWD_METHODDEF: Int32; public;
    class var MONO_MEMBERFORWD_BITS: Int32; public;
    class var MONO_MEMBERFORWD_MASK: Int32; public;
    class var MONO_IMPLEMENTATION_FILE: Int32; public;
    class var MONO_IMPLEMENTATION_ASSEMBLYREF: Int32; public;
    class var MONO_IMPLEMENTATION_EXP_TYPE: Int32; public;
    class var MONO_IMPLEMENTATION_BITS: Int32; public;
    class var MONO_IMPLEMENTATION_MASK: Int32; public;
    class var MONO_CUSTOM_ATTR_TYPE_TYPEREF: Int32; public;
    class var MONO_CUSTOM_ATTR_TYPE_TYPEDEF: Int32; public;
    class var MONO_CUSTOM_ATTR_TYPE_METHODDEF: Int32; public;
    class var MONO_CUSTOM_ATTR_TYPE_MEMBERREF: Int32; public;
    class var MONO_CUSTOM_ATTR_TYPE_STRING: Int32; public;
    class var MONO_CUSTOM_ATTR_TYPE_BITS: Int32; public;
    class var MONO_CUSTOM_ATTR_TYPE_MASK: Int32; public;
    class var MONO_RESOLUTION_SCOPE_MODULE: Int32; public;
    class var MONO_RESOLUTION_SCOPE_MODULEREF: Int32; public;
    class var MONO_RESOLUTION_SCOPE_ASSEMBLYREF: Int32; public;
    class var MONO_RESOLUTION_SCOPE_TYPEREF: Int32; public;
    class var MONO_RESOLUTION_SCOPE_BITS: Int32; public;
    class var MONO_RESOLUTION_SCOPE_MASK: Int32; public;
    class var MONO_RESOLTION_SCOPE_MODULE: Int32; public;
    class var MONO_RESOLTION_SCOPE_MODULEREF: Int32; public;
    class var MONO_RESOLTION_SCOPE_ASSEMBLYREF: Int32; public;
    class var MONO_RESOLTION_SCOPE_TYPEREF: Int32; public;
    class var MONO_RESOLTION_SCOPE_BITS: Int32; public;
    class var MONO_RESOLTION_SCOPE_MASK: Int32; public;
    class var MONO_TYPEORMETHOD_TYPE: Int32; public;
    class var MONO_TYPEORMETHOD_METHOD: Int32; public;
    class var MONO_TYPEORMETHOD_BITS: Int32; public;
    class var MONO_TYPEORMETHOD_MASK: Int32; public;
    class method mono_images_init: Void; public;
    begin
    end;
    class method mono_images_cleanup: Void; public;
    begin
    end;
    class method mono_image_open(fname: ^AnsiChar; status: ^mono.metadata.MonoImageOpenStatus): ^MonoImage; public;
    begin
    end;
    class method mono_image_open_full(fname: ^AnsiChar; status: ^mono.metadata.MonoImageOpenStatus; refonly: mono_bool): ^MonoImage; public;
    begin
    end;
    class method mono_pe_file_open(fname: ^AnsiChar; status: ^mono.metadata.MonoImageOpenStatus): ^MonoImage; public;
    begin
    end;
    class method mono_image_open_from_data(data: ^AnsiChar; data_len: uint32_t; need_copy: mono_bool; status: ^mono.metadata.MonoImageOpenStatus): ^MonoImage; public;
    begin
    end;
    class method mono_image_open_from_data_full(data: ^AnsiChar; data_len: uint32_t; need_copy: mono_bool; status: ^mono.metadata.MonoImageOpenStatus; refonly: mono_bool): ^MonoImage; public;
    begin
    end;
    class method mono_image_open_from_data_with_name(data: ^AnsiChar; data_len: uint32_t; need_copy: mono_bool; status: ^mono.metadata.MonoImageOpenStatus; refonly: mono_bool; name: ^AnsiChar): ^MonoImage; public;
    begin
    end;
    class method mono_image_fixup_vtable(image: ^MonoImage): Void; public;
    begin
    end;
    class method mono_image_loaded(name: ^AnsiChar): ^MonoImage; public;
    begin
    end;
    class method mono_image_loaded_full(name: ^AnsiChar; refonly: mono_bool): ^MonoImage; public;
    begin
    end;
    class method mono_image_loaded_by_guid(guid: ^AnsiChar): ^MonoImage; public;
    begin
    end;
    class method mono_image_loaded_by_guid_full(guid: ^AnsiChar; refonly: mono_bool): ^MonoImage; public;
    begin
    end;
    class method mono_image_init(image: ^MonoImage): Void; public;
    begin
    end;
    class method mono_image_close(image: ^MonoImage): Void; public;
    begin
    end;
    class method mono_image_addref(image: ^MonoImage): Void; public;
    begin
    end;
    class method mono_image_strerror(status: mono.metadata.MonoImageOpenStatus): ^AnsiChar; public;
    begin
    end;
    class method mono_image_ensure_section(image: ^MonoImage; section: ^AnsiChar): Int32; public;
    begin
    end;
    class method mono_image_ensure_section_idx(image: ^MonoImage; section: Int32): Int32; public;
    begin
    end;
    class method mono_image_get_entry_point(image: ^MonoImage): uint32_t; public;
    begin
    end;
    class method mono_image_get_resource(image: ^MonoImage; offset: uint32_t; size: ^uint32_t): ^AnsiChar; public;
    begin
    end;
    class method mono_image_load_file_for_image(image: ^MonoImage; fileidx: Int32): ^MonoImage; public;
    begin
    end;
    class method mono_image_load_module(image: ^MonoImage; idx: Int32): ^MonoImage; public;
    begin
    end;
    class method mono_image_get_name(image: ^MonoImage): ^AnsiChar; public;
    begin
    end;
    class method mono_image_get_filename(image: ^MonoImage): ^AnsiChar; public;
    begin
    end;
    class method mono_image_get_guid(image: ^MonoImage): ^AnsiChar; public;
    begin
    end;
    class method mono_image_get_assembly(image: ^MonoImage): ^MonoAssembly; public;
    begin
    end;
    class method mono_image_is_dynamic(image: ^MonoImage): mono_bool; public;
    begin
    end;
    class method mono_image_rva_map(image: ^MonoImage; rva: uint32_t): ^AnsiChar; public;
    begin
    end;
    class method mono_image_get_table_info(image: ^MonoImage; table_id: Int32): ^MonoTableInfo; public;
    begin
    end;
    class method mono_image_get_table_rows(image: ^MonoImage; table_id: Int32): Int32; public;
    begin
    end;
    class method mono_table_info_get_rows(table: ^MonoTableInfo): Int32; public;
    begin
    end;
    class method mono_image_lookup_resource(image: ^MonoImage; res_id: uint32_t; lang_id: uint32_t; name: ^mono_unichar2): ^Void; public;
    begin
    end;
    class method mono_image_get_public_key(image: ^MonoImage; size: ^uint32_t): ^AnsiChar; public;
    begin
    end;
    class method mono_image_get_strong_name(image: ^MonoImage; size: ^uint32_t): ^AnsiChar; public;
    begin
    end;
    class method mono_image_strong_name_position(image: ^MonoImage; size: ^uint32_t): uint32_t; public;
    begin
    end;
    class method mono_image_add_to_name_cache(image: ^MonoImage; nspace: ^AnsiChar; name: ^AnsiChar; idx: uint32_t): Void; public;
    begin
    end;
    class method mono_image_has_authenticode_entry(image: ^MonoImage): mono_bool; public;
    begin
    end;
    class method mono_metadata_init: Void; public;
    begin
    end;
    class method mono_metadata_decode_row(t: ^MonoTableInfo; idx: Int32; res: ^uint32_t; res_size: Int32): Void; public;
    begin
    end;
    class method mono_metadata_decode_row_col(t: ^MonoTableInfo; idx: Int32; col: UInt32): uint32_t; public;
    begin
    end;
    class method mono_metadata_compute_size(meta: ^MonoImage; tableindex: Int32; result_bitfield: ^uint32_t): Int32; public;
    begin
    end;
    class method mono_metadata_locate(meta: ^MonoImage; table: Int32; idx: Int32): ^AnsiChar; public;
    begin
    end;
    class method mono_metadata_locate_token(meta: ^MonoImage; token: uint32_t): ^AnsiChar; public;
    begin
    end;
    class method mono_metadata_string_heap(meta: ^MonoImage; table_index: uint32_t): ^AnsiChar; public;
    begin
    end;
    class method mono_metadata_blob_heap(meta: ^MonoImage; table_index: uint32_t): ^AnsiChar; public;
    begin
    end;
    class method mono_metadata_user_string(meta: ^MonoImage; table_index: uint32_t): ^AnsiChar; public;
    begin
    end;
    class method mono_metadata_guid_heap(meta: ^MonoImage; table_index: uint32_t): ^AnsiChar; public;
    begin
    end;
    class method mono_metadata_typedef_from_field(meta: ^MonoImage; table_index: uint32_t): uint32_t; public;
    begin
    end;
    class method mono_metadata_typedef_from_method(meta: ^MonoImage; table_index: uint32_t): uint32_t; public;
    begin
    end;
    class method mono_metadata_nested_in_typedef(meta: ^MonoImage; table_index: uint32_t): uint32_t; public;
    begin
    end;
    class method mono_metadata_nesting_typedef(meta: ^MonoImage; table_index: uint32_t; start_index: uint32_t): uint32_t; public;
    begin
    end;
    class method mono_metadata_interfaces_from_typedef(meta: ^MonoImage; table_index: uint32_t; count: ^UInt32): ^^MonoClass; public;
    begin
    end;
    class method mono_metadata_events_from_typedef(meta: ^MonoImage; table_index: uint32_t; end_idx: ^UInt32): uint32_t; public;
    begin
    end;
    class method mono_metadata_methods_from_event(meta: ^MonoImage; table_index: uint32_t; &end: ^UInt32): uint32_t; public;
    begin
    end;
    class method mono_metadata_properties_from_typedef(meta: ^MonoImage; table_index: uint32_t; &end: ^UInt32): uint32_t; public;
    begin
    end;
    class method mono_metadata_methods_from_property(meta: ^MonoImage; table_index: uint32_t; &end: ^UInt32): uint32_t; public;
    begin
    end;
    class method mono_metadata_packing_from_typedef(meta: ^MonoImage; table_index: uint32_t; packing: ^uint32_t; size: ^uint32_t): uint32_t; public;
    begin
    end;
    class method mono_metadata_get_marshal_info(meta: ^MonoImage; idx: uint32_t; is_field: mono_bool): ^AnsiChar; public;
    begin
    end;
    class method mono_metadata_custom_attrs_from_index(meta: ^MonoImage; cattr_index: uint32_t): uint32_t; public;
    begin
    end;
    class method mono_metadata_parse_marshal_spec(image: ^MonoImage; ptr: ^AnsiChar): ^mono.metadata.MonoMarshalSpec; public;
    begin
    end;
    class method mono_metadata_free_marshal_spec(spec: ^mono.metadata.MonoMarshalSpec): Void; public;
    begin
    end;
    class method mono_metadata_implmap_from_method(meta: ^MonoImage; method_idx: uint32_t): uint32_t; public;
    begin
    end;
    class method mono_metadata_field_info(meta: ^MonoImage; table_index: uint32_t; offset: ^uint32_t; rva: ^uint32_t; marshal_spec: ^^mono.metadata.MonoMarshalSpec): Void; public;
    begin
    end;
    class method mono_metadata_get_constant_index(meta: ^MonoImage; token: uint32_t; hint: uint32_t): uint32_t; public;
    begin
    end;
    class method mono_metadata_decode_value(ptr: ^AnsiChar; rptr: ^^AnsiChar): uint32_t; public;
    begin
    end;
    class method mono_metadata_decode_signed_value(ptr: ^AnsiChar; rptr: ^^AnsiChar): int32_t; public;
    begin
    end;
    class method mono_metadata_decode_blob_size(ptr: ^AnsiChar; rptr: ^^AnsiChar): uint32_t; public;
    begin
    end;
    class method mono_metadata_encode_value(value: uint32_t; bug: ^AnsiChar; endbuf: ^^AnsiChar): Void; public;
    begin
    end;
    class method mono_type_is_byref(&type: ^MonoType): mono_bool; public;
    begin
    end;
    class method mono_type_get_type(&type: ^MonoType): Int32; public;
    begin
    end;
    class method mono_type_get_signature(&type: ^MonoType): ^MonoMethodSignature; public;
    begin
    end;
    class method mono_type_get_class(&type: ^MonoType): ^MonoClass; public;
    begin
    end;
    class method mono_type_get_array_type(&type: ^MonoType): ^MonoArrayType; public;
    begin
    end;
    class method mono_type_get_ptr_type(&type: ^MonoType): ^MonoType; public;
    begin
    end;
    class method mono_type_get_modifiers(&type: ^MonoType; is_required: ^mono_bool; iter: ^^Void): ^MonoClass; public;
    begin
    end;
    class method mono_type_is_struct(&type: ^MonoType): mono_bool; public;
    begin
    end;
    class method mono_type_is_void(&type: ^MonoType): mono_bool; public;
    begin
    end;
    class method mono_type_is_pointer(&type: ^MonoType): mono_bool; public;
    begin
    end;
    class method mono_type_is_reference(&type: ^MonoType): mono_bool; public;
    begin
    end;
    class method mono_type_is_generic_parameter(&type: ^MonoType): mono_bool; public;
    begin
    end;
    class method mono_signature_get_return_type(sig: ^MonoMethodSignature): ^MonoType; public;
    begin
    end;
    class method mono_signature_get_params(sig: ^MonoMethodSignature; iter: ^^Void): ^MonoType; public;
    begin
    end;
    class method mono_signature_get_param_count(sig: ^MonoMethodSignature): uint32_t; public;
    begin
    end;
    class method mono_signature_get_call_conv(sig: ^MonoMethodSignature): uint32_t; public;
    begin
    end;
    class method mono_signature_vararg_start(sig: ^MonoMethodSignature): Int32; public;
    begin
    end;
    class method mono_signature_is_instance(sig: ^MonoMethodSignature): mono_bool; public;
    begin
    end;
    class method mono_signature_explicit_this(sig: ^MonoMethodSignature): mono_bool; public;
    begin
    end;
    class method mono_signature_param_is_out(sig: ^MonoMethodSignature; param_num: Int32): mono_bool; public;
    begin
    end;
    class method mono_metadata_parse_typedef_or_ref(m: ^MonoImage; ptr: ^AnsiChar; rptr: ^^AnsiChar): uint32_t; public;
    begin
    end;
    class method mono_metadata_parse_custom_mod(m: ^MonoImage; dest: ^mono.metadata.MonoCustomMod; ptr: ^AnsiChar; rptr: ^^AnsiChar): Int32; public;
    begin
    end;
    class method mono_metadata_parse_array(m: ^MonoImage; ptr: ^AnsiChar; rptr: ^^AnsiChar): ^MonoArrayType; public;
    begin
    end;
    class method mono_metadata_free_array(&array: ^MonoArrayType): Void; public;
    begin
    end;
    class method mono_metadata_parse_type(m: ^MonoImage; mode: mono.metadata.MonoParseTypeMode; opt_attrs: Int16; ptr: ^AnsiChar; rptr: ^^AnsiChar): ^MonoType; public;
    begin
    end;
    class method mono_metadata_parse_param(m: ^MonoImage; ptr: ^AnsiChar; rptr: ^^AnsiChar): ^MonoType; public;
    begin
    end;
    class method mono_metadata_parse_ret_type(m: ^MonoImage; ptr: ^AnsiChar; rptr: ^^AnsiChar): ^MonoType; public;
    begin
    end;
    class method mono_metadata_parse_field_type(m: ^MonoImage; field_flags: Int16; ptr: ^AnsiChar; rptr: ^^AnsiChar): ^MonoType; public;
    begin
    end;
    class method mono_type_create_from_typespec(image: ^MonoImage; type_spec: uint32_t): ^MonoType; public;
    begin
    end;
    class method mono_metadata_free_type(&type: ^MonoType): Void; public;
    begin
    end;
    class method mono_type_size(&type: ^MonoType; alignment: ^Int32): Int32; public;
    begin
    end;
    class method mono_type_stack_size(&type: ^MonoType; alignment: ^Int32): Int32; public;
    begin
    end;
    class method mono_type_generic_inst_is_valuetype(&type: ^MonoType): mono_bool; public;
    begin
    end;
    class method mono_metadata_generic_class_is_valuetype(gclass: ^MonoGenericClass): mono_bool; public;
    begin
    end;
    class method mono_metadata_generic_class_hash(gclass: ^MonoGenericClass): UInt32; public;
    begin
    end;
    class method mono_metadata_generic_class_equal(g1: ^MonoGenericClass; g2: ^MonoGenericClass): mono_bool; public;
    begin
    end;
    class method mono_metadata_type_hash(t1: ^MonoType): UInt32; public;
    begin
    end;
    class method mono_metadata_type_equal(t1: ^MonoType; t2: ^MonoType): mono_bool; public;
    begin
    end;
    class method mono_metadata_signature_alloc(image: ^MonoImage; nparams: uint32_t): ^MonoMethodSignature; public;
    begin
    end;
    class method mono_metadata_signature_dup(sig: ^MonoMethodSignature): ^MonoMethodSignature; public;
    begin
    end;
    class method mono_metadata_parse_signature(image: ^MonoImage; token: uint32_t): ^MonoMethodSignature; public;
    begin
    end;
    class method mono_metadata_parse_method_signature(m: ^MonoImage; def: Int32; ptr: ^AnsiChar; rptr: ^^AnsiChar): ^MonoMethodSignature; public;
    begin
    end;
    class method mono_metadata_free_method_signature(&method: ^MonoMethodSignature): Void; public;
    begin
    end;
    class method mono_metadata_signature_equal(sig1: ^MonoMethodSignature; sig2: ^MonoMethodSignature): mono_bool; public;
    begin
    end;
    class method mono_signature_hash(sig: ^MonoMethodSignature): UInt32; public;
    begin
    end;
    class method mono_metadata_parse_mh(m: ^MonoImage; ptr: ^AnsiChar): ^MonoMethodHeader; public;
    begin
    end;
    class method mono_metadata_free_mh(mh: ^MonoMethodHeader): Void; public;
    begin
    end;
    class method mono_method_header_get_code(header: ^MonoMethodHeader; code_size: ^uint32_t; max_stack: ^uint32_t): ^Byte; public;
    begin
    end;
    class method mono_method_header_get_locals(header: ^MonoMethodHeader; num_locals: ^uint32_t; init_locals: ^mono_bool): ^^MonoType; public;
    begin
    end;
    class method mono_method_header_get_num_clauses(header: ^MonoMethodHeader): Int32; public;
    begin
    end;
    class method mono_method_header_get_clauses(header: ^MonoMethodHeader; &method: ^MonoMethod; iter: ^^Void; clause: ^mono.metadata.MonoExceptionClause): Int32; public;
    begin
    end;
    class method mono_type_to_unmanaged(&type: ^MonoType; mspec: ^mono.metadata.MonoMarshalSpec; as_field: mono_bool; unicode: mono_bool; conv: ^mono.metadata.MonoMarshalConv): uint32_t; public;
    begin
    end;
    class method mono_metadata_token_from_dor(dor_index: uint32_t): uint32_t; public;
    begin
    end;
    class method mono_guid_to_string(guid: ^uint8_t): ^AnsiChar; public;
    begin
    end;
    class method mono_guid_to_string_minimal(guid: ^uint8_t): ^AnsiChar; public;
    begin
    end;
    class method mono_metadata_declsec_from_index(meta: ^MonoImage; idx: uint32_t): uint32_t; public;
    begin
    end;
    class method mono_metadata_translate_token_index(image: ^MonoImage; table: Int32; idx: uint32_t): uint32_t; public;
    begin
    end;
    class method mono_metadata_decode_table_row(image: ^MonoImage; table: Int32; idx: Int32; res: ^uint32_t; res_size: Int32): Void; public;
    begin
    end;
    class method mono_metadata_decode_table_row_col(image: ^MonoImage; table: Int32; idx: Int32; col: UInt32): uint32_t; public;
    begin
    end;
    class method mono_get_method(image: ^MonoImage; token: uint32_t; klass: ^MonoClass): ^MonoMethod; public;
    begin
    end;
    class method mono_get_method_full(image: ^MonoImage; token: uint32_t; klass: ^MonoClass; context: ^MonoGenericContext): ^MonoMethod; public;
    begin
    end;
    class method mono_get_method_constrained(image: ^MonoImage; token: uint32_t; constrained_class: ^MonoClass; context: ^MonoGenericContext; cil_method: ^^MonoMethod): ^MonoMethod; public;
    begin
    end;
    class method mono_free_method(&method: ^MonoMethod): Void; public;
    begin
    end;
    class method mono_method_get_signature_full(&method: ^MonoMethod; image: ^MonoImage; token: uint32_t; context: ^MonoGenericContext): ^MonoMethodSignature; public;
    begin
    end;
    class method mono_method_get_signature(&method: ^MonoMethod; image: ^MonoImage; token: uint32_t): ^MonoMethodSignature; public;
    begin
    end;
    class method mono_method_signature(&method: ^MonoMethod): ^MonoMethodSignature; public;
    begin
    end;
    class method mono_method_get_header(&method: ^MonoMethod): ^MonoMethodHeader; public;
    begin
    end;
    class method mono_method_get_name(&method: ^MonoMethod): ^AnsiChar; public;
    begin
    end;
    class method mono_method_get_class(&method: ^MonoMethod): ^MonoClass; public;
    begin
    end;
    class method mono_method_get_token(&method: ^MonoMethod): uint32_t; public;
    begin
    end;
    class method mono_method_get_flags(&method: ^MonoMethod; iflags: ^uint32_t): uint32_t; public;
    begin
    end;
    class method mono_method_get_index(&method: ^MonoMethod): uint32_t; public;
    begin
    end;
    class method mono_load_image(fname: ^AnsiChar; status: ^mono.metadata.MonoImageOpenStatus): ^MonoImage; public;
    begin
    end;
    class method mono_add_internal_call(name: ^AnsiChar; &method: ^Void): Void; public;
    begin
    end;
    class method mono_lookup_internal_call(&method: ^MonoMethod): ^Void; public;
    begin
    end;
    class method mono_lookup_internal_call_full(&method: ^MonoMethod; uses_handles: ^mono_bool): ^Void; public;
    begin
    end;
    class method mono_lookup_icall_symbol(m: ^MonoMethod): ^AnsiChar; public;
    begin
    end;
    class method mono_dllmap_insert(&assembly: ^MonoImage; dll: ^AnsiChar; func: ^AnsiChar; tdll: ^AnsiChar; tfunc: ^AnsiChar): Void; public;
    begin
    end;
    class method mono_lookup_pinvoke_call(&method: ^MonoMethod; exc_class: ^^AnsiChar; exc_arg: ^^AnsiChar): ^Void; public;
    begin
    end;
    class method mono_method_get_param_names(&method: ^MonoMethod; names: ^^AnsiChar): Void; public;
    begin
    end;
    class method mono_method_get_param_token(&method: ^MonoMethod; idx: Int32): uint32_t; public;
    begin
    end;
    class method mono_method_get_marshal_info(&method: ^MonoMethod; mspecs: ^^mono.metadata.MonoMarshalSpec): Void; public;
    begin
    end;
    class method mono_method_has_marshal_info(&method: ^MonoMethod): mono_bool; public;
    begin
    end;
    class method mono_method_get_last_managed: ^MonoMethod; public;
    begin
    end;
    class method mono_stack_walk(func: method(&method: ^MonoMethod; native_offset: int32_t; il_offset: int32_t; managed: mono_bool; data: ^Void): mono_bool; user_data: ^Void): Void; public;
    begin
    end;
    class method mono_stack_walk_no_il(func: method(&method: ^MonoMethod; native_offset: int32_t; il_offset: int32_t; managed: mono_bool; data: ^Void): mono_bool; user_data: ^Void): Void; public;
    begin
    end;
    class method mono_stack_walk_async_safe(func: method(&method: ^MonoMethod; domain: ^MonoDomain; base_address: ^Void; offset: Int32; data: ^Void): mono_bool; initial_sig_context: ^Void; user_data: ^Void): Void; public;
    begin
    end;
    class method mono_method_get_header_checked(&method: ^MonoMethod; error: ^mono.utils.MonoError): ^MonoMethodHeader; public;
    begin
    end;
    class method mono_class_get(image: ^MonoImage; type_token: uint32_t): ^MonoClass; public;
    begin
    end;
    class method mono_class_get_full(image: ^MonoImage; type_token: uint32_t; context: ^MonoGenericContext): ^MonoClass; public;
    begin
    end;
    class method mono_class_init(klass: ^MonoClass): mono_bool; public;
    begin
    end;
    class method mono_class_vtable(domain: ^MonoDomain; klass: ^MonoClass): ^MonoVTable; public;
    begin
    end;
    class method mono_class_from_name(image: ^MonoImage; name_space: ^AnsiChar; name: ^AnsiChar): ^MonoClass; public;
    begin
    end;
    class method mono_class_from_name_case(image: ^MonoImage; name_space: ^AnsiChar; name: ^AnsiChar): ^MonoClass; public;
    begin
    end;
    class method mono_class_get_method_from_name_flags(klass: ^MonoClass; name: ^AnsiChar; param_count: Int32; &flags: Int32): ^MonoMethod; public;
    begin
    end;
    class method mono_class_from_typeref(image: ^MonoImage; type_token: uint32_t): ^MonoClass; public;
    begin
    end;
    class method mono_class_from_typeref_checked(image: ^MonoImage; type_token: uint32_t; error: ^mono.utils.MonoError): ^MonoClass; public;
    begin
    end;
    class method mono_class_from_generic_parameter(&param: ^MonoGenericParam; image: ^MonoImage; is_mvar: mono_bool): ^MonoClass; public;
    begin
    end;
    class method mono_class_inflate_generic_type(&type: ^MonoType; context: ^MonoGenericContext): ^MonoType; public;
    begin
    end;
    class method mono_class_inflate_generic_method(&method: ^MonoMethod; context: ^MonoGenericContext): ^MonoMethod; public;
    begin
    end;
    class method mono_get_inflated_method(&method: ^MonoMethod): ^MonoMethod; public;
    begin
    end;
    class method mono_field_from_token(image: ^MonoImage; token: uint32_t; retklass: ^^MonoClass; context: ^MonoGenericContext): ^MonoClassField; public;
    begin
    end;
    class method mono_bounded_array_class_get(element_class: ^MonoClass; rank: uint32_t; bounded: mono_bool): ^MonoClass; public;
    begin
    end;
    class method mono_array_class_get(element_class: ^MonoClass; rank: uint32_t): ^MonoClass; public;
    begin
    end;
    class method mono_ptr_class_get(&type: ^MonoType): ^MonoClass; public;
    begin
    end;
    class method mono_class_get_field(klass: ^MonoClass; field_token: uint32_t): ^MonoClassField; public;
    begin
    end;
    class method mono_class_get_field_from_name(klass: ^MonoClass; name: ^AnsiChar): ^MonoClassField; public;
    begin
    end;
    class method mono_class_get_field_token(field: ^MonoClassField): uint32_t; public;
    begin
    end;
    class method mono_class_get_event_token(&event: ^MonoEvent): uint32_t; public;
    begin
    end;
    class method mono_class_get_property_from_name(klass: ^MonoClass; name: ^AnsiChar): ^MonoProperty; public;
    begin
    end;
    class method mono_class_get_property_token(prop: ^MonoProperty): uint32_t; public;
    begin
    end;
    class method mono_array_element_size(ac: ^MonoClass): int32_t; public;
    begin
    end;
    class method mono_class_instance_size(klass: ^MonoClass): int32_t; public;
    begin
    end;
    class method mono_class_array_element_size(klass: ^MonoClass): int32_t; public;
    begin
    end;
    class method mono_class_data_size(klass: ^MonoClass): int32_t; public;
    begin
    end;
    class method mono_class_value_size(klass: ^MonoClass; align: ^uint32_t): int32_t; public;
    begin
    end;
    class method mono_class_min_align(klass: ^MonoClass): int32_t; public;
    begin
    end;
    class method mono_class_from_mono_type(&type: ^MonoType): ^MonoClass; public;
    begin
    end;
    class method mono_class_is_subclass_of(klass: ^MonoClass; klassc: ^MonoClass; check_interfaces: mono_bool): mono_bool; public;
    begin
    end;
    class method mono_class_is_assignable_from(klass: ^MonoClass; oklass: ^MonoClass): mono_bool; public;
    begin
    end;
    class method mono_ldtoken(image: ^MonoImage; token: uint32_t; retclass: ^^MonoClass; context: ^MonoGenericContext): ^Void; public;
    begin
    end;
    class method mono_type_get_name(&type: ^MonoType): ^AnsiChar; public;
    begin
    end;
    class method mono_type_get_underlying_type(&type: ^MonoType): ^MonoType; public;
    begin
    end;
    class method mono_class_get_image(klass: ^MonoClass): ^MonoImage; public;
    begin
    end;
    class method mono_class_get_element_class(klass: ^MonoClass): ^MonoClass; public;
    begin
    end;
    class method mono_class_is_valuetype(klass: ^MonoClass): mono_bool; public;
    begin
    end;
    class method mono_class_is_enum(klass: ^MonoClass): mono_bool; public;
    begin
    end;
    class method mono_class_enum_basetype(klass: ^MonoClass): ^MonoType; public;
    begin
    end;
    class method mono_class_get_parent(klass: ^MonoClass): ^MonoClass; public;
    begin
    end;
    class method mono_class_get_nesting_type(klass: ^MonoClass): ^MonoClass; public;
    begin
    end;
    class method mono_class_get_rank(klass: ^MonoClass): Int32; public;
    begin
    end;
    class method mono_class_get_flags(klass: ^MonoClass): uint32_t; public;
    begin
    end;
    class method mono_class_get_name(klass: ^MonoClass): ^AnsiChar; public;
    begin
    end;
    class method mono_class_get_namespace(klass: ^MonoClass): ^AnsiChar; public;
    begin
    end;
    class method mono_class_get_type(klass: ^MonoClass): ^MonoType; public;
    begin
    end;
    class method mono_class_get_type_token(klass: ^MonoClass): uint32_t; public;
    begin
    end;
    class method mono_class_get_byref_type(klass: ^MonoClass): ^MonoType; public;
    begin
    end;
    class method mono_class_num_fields(klass: ^MonoClass): Int32; public;
    begin
    end;
    class method mono_class_num_methods(klass: ^MonoClass): Int32; public;
    begin
    end;
    class method mono_class_num_properties(klass: ^MonoClass): Int32; public;
    begin
    end;
    class method mono_class_num_events(klass: ^MonoClass): Int32; public;
    begin
    end;
    class method mono_class_get_fields(klass: ^MonoClass; iter: ^^Void): ^MonoClassField; public;
    begin
    end;
    class method mono_class_get_methods(klass: ^MonoClass; iter: ^^Void): ^MonoMethod; public;
    begin
    end;
    class method mono_class_get_properties(klass: ^MonoClass; iter: ^^Void): ^MonoProperty; public;
    begin
    end;
    class method mono_class_get_events(klass: ^MonoClass; iter: ^^Void): ^MonoEvent; public;
    begin
    end;
    class method mono_class_get_interfaces(klass: ^MonoClass; iter: ^^Void): ^MonoClass; public;
    begin
    end;
    class method mono_class_get_nested_types(klass: ^MonoClass; iter: ^^Void): ^MonoClass; public;
    begin
    end;
    class method mono_class_is_delegate(klass: ^MonoClass): mono_bool; public;
    begin
    end;
    class method mono_class_implements_interface(klass: ^MonoClass; iface: ^MonoClass): mono_bool; public;
    begin
    end;
    class method mono_field_get_name(field: ^MonoClassField): ^AnsiChar; public;
    begin
    end;
    class method mono_field_get_type(field: ^MonoClassField): ^MonoType; public;
    begin
    end;
    class method mono_field_get_parent(field: ^MonoClassField): ^MonoClass; public;
    begin
    end;
    class method mono_field_get_flags(field: ^MonoClassField): uint32_t; public;
    begin
    end;
    class method mono_field_get_offset(field: ^MonoClassField): uint32_t; public;
    begin
    end;
    class method mono_field_get_data(field: ^MonoClassField): ^AnsiChar; public;
    begin
    end;
    class method mono_property_get_name(prop: ^MonoProperty): ^AnsiChar; public;
    begin
    end;
    class method mono_property_get_set_method(prop: ^MonoProperty): ^MonoMethod; public;
    begin
    end;
    class method mono_property_get_get_method(prop: ^MonoProperty): ^MonoMethod; public;
    begin
    end;
    class method mono_property_get_parent(prop: ^MonoProperty): ^MonoClass; public;
    begin
    end;
    class method mono_property_get_flags(prop: ^MonoProperty): uint32_t; public;
    begin
    end;
    class method mono_event_get_name(&event: ^MonoEvent): ^AnsiChar; public;
    begin
    end;
    class method mono_event_get_add_method(&event: ^MonoEvent): ^MonoMethod; public;
    begin
    end;
    class method mono_event_get_remove_method(&event: ^MonoEvent): ^MonoMethod; public;
    begin
    end;
    class method mono_event_get_raise_method(&event: ^MonoEvent): ^MonoMethod; public;
    begin
    end;
    class method mono_event_get_parent(&event: ^MonoEvent): ^MonoClass; public;
    begin
    end;
    class method mono_event_get_flags(&event: ^MonoEvent): uint32_t; public;
    begin
    end;
    class method mono_class_get_method_from_name(klass: ^MonoClass; name: ^AnsiChar; param_count: Int32): ^MonoMethod; public;
    begin
    end;
    class method mono_class_name_from_token(image: ^MonoImage; type_token: uint32_t): ^AnsiChar; public;
    begin
    end;
    class method mono_method_can_access_field(&method: ^MonoMethod; field: ^MonoClassField): mono_bool; public;
    begin
    end;
    class method mono_method_can_access_method(&method: ^MonoMethod; called: ^MonoMethod): mono_bool; public;
    begin
    end;
    class method mono_string_chars(s: ^MonoString): ^mono_unichar2; public;
    begin
    end;
    class method mono_string_length(s: ^MonoString): Int32; public;
    begin
    end;
    class method mono_object_new(domain: ^MonoDomain; klass: ^MonoClass): ^mono.metadata.MonoObject; public;
    begin
    end;
    class method mono_object_new_specific(vtable: ^MonoVTable): ^mono.metadata.MonoObject; public;
    begin
    end;
    class method mono_object_new_fast(vtable: ^MonoVTable): ^mono.metadata.MonoObject; public;
    begin
    end;
    class method mono_object_new_alloc_specific(vtable: ^MonoVTable): ^mono.metadata.MonoObject; public;
    begin
    end;
    class method mono_object_new_from_token(domain: ^MonoDomain; image: ^MonoImage; token: uint32_t): ^mono.metadata.MonoObject; public;
    begin
    end;
    class method mono_array_new(domain: ^MonoDomain; eclass: ^MonoClass; n: uintptr_t): ^MonoArray; public;
    begin
    end;
    class method mono_array_new_full(domain: ^MonoDomain; array_class: ^MonoClass; lengths: ^uintptr_t; lower_bounds: ^intptr_t): ^MonoArray; public;
    begin
    end;
    class method mono_array_new_specific(vtable: ^MonoVTable; n: uintptr_t): ^MonoArray; public;
    begin
    end;
    class method mono_array_clone(&array: ^MonoArray): ^MonoArray; public;
    begin
    end;
    class method mono_array_addr_with_size(&array: ^MonoArray; size: Int32; idx: uintptr_t): ^AnsiChar; public;
    begin
    end;
    class method mono_array_length(&array: ^MonoArray): uintptr_t; public;
    begin
    end;
    class method mono_string_new_utf16(domain: ^MonoDomain; text: ^mono_unichar2; len: int32_t): ^MonoString; public;
    begin
    end;
    class method mono_string_new_size(domain: ^MonoDomain; len: int32_t): ^MonoString; public;
    begin
    end;
    class method mono_ldstr(domain: ^MonoDomain; image: ^MonoImage; str_index: uint32_t): ^MonoString; public;
    begin
    end;
    class method mono_string_is_interned(str: ^MonoString): ^MonoString; public;
    begin
    end;
    class method mono_string_intern(str: ^MonoString): ^MonoString; public;
    begin
    end;
    class method mono_string_new(domain: ^MonoDomain; text: ^AnsiChar): ^MonoString; public;
    begin
    end;
    class method mono_string_new_wrapper(text: ^AnsiChar): ^MonoString; public;
    begin
    end;
    class method mono_string_new_len(domain: ^MonoDomain; text: ^AnsiChar; length: UInt32): ^MonoString; public;
    begin
    end;
    class method mono_string_new_utf32(domain: ^MonoDomain; text: ^mono_unichar4; len: int32_t): ^MonoString; public;
    begin
    end;
    class method mono_string_to_utf8(string_obj: ^MonoString): ^AnsiChar; public;
    begin
    end;
    class method mono_string_to_utf8_checked(string_obj: ^MonoString; error: ^mono.utils.MonoError): ^AnsiChar; public;
    begin
    end;
    class method mono_string_to_utf16(string_obj: ^MonoString): ^mono_unichar2; public;
    begin
    end;
    class method mono_string_to_utf32(string_obj: ^MonoString): ^mono_unichar4; public;
    begin
    end;
    class method mono_string_from_utf16(data: ^mono_unichar2): ^MonoString; public;
    begin
    end;
    class method mono_string_from_utf32(data: ^mono_unichar4): ^MonoString; public;
    begin
    end;
    class method mono_string_equal(s1: ^MonoString; s2: ^MonoString): mono_bool; public;
    begin
    end;
    class method mono_string_hash(s: ^MonoString): UInt32; public;
    begin
    end;
    class method mono_object_hash(obj: ^mono.metadata.MonoObject): Int32; public;
    begin
    end;
    class method mono_object_to_string(obj: ^mono.metadata.MonoObject; exc: ^^mono.metadata.MonoObject): ^MonoString; public;
    begin
    end;
    class method mono_value_box(domain: ^MonoDomain; klass: ^MonoClass; val: ^Void): ^mono.metadata.MonoObject; public;
    begin
    end;
    class method mono_value_copy(dest: ^Void; src: ^Void; klass: ^MonoClass): Void; public;
    begin
    end;
    class method mono_value_copy_array(dest: ^MonoArray; dest_idx: Int32; src: ^Void; count: Int32): Void; public;
    begin
    end;
    class method mono_object_get_domain(obj: ^mono.metadata.MonoObject): ^MonoDomain; public;
    begin
    end;
    class method mono_object_get_class(obj: ^mono.metadata.MonoObject): ^MonoClass; public;
    begin
    end;
    class method mono_object_unbox(obj: ^mono.metadata.MonoObject): ^Void; public;
    begin
    end;
    class method mono_object_clone(obj: ^mono.metadata.MonoObject): ^mono.metadata.MonoObject; public;
    begin
    end;
    class method mono_object_isinst(obj: ^mono.metadata.MonoObject; klass: ^MonoClass): ^mono.metadata.MonoObject; public;
    begin
    end;
    class method mono_object_isinst_mbyref(obj: ^mono.metadata.MonoObject; klass: ^MonoClass): ^mono.metadata.MonoObject; public;
    begin
    end;
    class method mono_object_castclass_mbyref(obj: ^mono.metadata.MonoObject; klass: ^MonoClass): ^mono.metadata.MonoObject; public;
    begin
    end;
    class method mono_monitor_try_enter(obj: ^mono.metadata.MonoObject; ms: uint32_t): mono_bool; public;
    begin
    end;
    class method mono_monitor_enter(obj: ^mono.metadata.MonoObject): mono_bool; public;
    begin
    end;
    class method mono_monitor_enter_v4(obj: ^mono.metadata.MonoObject; lock_taken: ^AnsiChar): Void; public;
    begin
    end;
    class method mono_object_get_size(o: ^mono.metadata.MonoObject): UInt32; public;
    begin
    end;
    class method mono_monitor_exit(obj: ^mono.metadata.MonoObject): Void; public;
    begin
    end;
    class method mono_raise_exception(ex: ^MonoException): Void; public;
    begin
    end;
    class method mono_runtime_object_init(this_obj: ^mono.metadata.MonoObject): Void; public;
    begin
    end;
    class method mono_runtime_class_init(vtable: ^MonoVTable): Void; public;
    begin
    end;
    class method mono_object_get_virtual_method(obj: ^mono.metadata.MonoObject; &method: ^MonoMethod): ^MonoMethod; public;
    begin
    end;
    class method mono_runtime_invoke(&method: ^MonoMethod; obj: ^Void; &params: ^^Void; exc: ^^mono.metadata.MonoObject): ^mono.metadata.MonoObject; public;
    begin
    end;
    class method mono_get_delegate_invoke(klass: ^MonoClass): ^MonoMethod; public;
    begin
    end;
    class method mono_get_delegate_begin_invoke(klass: ^MonoClass): ^MonoMethod; public;
    begin
    end;
    class method mono_get_delegate_end_invoke(klass: ^MonoClass): ^MonoMethod; public;
    begin
    end;
    class method mono_runtime_delegate_invoke(&delegate: ^mono.metadata.MonoObject; &params: ^^Void; exc: ^^mono.metadata.MonoObject): ^mono.metadata.MonoObject; public;
    begin
    end;
    class method mono_runtime_invoke_array(&method: ^MonoMethod; obj: ^Void; &params: ^MonoArray; exc: ^^mono.metadata.MonoObject): ^mono.metadata.MonoObject; public;
    begin
    end;
    class method mono_method_get_unmanaged_thunk(&method: ^MonoMethod): ^Void; public;
    begin
    end;
    class method mono_runtime_get_main_args: ^MonoArray; public;
    begin
    end;
    class method mono_runtime_exec_managed_code(domain: ^MonoDomain; main_func: method(user_data: ^Void): Void; main_args: ^Void): Void; public;
    begin
    end;
    class method mono_runtime_run_main(&method: ^MonoMethod; argc: Int32; argv: ^^AnsiChar; exc: ^^mono.metadata.MonoObject): Int32; public;
    begin
    end;
    class method mono_runtime_exec_main(&method: ^MonoMethod; args: ^MonoArray; exc: ^^mono.metadata.MonoObject): Int32; public;
    begin
    end;
    class method mono_runtime_set_main_args(argc: Int32; argv: ^^AnsiChar): Int32; public;
    begin
    end;
    class method mono_load_remote_field(this_obj: ^mono.metadata.MonoObject; klass: ^MonoClass; field: ^MonoClassField; res: ^^Void): ^Void; public;
    begin
    end;
    class method mono_load_remote_field_new(this_obj: ^mono.metadata.MonoObject; klass: ^MonoClass; field: ^MonoClassField): ^mono.metadata.MonoObject; public;
    begin
    end;
    class method mono_store_remote_field(this_obj: ^mono.metadata.MonoObject; klass: ^MonoClass; field: ^MonoClassField; val: ^Void): Void; public;
    begin
    end;
    class method mono_store_remote_field_new(this_obj: ^mono.metadata.MonoObject; klass: ^MonoClass; field: ^MonoClassField; arg: ^mono.metadata.MonoObject): Void; public;
    begin
    end;
    class method mono_unhandled_exception(exc: ^mono.metadata.MonoObject): Void; public;
    begin
    end;
    class method mono_print_unhandled_exception(exc: ^mono.metadata.MonoObject): Void; public;
    begin
    end;
    class method mono_compile_method(&method: ^MonoMethod): ^Void; public;
    begin
    end;
    class method mono_field_set_value(obj: ^mono.metadata.MonoObject; field: ^MonoClassField; value: ^Void): Void; public;
    begin
    end;
    class method mono_field_static_set_value(vt: ^MonoVTable; field: ^MonoClassField; value: ^Void): Void; public;
    begin
    end;
    class method mono_field_get_value(obj: ^mono.metadata.MonoObject; field: ^MonoClassField; value: ^Void): Void; public;
    begin
    end;
    class method mono_field_static_get_value(vt: ^MonoVTable; field: ^MonoClassField; value: ^Void): Void; public;
    begin
    end;
    class method mono_field_get_value_object(domain: ^MonoDomain; field: ^MonoClassField; obj: ^mono.metadata.MonoObject): ^mono.metadata.MonoObject; public;
    begin
    end;
    class method mono_property_set_value(prop: ^MonoProperty; obj: ^Void; &params: ^^Void; exc: ^^mono.metadata.MonoObject): Void; public;
    begin
    end;
    class method mono_property_get_value(prop: ^MonoProperty; obj: ^Void; &params: ^^Void; exc: ^^mono.metadata.MonoObject): ^mono.metadata.MonoObject; public;
    begin
    end;
    class method mono_gchandle_new(obj: ^mono.metadata.MonoObject; &pinned: mono_bool): uint32_t; public;
    begin
    end;
    class method mono_gchandle_new_weakref(obj: ^mono.metadata.MonoObject; track_resurrection: mono_bool): uint32_t; public;
    begin
    end;
    class method mono_gchandle_get_target(gchandle: uint32_t): ^mono.metadata.MonoObject; public;
    begin
    end;
    class method mono_gchandle_free(gchandle: uint32_t): Void; public;
    begin
    end;
    class method mono_gc_reference_queue_new(callback: method(user_data: ^Void): Void): ^MonoReferenceQueue; public;
    begin
    end;
    class method mono_gc_reference_queue_free(queue: ^MonoReferenceQueue): Void; public;
    begin
    end;
    class method mono_gc_reference_queue_add(queue: ^MonoReferenceQueue; obj: ^mono.metadata.MonoObject; user_data: ^Void): mono_bool; public;
    begin
    end;
    class method mono_gc_wbarrier_set_field(obj: ^mono.metadata.MonoObject; field_ptr: ^Void; value: ^mono.metadata.MonoObject): Void; public;
    begin
    end;
    class method mono_gc_wbarrier_set_arrayref(arr: ^MonoArray; slot_ptr: ^Void; value: ^mono.metadata.MonoObject): Void; public;
    begin
    end;
    class method mono_gc_wbarrier_arrayref_copy(dest_ptr: ^Void; src_ptr: ^Void; count: Int32): Void; public;
    begin
    end;
    class method mono_gc_wbarrier_generic_store(ptr: ^Void; value: ^mono.metadata.MonoObject): Void; public;
    begin
    end;
    class method mono_gc_wbarrier_generic_store_atomic(ptr: ^Void; value: ^mono.metadata.MonoObject): Void; public;
    begin
    end;
    class method mono_gc_wbarrier_generic_nostore(ptr: ^Void): Void; public;
    begin
    end;
    class method mono_gc_wbarrier_value_copy(dest: ^Void; src: ^Void; count: Int32; klass: ^MonoClass): Void; public;
    begin
    end;
    class method mono_gc_wbarrier_object_copy(obj: ^mono.metadata.MonoObject; src: ^mono.metadata.MonoObject): Void; public;
    begin
    end;
    class method mono_reflection_parse_type(name: ^AnsiChar; info: ^MonoTypeNameParse): Int32; public;
    begin
    end;
    class method mono_reflection_get_type(image: ^MonoImage; info: ^MonoTypeNameParse; ignorecase: mono_bool; type_resolve: ^mono_bool): ^MonoType; public;
    begin
    end;
    class method mono_reflection_free_type_info(info: ^MonoTypeNameParse): Void; public;
    begin
    end;
    class method mono_reflection_type_from_name(name: ^AnsiChar; image: ^MonoImage): ^MonoType; public;
    begin
    end;
    class method mono_reflection_get_token(obj: ^mono.metadata.MonoObject): uint32_t; public;
    begin
    end;
    class method mono_assembly_get_object(domain: ^MonoDomain; &assembly: ^MonoAssembly): ^MonoReflectionAssembly; public;
    begin
    end;
    class method mono_module_get_object(domain: ^MonoDomain; image: ^MonoImage): ^MonoReflectionModule; public;
    begin
    end;
    class method mono_module_file_get_object(domain: ^MonoDomain; image: ^MonoImage; table_index: Int32): ^MonoReflectionModule; public;
    begin
    end;
    class method mono_type_get_object(domain: ^MonoDomain; &type: ^MonoType): ^MonoReflectionType; public;
    begin
    end;
    class method mono_method_get_object(domain: ^MonoDomain; &method: ^MonoMethod; refclass: ^MonoClass): ^MonoReflectionMethod; public;
    begin
    end;
    class method mono_field_get_object(domain: ^MonoDomain; klass: ^MonoClass; field: ^MonoClassField): ^MonoReflectionField; public;
    begin
    end;
    class method mono_property_get_object(domain: ^MonoDomain; klass: ^MonoClass; &property: ^MonoProperty): ^MonoReflectionProperty; public;
    begin
    end;
    class method mono_event_get_object(domain: ^MonoDomain; klass: ^MonoClass; &event: ^MonoEvent): ^MonoReflectionEvent; public;
    begin
    end;
    class method mono_param_get_objects(domain: ^MonoDomain; &method: ^MonoMethod): ^MonoArray; public;
    begin
    end;
    class method mono_method_body_get_object(domain: ^MonoDomain; &method: ^MonoMethod): ^MonoReflectionMethodBody; public;
    begin
    end;
    class method mono_get_dbnull_object(domain: ^MonoDomain): ^mono.metadata.MonoObject; public;
    begin
    end;
    class method mono_reflection_get_custom_attrs_by_type(obj: ^mono.metadata.MonoObject; attr_klass: ^MonoClass; error: ^mono.utils.MonoError): ^MonoArray; public;
    begin
    end;
    class method mono_reflection_get_custom_attrs(obj: ^mono.metadata.MonoObject): ^MonoArray; public;
    begin
    end;
    class method mono_reflection_get_custom_attrs_data(obj: ^mono.metadata.MonoObject): ^MonoArray; public;
    begin
    end;
    class method mono_reflection_get_custom_attrs_blob(&assembly: ^MonoReflectionAssembly; ctor: ^mono.metadata.MonoObject; ctorArgs: ^MonoArray; properties: ^MonoArray; porpValues: ^MonoArray; fields: ^MonoArray; fieldValues: ^MonoArray): ^MonoArray; public;
    begin
    end;
    class method mono_reflection_get_custom_attrs_info(obj: ^mono.metadata.MonoObject): ^mono.metadata.MonoCustomAttrInfo; public;
    begin
    end;
    class method mono_custom_attrs_construct(cinfo: ^mono.metadata.MonoCustomAttrInfo): ^MonoArray; public;
    begin
    end;
    class method mono_custom_attrs_from_index(image: ^MonoImage; idx: uint32_t): ^mono.metadata.MonoCustomAttrInfo; public;
    begin
    end;
    class method mono_custom_attrs_from_method(&method: ^MonoMethod): ^mono.metadata.MonoCustomAttrInfo; public;
    begin
    end;
    class method mono_custom_attrs_from_class(klass: ^MonoClass): ^mono.metadata.MonoCustomAttrInfo; public;
    begin
    end;
    class method mono_custom_attrs_from_assembly(&assembly: ^MonoAssembly): ^mono.metadata.MonoCustomAttrInfo; public;
    begin
    end;
    class method mono_custom_attrs_from_property(klass: ^MonoClass; &property: ^MonoProperty): ^mono.metadata.MonoCustomAttrInfo; public;
    begin
    end;
    class method mono_custom_attrs_from_event(klass: ^MonoClass; &event: ^MonoEvent): ^mono.metadata.MonoCustomAttrInfo; public;
    begin
    end;
    class method mono_custom_attrs_from_field(klass: ^MonoClass; field: ^MonoClassField): ^mono.metadata.MonoCustomAttrInfo; public;
    begin
    end;
    class method mono_custom_attrs_from_param(&method: ^MonoMethod; &param: uint32_t): ^mono.metadata.MonoCustomAttrInfo; public;
    begin
    end;
    class method mono_custom_attrs_has_attr(ainfo: ^mono.metadata.MonoCustomAttrInfo; attr_klass: ^MonoClass): mono_bool; public;
    begin
    end;
    class method mono_custom_attrs_get_attr(ainfo: ^mono.metadata.MonoCustomAttrInfo; attr_klass: ^MonoClass): ^mono.metadata.MonoObject; public;
    begin
    end;
    class method mono_custom_attrs_free(ainfo: ^mono.metadata.MonoCustomAttrInfo): Void; public;
    begin
    end;
    class var MONO_DECLSEC_FLAG_REQUEST: Int32; public;
    class var MONO_DECLSEC_FLAG_DEMAND: Int32; public;
    class var MONO_DECLSEC_FLAG_ASSERT: Int32; public;
    class var MONO_DECLSEC_FLAG_DENY: Int32; public;
    class var MONO_DECLSEC_FLAG_PERMITONLY: Int32; public;
    class var MONO_DECLSEC_FLAG_LINKDEMAND: Int32; public;
    class var MONO_DECLSEC_FLAG_INHERITANCEDEMAND: Int32; public;
    class var MONO_DECLSEC_FLAG_REQUEST_MINIMUM: Int32; public;
    class var MONO_DECLSEC_FLAG_REQUEST_OPTIONAL: Int32; public;
    class var MONO_DECLSEC_FLAG_REQUEST_REFUSE: Int32; public;
    class var MONO_DECLSEC_FLAG_PREJIT_GRANT: Int32; public;
    class var MONO_DECLSEC_FLAG_PREJIT_DENY: Int32; public;
    class var MONO_DECLSEC_FLAG_NONCAS_DEMAND: Int32; public;
    class var MONO_DECLSEC_FLAG_NONCAS_LINKDEMAND: Int32; public;
    class var MONO_DECLSEC_FLAG_NONCAS_INHERITANCEDEMAND: Int32; public;
    class var MONO_DECLSEC_FLAG_LINKDEMAND_CHOICE: Int32; public;
    class var MONO_DECLSEC_FLAG_INHERITANCEDEMAND_CHOICE: Int32; public;
    class var MONO_DECLSEC_FLAG_DEMAND_CHOICE: Int32; public;
    class method mono_declsec_flags_from_method(&method: ^MonoMethod): uint32_t; public;
    begin
    end;
    class method mono_declsec_flags_from_class(klass: ^MonoClass): uint32_t; public;
    begin
    end;
    class method mono_declsec_flags_from_assembly(&assembly: ^MonoAssembly): uint32_t; public;
    begin
    end;
    class method mono_declsec_get_demands(callee: ^MonoMethod; demands: ^mono.metadata.MonoDeclSecurityActions): MonoBoolean; public;
    begin
    end;
    class method mono_declsec_get_linkdemands(callee: ^MonoMethod; klass: ^mono.metadata.MonoDeclSecurityActions; cmethod: ^mono.metadata.MonoDeclSecurityActions): MonoBoolean; public;
    begin
    end;
    class method mono_declsec_get_inheritdemands_class(klass: ^MonoClass; demands: ^mono.metadata.MonoDeclSecurityActions): MonoBoolean; public;
    begin
    end;
    class method mono_declsec_get_inheritdemands_method(callee: ^MonoMethod; demands: ^mono.metadata.MonoDeclSecurityActions): MonoBoolean; public;
    begin
    end;
    class method mono_declsec_get_method_action(&method: ^MonoMethod; action: uint32_t; entry: ^mono.metadata.MonoDeclSecurityEntry): MonoBoolean; public;
    begin
    end;
    class method mono_declsec_get_class_action(klass: ^MonoClass; action: uint32_t; entry: ^mono.metadata.MonoDeclSecurityEntry): MonoBoolean; public;
    begin
    end;
    class method mono_declsec_get_assembly_action(&assembly: ^MonoAssembly; action: uint32_t; entry: ^mono.metadata.MonoDeclSecurityEntry): MonoBoolean; public;
    begin
    end;
    class method mono_reflection_type_get_type(reftype: ^MonoReflectionType): ^MonoType; public;
    begin
    end;
    class method mono_reflection_assembly_get_assembly(refassembly: ^MonoReflectionAssembly): ^MonoAssembly; public;
    begin
    end;
    class method mono_init(filename: ^AnsiChar): ^MonoDomain; public;
    begin
    end;
    class method mono_init_from_assembly(domain_name: ^AnsiChar; filename: ^AnsiChar): ^MonoDomain; public;
    begin
    end;
    class method mono_init_version(domain_name: ^AnsiChar; version: ^AnsiChar): ^MonoDomain; public;
    begin
    end;
    class method mono_get_root_domain: ^MonoDomain; public;
    begin
    end;
    class method mono_runtime_init(domain: ^MonoDomain; start_cb: method(tid: intptr_t; stack_start: ^Void; func: ^Void): Void; attach_cb: method(tid: intptr_t; stack_start: ^Void): Void): Void; public;
    begin
    end;
    class method mono_runtime_cleanup(domain: ^MonoDomain): Void; public;
    begin
    end;
    class method mono_install_runtime_cleanup(func: method(domain: ^MonoDomain; user_data: ^Void): Void): Void; public;
    begin
    end;
    class method mono_runtime_quit: Void; public;
    begin
    end;
    class method mono_runtime_set_shutting_down: Void; public;
    begin
    end;
    class method mono_runtime_is_shutting_down: mono_bool; public;
    begin
    end;
    class method mono_check_corlib_version: ^AnsiChar; public;
    begin
    end;
    class method mono_domain_create: ^MonoDomain; public;
    begin
    end;
    class method mono_domain_create_appdomain(friendly_name: ^AnsiChar; configuration_file: ^AnsiChar): ^MonoDomain; public;
    begin
    end;
    class method mono_domain_set_config(domain: ^MonoDomain; base_dir: ^AnsiChar; config_file_name: ^AnsiChar): Void; public;
    begin
    end;
    class method mono_domain_get: ^MonoDomain; public;
    begin
    end;
    class method mono_domain_get_by_id(domainid: int32_t): ^MonoDomain; public;
    begin
    end;
    class method mono_domain_get_id(domain: ^MonoDomain): int32_t; public;
    begin
    end;
    class method mono_domain_get_friendly_name(domain: ^MonoDomain): ^AnsiChar; public;
    begin
    end;
    class method mono_domain_set(domain: ^MonoDomain; force: mono_bool): mono_bool; public;
    begin
    end;
    class method mono_domain_set_internal(domain: ^MonoDomain): Void; public;
    begin
    end;
    class method mono_domain_unload(domain: ^MonoDomain): Void; public;
    begin
    end;
    class method mono_domain_try_unload(domain: ^MonoDomain; exc: ^^mono.metadata.MonoObject): Void; public;
    begin
    end;
    class method mono_domain_is_unloading(domain: ^MonoDomain): mono_bool; public;
    begin
    end;
    class method mono_domain_from_appdomain(appdomain: ^MonoAppDomain): ^MonoDomain; public;
    begin
    end;
    class method mono_domain_foreach(func: method(domain: ^MonoDomain; user_data: ^Void): Void; user_data: ^Void): Void; public;
    begin
    end;
    class method mono_domain_assembly_open(domain: ^MonoDomain; name: ^AnsiChar): ^MonoAssembly; public;
    begin
    end;
    class method mono_domain_finalize(domain: ^MonoDomain; timeout: uint32_t): mono_bool; public;
    begin
    end;
    class method mono_domain_free(domain: ^MonoDomain; force: mono_bool): Void; public;
    begin
    end;
    class method mono_domain_has_type_resolve(domain: ^MonoDomain): mono_bool; public;
    begin
    end;
    class method mono_domain_try_type_resolve(domain: ^MonoDomain; name: ^AnsiChar; tb: ^mono.metadata.MonoObject): ^MonoReflectionAssembly; public;
    begin
    end;
    class method mono_domain_owns_vtable_slot(domain: ^MonoDomain; vtable_slot: ^Void): mono_bool; public;
    begin
    end;
    class method mono_context_init(domain: ^MonoDomain): Void; public;
    begin
    end;
    class method mono_context_set(new_context: ^MonoAppContext): Void; public;
    begin
    end;
    class method mono_context_get: ^MonoAppContext; public;
    begin
    end;
    class method mono_context_get_id(context: ^MonoAppContext): int32_t; public;
    begin
    end;
    class method mono_context_get_domain_id(context: ^MonoAppContext): int32_t; public;
    begin
    end;
    class method mono_jit_info_table_find(domain: ^MonoDomain; addr: ^AnsiChar): ^MonoJitInfo; public;
    begin
    end;
    class method mono_jit_info_get_code_start(ji: ^MonoJitInfo): ^Void; public;
    begin
    end;
    class method mono_jit_info_get_code_size(ji: ^MonoJitInfo): Int32; public;
    begin
    end;
    class method mono_jit_info_get_method(ji: ^MonoJitInfo): ^MonoMethod; public;
    begin
    end;
    class method mono_get_corlib: ^MonoImage; public;
    begin
    end;
    class method mono_get_object_class: ^MonoClass; public;
    begin
    end;
    class method mono_get_byte_class: ^MonoClass; public;
    begin
    end;
    class method mono_get_void_class: ^MonoClass; public;
    begin
    end;
    class method mono_get_boolean_class: ^MonoClass; public;
    begin
    end;
    class method mono_get_sbyte_class: ^MonoClass; public;
    begin
    end;
    class method mono_get_int16_class: ^MonoClass; public;
    begin
    end;
    class method mono_get_uint16_class: ^MonoClass; public;
    begin
    end;
    class method mono_get_int32_class: ^MonoClass; public;
    begin
    end;
    class method mono_get_uint32_class: ^MonoClass; public;
    begin
    end;
    class method mono_get_intptr_class: ^MonoClass; public;
    begin
    end;
    class method mono_get_uintptr_class: ^MonoClass; public;
    begin
    end;
    class method mono_get_int64_class: ^MonoClass; public;
    begin
    end;
    class method mono_get_uint64_class: ^MonoClass; public;
    begin
    end;
    class method mono_get_single_class: ^MonoClass; public;
    begin
    end;
    class method mono_get_double_class: ^MonoClass; public;
    begin
    end;
    class method mono_get_char_class: ^MonoClass; public;
    begin
    end;
    class method mono_get_string_class: ^MonoClass; public;
    begin
    end;
    class method mono_get_enum_class: ^MonoClass; public;
    begin
    end;
    class method mono_get_array_class: ^MonoClass; public;
    begin
    end;
    class method mono_get_thread_class: ^MonoClass; public;
    begin
    end;
    class method mono_get_exception_class: ^MonoClass; public;
    begin
    end;
    class method mono_security_enable_core_clr: Void; public;
    begin
    end;
    class method mono_security_set_core_clr_platform_callback(callback: method(image_name: ^AnsiChar): mono_bool): Void; public;
    begin
    end;
    class method mono_assemblies_init: Void; public;
    begin
    end;
    class method mono_assemblies_cleanup: Void; public;
    begin
    end;
    class method mono_assembly_open(filename: ^AnsiChar; status: ^mono.metadata.MonoImageOpenStatus): ^MonoAssembly; public;
    begin
    end;
    class method mono_assembly_open_full(filename: ^AnsiChar; status: ^mono.metadata.MonoImageOpenStatus; refonly: mono_bool): ^MonoAssembly; public;
    begin
    end;
    class method mono_assembly_load(aname: ^MonoAssemblyName; basedir: ^AnsiChar; status: ^mono.metadata.MonoImageOpenStatus): ^MonoAssembly; public;
    begin
    end;
    class method mono_assembly_load_full(aname: ^MonoAssemblyName; basedir: ^AnsiChar; status: ^mono.metadata.MonoImageOpenStatus; refonly: mono_bool): ^MonoAssembly; public;
    begin
    end;
    class method mono_assembly_load_from(image: ^MonoImage; fname: ^AnsiChar; status: ^mono.metadata.MonoImageOpenStatus): ^MonoAssembly; public;
    begin
    end;
    class method mono_assembly_load_from_full(image: ^MonoImage; fname: ^AnsiChar; status: ^mono.metadata.MonoImageOpenStatus; refonly: mono_bool): ^MonoAssembly; public;
    begin
    end;
    class method mono_assembly_load_with_partial_name(name: ^AnsiChar; status: ^mono.metadata.MonoImageOpenStatus): ^MonoAssembly; public;
    begin
    end;
    class method mono_assembly_loaded(aname: ^MonoAssemblyName): ^MonoAssembly; public;
    begin
    end;
    class method mono_assembly_loaded_full(aname: ^MonoAssemblyName; refonly: mono_bool): ^MonoAssembly; public;
    begin
    end;
    class method mono_assembly_get_assemblyref(image: ^MonoImage; &index: Int32; aname: ^MonoAssemblyName): Void; public;
    begin
    end;
    class method mono_assembly_load_reference(image: ^MonoImage; &index: Int32): Void; public;
    begin
    end;
    class method mono_assembly_load_references(image: ^MonoImage; status: ^mono.metadata.MonoImageOpenStatus): Void; public;
    begin
    end;
    class method mono_assembly_load_module(&assembly: ^MonoAssembly; idx: uint32_t): ^MonoImage; public;
    begin
    end;
    class method mono_assembly_close(&assembly: ^MonoAssembly): Void; public;
    begin
    end;
    class method mono_assembly_setrootdir(root_dir: ^AnsiChar): Void; public;
    begin
    end;
    class method mono_assembly_getrootdir: ^AnsiChar; public;
    begin
    end;
    class method mono_native_getrootdir: ^AnsiChar; public;
    begin
    end;
    class method mono_assembly_foreach(func: method(data: ^Void; user_data: ^Void): Void; user_data: ^Void): Void; public;
    begin
    end;
    class method mono_assembly_set_main(&assembly: ^MonoAssembly): Void; public;
    begin
    end;
    class method mono_assembly_get_main: ^MonoAssembly; public;
    begin
    end;
    class method mono_assembly_get_image(&assembly: ^MonoAssembly): ^MonoImage; public;
    begin
    end;
    class method mono_assembly_get_name(&assembly: ^MonoAssembly): ^MonoAssemblyName; public;
    begin
    end;
    class method mono_assembly_fill_assembly_name(image: ^MonoImage; aname: ^MonoAssemblyName): mono_bool; public;
    begin
    end;
    class method mono_assembly_names_equal(l: ^MonoAssemblyName; r: ^MonoAssemblyName): mono_bool; public;
    begin
    end;
    class method mono_stringify_assembly_name(aname: ^MonoAssemblyName): ^AnsiChar; public;
    begin
    end;
    class method mono_install_assembly_load_hook(func: method(&assembly: ^MonoAssembly; user_data: ^Void): Void; user_data: ^Void): Void; public;
    begin
    end;
    class method mono_install_assembly_search_hook(func: method(aname: ^MonoAssemblyName; user_data: ^Void): ^MonoAssembly; user_data: ^Void): Void; public;
    begin
    end;
    class method mono_install_assembly_refonly_search_hook(func: method(aname: ^MonoAssemblyName; user_data: ^Void): ^MonoAssembly; user_data: ^Void): Void; public;
    begin
    end;
    class method mono_assembly_invoke_search_hook(aname: ^MonoAssemblyName): ^MonoAssembly; public;
    begin
    end;
    class method mono_install_assembly_postload_search_hook(func: method(aname: ^MonoAssemblyName; user_data: ^Void): ^MonoAssembly; user_data: ^Void): Void; public;
    begin
    end;
    class method mono_install_assembly_postload_refonly_search_hook(func: method(aname: ^MonoAssemblyName; user_data: ^Void): ^MonoAssembly; user_data: ^Void): Void; public;
    begin
    end;
    class method mono_install_assembly_preload_hook(func: method(aname: ^MonoAssemblyName; assemblies_path: ^^AnsiChar; user_data: ^Void): ^MonoAssembly; user_data: ^Void): Void; public;
    begin
    end;
    class method mono_install_assembly_refonly_preload_hook(func: method(aname: ^MonoAssemblyName; assemblies_path: ^^AnsiChar; user_data: ^Void): ^MonoAssembly; user_data: ^Void): Void; public;
    begin
    end;
    class method mono_assembly_invoke_load_hook(ass: ^MonoAssembly): Void; public;
    begin
    end;
    class method mono_assembly_name_new(name: ^AnsiChar): ^MonoAssemblyName; public;
    begin
    end;
    class method mono_assembly_name_get_name(aname: ^MonoAssemblyName): ^AnsiChar; public;
    begin
    end;
    class method mono_assembly_name_get_culture(aname: ^MonoAssemblyName): ^AnsiChar; public;
    begin
    end;
    class method mono_assembly_name_get_version(aname: ^MonoAssemblyName; minor: ^uint16_t; build: ^uint16_t; revision: ^uint16_t): uint16_t; public;
    begin
    end;
    class method mono_assembly_name_get_pubkeytoken(aname: ^MonoAssemblyName): ^mono_byte; public;
    begin
    end;
    class method mono_assembly_name_free(aname: ^MonoAssemblyName): Void; public;
    begin
    end;
    class method mono_register_bundled_assemblies(assemblies: ^^mono.metadata.MonoBundledAssembly): Void; public;
    begin
    end;
    class method mono_register_config_for_assembly(assembly_name: ^AnsiChar; config_xml: ^AnsiChar): Void; public;
    begin
    end;
    class method mono_register_symfile_for_assembly(assembly_name: ^AnsiChar; raw_contents: ^mono_byte; size: Int32): Void; public;
    begin
    end;
    class method mono_register_machine_config(config_xml: ^AnsiChar): Void; public;
    begin
    end;
    class method mono_set_rootdir: Void; public;
    begin
    end;
    class method mono_set_dirs(assembly_dir: ^AnsiChar; config_dir: ^AnsiChar): Void; public;
    begin
    end;
    class method mono_set_assemblies_path(path: ^AnsiChar): Void; public;
    begin
    end;
    class var MONO_ASSEMBLY_HASH_NONE: Int32; public;
    class var MONO_ASSEMBLY_HASH_MD5: Int32; public;
    class var MONO_ASSEMBLY_HASH_SHA1: Int32; public;
    class var MONO_ASSEMBLYREF_FULL_PUBLIC_KEY: Int32; public;
    class var MONO_ASSEMBLYREF_RETARGETABLE: Int32; public;
    class var MONO_ASSEMBLYREF_JIT_TRACKING: Int32; public;
    class var MONO_ASSEMBLYREF_NO_JIT_OPT: Int32; public;
    class var MONO_EVENT_SPECIALNAME: Int32; public;
    class var MONO_EVENT_RTSPECIALNAME: Int32; public;
    class var MONO_FIELD_ATTR_FIELD_ACCESS_MASK: Int32; public;
    class var MONO_FIELD_ATTR_COMPILER_CONTROLLED: Int32; public;
    class var MONO_FIELD_ATTR_PRIVATE: Int32; public;
    class var MONO_FIELD_ATTR_FAM_AND_ASSEM: Int32; public;
    class var MONO_FIELD_ATTR_ASSEMBLY: Int32; public;
    class var MONO_FIELD_ATTR_FAMILY: Int32; public;
    class var MONO_FIELD_ATTR_FAM_OR_ASSEM: Int32; public;
    class var MONO_FIELD_ATTR_PUBLIC: Int32; public;
    class var MONO_FIELD_ATTR_STATIC: Int32; public;
    class var MONO_FIELD_ATTR_INIT_ONLY: Int32; public;
    class var MONO_FIELD_ATTR_LITERAL: Int32; public;
    class var MONO_FIELD_ATTR_NOT_SERIALIZED: Int32; public;
    class var MONO_FIELD_ATTR_SPECIAL_NAME: Int32; public;
    class var MONO_FIELD_ATTR_PINVOKE_IMPL: Int32; public;
    class var MONO_FIELD_ATTR_RESERVED_MASK: Int32; public;
    class var MONO_FIELD_ATTR_RT_SPECIAL_NAME: Int32; public;
    class var MONO_FIELD_ATTR_HAS_MARSHAL: Int32; public;
    class var MONO_FIELD_ATTR_HAS_DEFAULT: Int32; public;
    class var MONO_FIELD_ATTR_HAS_RVA: Int32; public;
    class var MONO_FILE_HAS_METADATA: Int32; public;
    class var MONO_FILE_HAS_NO_METADATA: Int32; public;
    class var MONO_GEN_PARAM_VARIANCE_MASK: Int32; public;
    class var MONO_GEN_PARAM_NON_VARIANT: Int32; public;
    class var MONO_GEN_PARAM_VARIANT: Int32; public;
    class var MONO_GEN_PARAM_COVARIANT: Int32; public;
    class var MONO_GEN_PARAM_CONSTRAINT_MASK: Int32; public;
    class var MONO_GEN_PARAM_CONSTRAINT_CLASS: Int32; public;
    class var MONO_GEN_PARAM_CONSTRAINT_VTYPE: Int32; public;
    class var MONO_GEN_PARAM_CONSTRAINT_DCTOR: Int32; public;
    class var MONO_PINVOKE_NO_MANGLE: Int32; public;
    class var MONO_PINVOKE_CHAR_SET_MASK: Int32; public;
    class var MONO_PINVOKE_CHAR_SET_NOT_SPEC: Int32; public;
    class var MONO_PINVOKE_CHAR_SET_ANSI: Int32; public;
    class var MONO_PINVOKE_CHAR_SET_UNICODE: Int32; public;
    class var MONO_PINVOKE_CHAR_SET_AUTO: Int32; public;
    class var MONO_PINVOKE_BEST_FIT_ENABLED: Int32; public;
    class var MONO_PINVOKE_BEST_FIT_DISABLED: Int32; public;
    class var MONO_PINVOKE_BEST_FIT_MASK: Int32; public;
    class var MONO_PINVOKE_SUPPORTS_LAST_ERROR: Int32; public;
    class var MONO_PINVOKE_CALL_CONV_MASK: Int32; public;
    class var MONO_PINVOKE_CALL_CONV_WINAPI: Int32; public;
    class var MONO_PINVOKE_CALL_CONV_CDECL: Int32; public;
    class var MONO_PINVOKE_CALL_CONV_STDCALL: Int32; public;
    class var MONO_PINVOKE_CALL_CONV_THISCALL: Int32; public;
    class var MONO_PINVOKE_CALL_CONV_FASTCALL: Int32; public;
    class var MONO_PINVOKE_THROW_ON_UNMAPPABLE_ENABLED: Int32; public;
    class var MONO_PINVOKE_THROW_ON_UNMAPPABLE_DISABLED: Int32; public;
    class var MONO_PINVOKE_THROW_ON_UNMAPPABLE_MASK: Int32; public;
    class var MONO_PINVOKE_CALL_CONV_GENERIC: Int32; public;
    class var MONO_PINVOKE_CALL_CONV_GENERICINST: Int32; public;
    class var MONO_MANIFEST_RESOURCE_VISIBILITY_MASK: Int32; public;
    class var MONO_MANIFEST_RESOURCE_PUBLIC: Int32; public;
    class var MONO_MANIFEST_RESOURCE_PRIVATE: Int32; public;
    class var MONO_METHOD_ATTR_ACCESS_MASK: Int32; public;
    class var MONO_METHOD_ATTR_COMPILER_CONTROLLED: Int32; public;
    class var MONO_METHOD_ATTR_PRIVATE: Int32; public;
    class var MONO_METHOD_ATTR_FAM_AND_ASSEM: Int32; public;
    class var MONO_METHOD_ATTR_ASSEM: Int32; public;
    class var MONO_METHOD_ATTR_FAMILY: Int32; public;
    class var MONO_METHOD_ATTR_FAM_OR_ASSEM: Int32; public;
    class var MONO_METHOD_ATTR_PUBLIC: Int32; public;
    class var MONO_METHOD_ATTR_STATIC: Int32; public;
    class var MONO_METHOD_ATTR_FINAL: Int32; public;
    class var MONO_METHOD_ATTR_VIRTUAL: Int32; public;
    class var MONO_METHOD_ATTR_HIDE_BY_SIG: Int32; public;
    class var MONO_METHOD_ATTR_VTABLE_LAYOUT_MASK: Int32; public;
    class var MONO_METHOD_ATTR_REUSE_SLOT: Int32; public;
    class var MONO_METHOD_ATTR_NEW_SLOT: Int32; public;
    class var MONO_METHOD_ATTR_STRICT: Int32; public;
    class var MONO_METHOD_ATTR_ABSTRACT: Int32; public;
    class var MONO_METHOD_ATTR_SPECIAL_NAME: Int32; public;
    class var MONO_METHOD_ATTR_PINVOKE_IMPL: Int32; public;
    class var MONO_METHOD_ATTR_UNMANAGED_EXPORT: Int32; public;
    class var MONO_METHOD_ATTR_RESERVED_MASK: Int32; public;
    class var MONO_METHOD_ATTR_RT_SPECIAL_NAME: Int32; public;
    class var MONO_METHOD_ATTR_HAS_SECURITY: Int32; public;
    class var MONO_METHOD_ATTR_REQUIRE_SEC_OBJECT: Int32; public;
    class var MONO_METHOD_IMPL_ATTR_CODE_TYPE_MASK: Int32; public;
    class var MONO_METHOD_IMPL_ATTR_IL: Int32; public;
    class var MONO_METHOD_IMPL_ATTR_NATIVE: Int32; public;
    class var MONO_METHOD_IMPL_ATTR_OPTIL: Int32; public;
    class var MONO_METHOD_IMPL_ATTR_RUNTIME: Int32; public;
    class var MONO_METHOD_IMPL_ATTR_MANAGED_MASK: Int32; public;
    class var MONO_METHOD_IMPL_ATTR_UNMANAGED: Int32; public;
    class var MONO_METHOD_IMPL_ATTR_MANAGED: Int32; public;
    class var MONO_METHOD_IMPL_ATTR_FORWARD_REF: Int32; public;
    class var MONO_METHOD_IMPL_ATTR_PRESERVE_SIG: Int32; public;
    class var MONO_METHOD_IMPL_ATTR_INTERNAL_CALL: Int32; public;
    class var MONO_METHOD_IMPL_ATTR_SYNCHRONIZED: Int32; public;
    class var MONO_METHOD_IMPL_ATTR_NOINLINING: Int32; public;
    class var MONO_METHOD_IMPL_ATTR_NOOPTIMIZATION: Int32; public;
    class var MONO_METHOD_IMPL_ATTR_MAX_METHOD_IMPL_VAL: Int32; public;
    class var MONO_METHOD_SEMANTIC_SETTER: Int32; public;
    class var MONO_METHOD_SEMANTIC_GETTER: Int32; public;
    class var MONO_METHOD_SEMANTIC_OTHER: Int32; public;
    class var MONO_METHOD_SEMANTIC_ADD_ON: Int32; public;
    class var MONO_METHOD_SEMANTIC_REMOVE_ON: Int32; public;
    class var MONO_METHOD_SEMANTIC_FIRE: Int32; public;
    class var MONO_PARAM_ATTR_IN: Int32; public;
    class var MONO_PARAM_ATTR_OUT: Int32; public;
    class var MONO_PARAM_ATTR_OPTIONAL: Int32; public;
    class var MONO_PARAM_ATTR_RESERVED_MASK: Int32; public;
    class var MONO_PARAM_ATTR_HAS_DEFAULT: Int32; public;
    class var MONO_PARAM_ATTR_HAS_MARSHAL: Int32; public;
    class var MONO_PARAM_ATTR_UNUSED: Int32; public;
    class var MONO_PROPERTY_ATTR_SPECIAL_NAME: Int32; public;
    class var MONO_PROPERTY_ATTR_RESERVED_MASK: Int32; public;
    class var MONO_PROPERTY_ATTR_RT_SPECIAL_NAME: Int32; public;
    class var MONO_PROPERTY_ATTR_HAS_DEFAULT: Int32; public;
    class var MONO_PROPERTY_ATTR_UNUSED: Int32; public;
    class var MONO_TYPE_ATTR_VISIBILITY_MASK: Int32; public;
    class var MONO_TYPE_ATTR_NOT_PUBLIC: Int32; public;
    class var MONO_TYPE_ATTR_PUBLIC: Int32; public;
    class var MONO_TYPE_ATTR_NESTED_PUBLIC: Int32; public;
    class var MONO_TYPE_ATTR_NESTED_PRIVATE: Int32; public;
    class var MONO_TYPE_ATTR_NESTED_FAMILY: Int32; public;
    class var MONO_TYPE_ATTR_NESTED_ASSEMBLY: Int32; public;
    class var MONO_TYPE_ATTR_NESTED_FAM_AND_ASSEM: Int32; public;
    class var MONO_TYPE_ATTR_NESTED_FAM_OR_ASSEM: Int32; public;
    class var MONO_TYPE_ATTR_LAYOUT_MASK: Int32; public;
    class var MONO_TYPE_ATTR_AUTO_LAYOUT: Int32; public;
    class var MONO_TYPE_ATTR_SEQUENTIAL_LAYOUT: Int32; public;
    class var MONO_TYPE_ATTR_EXPLICIT_LAYOUT: Int32; public;
    class var MONO_TYPE_ATTR_CLASS_SEMANTIC_MASK: Int32; public;
    class var MONO_TYPE_ATTR_CLASS: Int32; public;
    class var MONO_TYPE_ATTR_INTERFACE: Int32; public;
    class var MONO_TYPE_ATTR_ABSTRACT: Int32; public;
    class var MONO_TYPE_ATTR_SEALED: Int32; public;
    class var MONO_TYPE_ATTR_SPECIAL_NAME: Int32; public;
    class var MONO_TYPE_ATTR_IMPORT: Int32; public;
    class var MONO_TYPE_ATTR_SERIALIZABLE: Int32; public;
    class var MONO_TYPE_ATTR_STRING_FORMAT_MASK: Int32; public;
    class var MONO_TYPE_ATTR_ANSI_CLASS: Int32; public;
    class var MONO_TYPE_ATTR_UNICODE_CLASS: Int32; public;
    class var MONO_TYPE_ATTR_AUTO_CLASS: Int32; public;
    class var MONO_TYPE_ATTR_CUSTOM_CLASS: Int32; public;
    class var MONO_TYPE_ATTR_CUSTOM_MASK: Int32; public;
    class var MONO_TYPE_ATTR_BEFORE_FIELD_INIT: Int32; public;
    class var MONO_TYPE_ATTR_FORWARDER: Int32; public;
    class var MONO_TYPE_ATTR_RESERVED_MASK: Int32; public;
    class var MONO_TYPE_ATTR_RT_SPECIAL_NAME: Int32; public;
    class var MONO_TYPE_ATTR_HAS_SECURITY: Int32; public;
    class method mono_disasm_code_one(dh: ^MonoDisHelper; &method: ^MonoMethod; ip: ^mono_byte; endp: ^^mono_byte): ^AnsiChar; public;
    begin
    end;
    class method mono_disasm_code(dh: ^MonoDisHelper; &method: ^MonoMethod; ip: ^mono_byte; &end: ^mono_byte): ^AnsiChar; public;
    begin
    end;
    class method mono_type_full_name(&type: ^MonoType): ^AnsiChar; public;
    begin
    end;
    class method mono_signature_get_desc(sig: ^MonoMethodSignature; include_namespace: mono_bool): ^AnsiChar; public;
    begin
    end;
    class method mono_context_get_desc(context: ^MonoGenericContext): ^AnsiChar; public;
    begin
    end;
    class method mono_method_desc_new(name: ^AnsiChar; include_namespace: mono_bool): ^MonoMethodDesc; public;
    begin
    end;
    class method mono_method_desc_from_method(&method: ^MonoMethod): ^MonoMethodDesc; public;
    begin
    end;
    class method mono_method_desc_free(&desc: ^MonoMethodDesc): Void; public;
    begin
    end;
    class method mono_method_desc_match(&desc: ^MonoMethodDesc; &method: ^MonoMethod): mono_bool; public;
    begin
    end;
    class method mono_method_desc_full_match(&desc: ^MonoMethodDesc; &method: ^MonoMethod): mono_bool; public;
    begin
    end;
    class method mono_method_desc_search_in_class(&desc: ^MonoMethodDesc; klass: ^MonoClass): ^MonoMethod; public;
    begin
    end;
    class method mono_method_desc_search_in_image(&desc: ^MonoMethodDesc; image: ^MonoImage): ^MonoMethod; public;
    begin
    end;
    class method mono_method_full_name(&method: ^MonoMethod; signature: mono_bool): ^AnsiChar; public;
    begin
    end;
    class method mono_field_full_name(field: ^MonoClassField): ^AnsiChar; public;
    begin
    end;
    class method mono_environment_exitcode_get: int32_t; public;
    begin
    end;
    class method mono_environment_exitcode_set(value: int32_t): Void; public;
    begin
    end;
    class method mono_config_get_os: ^AnsiChar; public;
    begin
    end;
    class method mono_config_get_cpu: ^AnsiChar; public;
    begin
    end;
    class method mono_config_get_wordsize: ^AnsiChar; public;
    begin
    end;
    class method mono_get_config_dir: ^AnsiChar; public;
    begin
    end;
    class method mono_set_config_dir(dir: ^AnsiChar): Void; public;
    begin
    end;
    class method mono_get_machine_config: ^AnsiChar; public;
    begin
    end;
    class method mono_config_cleanup: Void; public;
    begin
    end;
    class method mono_config_parse(filename: ^AnsiChar): Void; public;
    begin
    end;
    class method mono_config_for_assembly(&assembly: ^MonoImage): Void; public;
    begin
    end;
    class method mono_config_parse_memory(buffer: ^AnsiChar): Void; public;
    begin
    end;
    class method mono_config_string_for_assembly_file(filename: ^AnsiChar): ^AnsiChar; public;
    begin
    end;
    class method mono_config_set_server_mode(server_mode: mono_bool): Void; public;
    begin
    end;
    class method mono_config_is_server_mode: mono_bool; public;
    begin
    end;
    class method mono_debug_enabled: mono_bool; public;
    begin
    end;
    class method mono_debug_init(format: mono.metadata.MonoDebugFormat): Void; public;
    begin
    end;
    class method mono_debug_open_image_from_memory(image: ^MonoImage; raw_contents: ^mono_byte; size: Int32): Void; public;
    begin
    end;
    class method mono_debug_cleanup: Void; public;
    begin
    end;
    class method mono_debug_close_image(image: ^MonoImage): Void; public;
    begin
    end;
    class method mono_debug_domain_unload(domain: ^MonoDomain): Void; public;
    begin
    end;
    class method mono_debug_domain_create(domain: ^MonoDomain): Void; public;
    begin
    end;
    class method mono_debug_add_method(&method: ^MonoMethod; jit: ^MonoDebugMethodJitInfo; domain: ^MonoDomain): ^MonoDebugMethodAddress; public;
    begin
    end;
    class method mono_debug_remove_method(&method: ^MonoMethod; domain: ^MonoDomain): Void; public;
    begin
    end;
    class method mono_debug_lookup_method(&method: ^MonoMethod): ^MonoDebugMethodInfo; public;
    begin
    end;
    class method mono_debug_lookup_method_addresses(&method: ^MonoMethod): ^MonoDebugMethodAddressList; public;
    begin
    end;
    class method mono_debug_find_method(&method: ^MonoMethod; domain: ^MonoDomain): ^MonoDebugMethodJitInfo; public;
    begin
    end;
    class method mono_debug_free_method_jit_info(jit: ^MonoDebugMethodJitInfo): Void; public;
    begin
    end;
    class method mono_debug_add_delegate_trampoline(code: ^Void; size: Int32): Void; public;
    begin
    end;
    class method mono_debug_lookup_locals(&method: ^MonoMethod): ^MonoDebugLocalsInfo; public;
    begin
    end;
    class method mono_debug_method_lookup_location(minfo: ^MonoDebugMethodInfo; il_offset: Int32): ^MonoDebugSourceLocation; public;
    begin
    end;
    class method mono_debug_lookup_source_location(&method: ^MonoMethod; address: uint32_t; domain: ^MonoDomain): ^MonoDebugSourceLocation; public;
    begin
    end;
    class method mono_debug_il_offset_from_address(&method: ^MonoMethod; domain: ^MonoDomain; native_offset: uint32_t): int32_t; public;
    begin
    end;
    class method mono_debug_free_source_location(location: ^MonoDebugSourceLocation): Void; public;
    begin
    end;
    class method mono_debug_print_stack_frame(&method: ^MonoMethod; native_offset: uint32_t; domain: ^MonoDomain): ^AnsiChar; public;
    begin
    end;
    class method mono_debugger_method_has_breakpoint(&method: ^MonoMethod): Int32; public;
    begin
    end;
    class method mono_debugger_insert_breakpoint(method_name: ^AnsiChar; include_namespace: mono_bool): Int32; public;
    begin
    end;
    class method mono_set_is_debugger_attached(attached: mono_bool): Void; public;
    begin
    end;
    class method mono_is_debugger_attached: mono_bool; public;
    begin
    end;
    class method mono_gc_collect(generation: Int32): Void; public;
    begin
    end;
    class method mono_gc_max_generation: Int32; public;
    begin
    end;
    class method mono_gc_get_generation(object: ^mono.metadata.MonoObject): Int32; public;
    begin
    end;
    class method mono_gc_collection_count(generation: Int32): Int32; public;
    begin
    end;
    class method mono_gc_get_used_size: int64_t; public;
    begin
    end;
    class method mono_gc_get_heap_size: int64_t; public;
    begin
    end;
    class method mono_gc_pending_finalizers: MonoBoolean; public;
    begin
    end;
    class method mono_gc_finalize_notify: Void; public;
    begin
    end;
    class method mono_gc_invoke_finalizers: Int32; public;
    begin
    end;
    class method mono_gc_walk_heap(&flags: Int32; callback: method(obj: ^mono.metadata.MonoObject; klass: ^MonoClass; size: uintptr_t; num: uintptr_t; refs: ^^mono.metadata.MonoObject; offsets: ^uintptr_t; data: ^Void): Int32; data: ^Void): Int32; public;
    begin
    end;
    class var MONO_FLOW_NEXT: Int32; public;
    class var MONO_FLOW_BRANCH: Int32; public;
    class var MONO_FLOW_COND_BRANCH: Int32; public;
    class var MONO_FLOW_ERROR: Int32; public;
    class var MONO_FLOW_CALL: Int32; public;
    class var MONO_FLOW_RETURN: Int32; public;
    class var MONO_FLOW_META: Int32; public;
    class var MonoInlineNone: Int32; public;
    class var MonoInlineType: Int32; public;
    class var MonoInlineField: Int32; public;
    class var MonoInlineMethod: Int32; public;
    class var MonoInlineTok: Int32; public;
    class var MonoInlineString: Int32; public;
    class var MonoInlineSig: Int32; public;
    class var MonoInlineVar: Int32; public;
    class var MonoShortInlineVar: Int32; public;
    class var MonoInlineBrTarget: Int32; public;
    class var MonoShortInlineBrTarget: Int32; public;
    class var MonoInlineSwitch: Int32; public;
    class var MonoInlineR: Int32; public;
    class var MonoShortInlineR: Int32; public;
    class var MonoInlineI: Int32; public;
    class var MonoShortInlineI: Int32; public;
    class var MonoInlineI8: Int32; public;
    class var mono_opcodes: ^mono.metadata.MonoOpcode; public;
    class method mono_opcode_name(opcode: Int32): ^AnsiChar; public;
    begin
    end;
    class method mono_opcode_value(ip: ^^mono_byte; &end: ^mono_byte): mono.metadata.MonoOpcodeEnum; public;
    begin
    end;
    class method mono_profiler_install(prof: ^MonoProfiler; shutdown_callback: method(prof: ^MonoProfiler): Void): Void; public;
    begin
    end;
    class method mono_profiler_set_events(events: mono.metadata.MonoProfileFlags): Void; public;
    begin
    end;
    class method mono_profiler_get_events: mono.metadata.MonoProfileFlags; public;
    begin
    end;
    class method mono_profiler_install_appdomain(start_load: method(prof: ^MonoProfiler; domain: ^MonoDomain): Void; end_load: method(prof: ^MonoProfiler; domain: ^MonoDomain; &result: Int32): Void; start_unload: method(prof: ^MonoProfiler; domain: ^MonoDomain): Void; end_unload: method(prof: ^MonoProfiler; domain: ^MonoDomain): Void): Void; public;
    begin
    end;
    class method mono_profiler_install_appdomain_name(domain_name_cb: method(prof: ^MonoProfiler; domain: ^MonoDomain; name: ^AnsiChar): Void): Void; public;
    begin
    end;
    class method mono_profiler_install_context(load: method(prof: ^MonoProfiler; context: ^MonoAppContext): Void; unload: method(prof: ^MonoProfiler; context: ^MonoAppContext): Void): Void; public;
    begin
    end;
    class method mono_profiler_install_assembly(start_load: method(prof: ^MonoProfiler; &assembly: ^MonoAssembly): Void; end_load: method(prof: ^MonoProfiler; &assembly: ^MonoAssembly; &result: Int32): Void; start_unload: method(prof: ^MonoProfiler; &assembly: ^MonoAssembly): Void; end_unload: method(prof: ^MonoProfiler; &assembly: ^MonoAssembly): Void): Void; public;
    begin
    end;
    class method mono_profiler_install_module(start_load: method(prof: ^MonoProfiler; &module: ^MonoImage): Void; end_load: method(prof: ^MonoProfiler; &module: ^MonoImage; &result: Int32): Void; start_unload: method(prof: ^MonoProfiler; &module: ^MonoImage): Void; end_unload: method(prof: ^MonoProfiler; &module: ^MonoImage): Void): Void; public;
    begin
    end;
    class method mono_profiler_install_class(start_load: method(prof: ^MonoProfiler; klass: ^MonoClass): Void; end_load: method(prof: ^MonoProfiler; klass: ^MonoClass; &result: Int32): Void; start_unload: method(prof: ^MonoProfiler; klass: ^MonoClass): Void; end_unload: method(prof: ^MonoProfiler; klass: ^MonoClass): Void): Void; public;
    begin
    end;
    class method mono_profiler_install_jit_compile(start: method(prof: ^MonoProfiler; &method: ^MonoMethod): Void; &end: method(prof: ^MonoProfiler; &method: ^MonoMethod; &result: Int32): Void): Void; public;
    begin
    end;
    class method mono_profiler_install_jit_end(&end: method(prof: ^MonoProfiler; &method: ^MonoMethod; jinfo: ^MonoJitInfo; &result: Int32): Void): Void; public;
    begin
    end;
    class method mono_profiler_install_method_free(callback: method(prof: ^MonoProfiler; &method: ^MonoMethod): Void): Void; public;
    begin
    end;
    class method mono_profiler_install_method_invoke(start: method(prof: ^MonoProfiler; &method: ^MonoMethod): Void; &end: method(prof: ^MonoProfiler; &method: ^MonoMethod): Void): Void; public;
    begin
    end;
    class method mono_profiler_install_enter_leave(enter: method(prof: ^MonoProfiler; &method: ^MonoMethod): Void; fleave: method(prof: ^MonoProfiler; &method: ^MonoMethod): Void): Void; public;
    begin
    end;
    class method mono_profiler_install_thread(start: method(prof: ^MonoProfiler; tid: uintptr_t): Void; &end: method(prof: ^MonoProfiler; tid: uintptr_t): Void): Void; public;
    begin
    end;
    class method mono_profiler_install_thread_name(thread_name_cb: method(prof: ^MonoProfiler; tid: uintptr_t; name: ^AnsiChar): Void): Void; public;
    begin
    end;
    class method mono_profiler_install_transition(callback: method(prof: ^MonoProfiler; &method: ^MonoMethod; &result: Int32): Void): Void; public;
    begin
    end;
    class method mono_profiler_install_allocation(callback: method(prof: ^MonoProfiler; obj: ^mono.metadata.MonoObject; klass: ^MonoClass): Void): Void; public;
    begin
    end;
    class method mono_profiler_install_monitor(callback: method(prof: ^MonoProfiler; obj: ^mono.metadata.MonoObject; &event: mono.metadata.MonoProfilerMonitorEvent): Void): Void; public;
    begin
    end;
    class method mono_profiler_install_statistical(callback: method(prof: ^MonoProfiler; ip: ^mono_byte; context: ^Void): Void): Void; public;
    begin
    end;
    class method mono_profiler_install_statistical_call_chain(callback: method(prof: ^MonoProfiler; call_chain_depth: Int32; ip: ^^mono_byte; context: ^Void): Void; call_chain_depth: Int32; call_chain_strategy: mono.metadata.MonoProfilerCallChainStrategy): Void; public;
    begin
    end;
    class method mono_profiler_install_exception(throw_callback: method(prof: ^MonoProfiler; object: ^mono.metadata.MonoObject): Void; exc_method_leave: method(prof: ^MonoProfiler; &method: ^MonoMethod): Void; clause_callback: method(prof: ^MonoProfiler; &method: ^MonoMethod; clause_type: Int32; clause_num: Int32): Void): Void; public;
    begin
    end;
    class method mono_profiler_install_coverage_filter(callback: method(prof: ^MonoProfiler; &method: ^MonoMethod): mono_bool): Void; public;
    begin
    end;
    class method mono_profiler_coverage_get(prof: ^MonoProfiler; &method: ^MonoMethod; func: method(prof: ^MonoProfiler; entry: ^mono.metadata.MonoProfileCoverageEntry): Void): Void; public;
    begin
    end;
    class method mono_profiler_install_gc(callback: method(prof: ^MonoProfiler; &event: mono.metadata.MonoGCEvent; generation: Int32): Void; heap_resize_callback: method(prof: ^MonoProfiler; new_size: int64_t): Void): Void; public;
    begin
    end;
    class method mono_profiler_install_gc_moves(callback: method(prof: ^MonoProfiler; objects: ^^Void; num: Int32): Void): Void; public;
    begin
    end;
    class method mono_profiler_install_gc_roots(handle_callback: method(prof: ^MonoProfiler; op: Int32; &type: Int32; handle: uintptr_t; obj: ^mono.metadata.MonoObject): Void; roots_callback: method(prof: ^MonoProfiler; num_roots: Int32; objects: ^^Void; root_types: ^Int32; extra_info: ^uintptr_t): Void): Void; public;
    begin
    end;
    class method mono_profiler_install_gc_finalize(&begin: method(prof: ^MonoProfiler): Void; begin_obj: method(prof: ^MonoProfiler; obj: ^mono.metadata.MonoObject): Void; end_obj: method(prof: ^MonoProfiler; obj: ^mono.metadata.MonoObject): Void; &end: method(prof: ^MonoProfiler): Void): Void; public;
    begin
    end;
    class method mono_profiler_install_runtime_initialized(runtime_initialized_callback: method(prof: ^MonoProfiler): Void): Void; public;
    begin
    end;
    class method mono_profiler_install_code_chunk_new(callback: method(prof: ^MonoProfiler; chunk: ^Void; size: Int32): Void): Void; public;
    begin
    end;
    class method mono_profiler_install_code_chunk_destroy(callback: method(prof: ^MonoProfiler; chunk: ^Void): Void): Void; public;
    begin
    end;
    class method mono_profiler_install_code_buffer_new(callback: method(prof: ^MonoProfiler; buffer: ^Void; size: Int32; &type: mono.metadata.MonoProfilerCodeBufferType; data: ^Void): Void): Void; public;
    begin
    end;
    class method mono_profiler_install_iomap(callback: method(prof: ^MonoProfiler; report: ^AnsiChar; pathname: ^AnsiChar; new_pathname: ^AnsiChar): Void): Void; public;
    begin
    end;
    class method mono_profiler_load(&desc: ^AnsiChar): Void; public;
    begin
    end;
    class method mono_profiler_set_statistical_mode(mode: mono.metadata.MonoProfileSamplingMode; sampling_frequency_hz: int64_t): Void; public;
    begin
    end;
    class method mono_thread_init(start_cb: method(tid: intptr_t; stack_start: ^Void; func: ^Void): Void; attach_cb: method(tid: intptr_t; stack_start: ^Void): Void): Void; public;
    begin
    end;
    class method mono_thread_cleanup: Void; public;
    begin
    end;
    class method mono_thread_manage: Void; public;
    begin
    end;
    class method mono_thread_current: ^MonoThread; public;
    begin
    end;
    class method mono_thread_set_main(thread: ^MonoThread): Void; public;
    begin
    end;
    class method mono_thread_get_main: ^MonoThread; public;
    begin
    end;
    class method mono_thread_stop(thread: ^MonoThread): Void; public;
    begin
    end;
    class method mono_thread_new_init(tid: intptr_t; stack_start: ^Void; func: ^Void): Void; public;
    begin
    end;
    class method mono_thread_create(domain: ^MonoDomain; func: ^Void; arg: ^Void): Void; public;
    begin
    end;
    class method mono_thread_attach(domain: ^MonoDomain): ^MonoThread; public;
    begin
    end;
    class method mono_thread_detach(thread: ^MonoThread): Void; public;
    begin
    end;
    class method mono_thread_exit: Void; public;
    begin
    end;
    class method mono_thread_get_name_utf8(thread: ^MonoThread): ^AnsiChar; public;
    begin
    end;
    class method mono_thread_get_managed_id(thread: ^MonoThread): int32_t; public;
    begin
    end;
    class method mono_thread_set_manage_callback(thread: ^MonoThread; func: method(thread: ^MonoThread): mono_bool): Void; public;
    begin
    end;
    class method mono_threads_set_default_stacksize(stacksize: uint32_t): Void; public;
    begin
    end;
    class method mono_threads_get_default_stacksize: uint32_t; public;
    begin
    end;
    class method mono_threads_request_thread_dump: Void; public;
    begin
    end;
    class method mono_thread_is_foreign(thread: ^MonoThread): mono_bool; public;
    begin
    end;
    class method mono_thread_detach_if_exiting: mono_bool; public;
    begin
    end;
    class var MONO_TABLE_LAST: Int32; public;
    class var MONO_TABLE_NUM: Int32; public;
    class method MONO_MARSHAL_CONV_INVALID: mono.metadata.MonoMarshalConv; public;
    begin
    end;
    class var _MONO_METADATA_LOADER_H_: Int32; public;
    class var MONO_DECLSEC_ACTION_MIN: Int32; public;
    class var MONO_DECLSEC_ACTION_MAX: Int32; public;
    class var MONO_DEBUG_VAR_ADDRESS_MODE_FLAGS: Int32; public;
    class var MONO_DEBUG_VAR_ADDRESS_MODE_REGISTER: Int32; public;
    class var MONO_DEBUG_VAR_ADDRESS_MODE_REGOFFSET: Int32; public;
    class var MONO_DEBUG_VAR_ADDRESS_MODE_TWO_REGISTERS: Int32; public;
    class var MONO_DEBUG_VAR_ADDRESS_MODE_DEAD: Int32; public;
    class var MONO_DEBUG_VAR_ADDRESS_MODE_REGOFFSET_INDIR: Int32; public;
    class var MONO_DEBUG_VAR_ADDRESS_MODE_GSHAREDVT_LOCAL: Int32; public;
    class var MONO_DEBUG_VAR_ADDRESS_MODE_VTADDR: Int32; public;
    class var MONO_DEBUGGER_MAJOR_VERSION: Int32; public;
    class var MONO_DEBUGGER_MINOR_VERSION: Int32; public;
    class var MONO_DEBUGGER_MAGIC: UInt64; public;
    class var MONO_CUSTOM_PREFIX: Int32; public;
    class var MONO_PROFILER_MAX_STAT_CALL_CHAIN_DEPTH: Int32; public;

  end;

  MonoImage = Void;

  MonoAssembly = Void;

  MonoAssemblyName = Void;

  MonoTableInfo = Void;

  mono.metadata.MonoImageOpenStatus = enum (MONO_IMAGE_OK = 0, MONO_IMAGE_ERROR_ERRNO = 1, MONO_IMAGE_MISSING_ASSEMBLYREF = 2, MONO_IMAGE_IMAGE_INVALID = 3);

  MonoClass = Void;

  MonoDomain = Void;

  MonoMethod = Void;

  mono.metadata.MonoExceptionEnum = enum (MONO_EXCEPTION_CLAUSE_NONE = 0, MONO_EXCEPTION_CLAUSE_FILTER = 1, MONO_EXCEPTION_CLAUSE_FINALLY = 2, MONO_EXCEPTION_CLAUSE_FAULT = 4);

  mono.metadata.MonoCallConvention = enum (MONO_CALL_DEFAULT = 0, MONO_CALL_C = 1, MONO_CALL_STDCALL = 2, MONO_CALL_THISCALL = 3, MONO_CALL_FASTCALL = 4, MONO_CALL_VARARG = 5);

  mono.metadata.MonoMarshalNative = enum (MONO_NATIVE_BOOLEAN = 2, MONO_NATIVE_I1 = 3, MONO_NATIVE_U1 = 4, MONO_NATIVE_I2 = 5, MONO_NATIVE_U2 = 6, MONO_NATIVE_I4 = 7, MONO_NATIVE_U4 = 33, MONO_NATIVE_I8 = 35, MONO_NATIVE_U8 = 36, MONO_NATIVE_R4 = 32, MONO_NATIVE_R8 = 34, MONO_NATIVE_CURRENCY = 8, MONO_NATIVE_BSTR = 43, MONO_NATIVE_LPSTR = 44, MONO_NATIVE_LPWSTR = 45, MONO_NATIVE_LPTSTR = 46, MONO_NATIVE_BYVALTSTR = 58, MONO_NATIVE_IUNKNOWN = 47, MONO_NATIVE_IDISPATCH = 59, MONO_NATIVE_STRUCT = 48, MONO_NATIVE_INTERFACE = 27, MONO_NATIVE_SAFEARRAY = 49, MONO_NATIVE_BYVALARRAY = 50, MONO_NATIVE_INT = 51, MONO_NATIVE_UINT = 52, MONO_NATIVE_VBBYREFSTR = 60, MONO_NATIVE_ANSIBSTR = 61, MONO_NATIVE_TBSTR = 62, MONO_NATIVE_VARIANTBOOL = 63, MONO_NATIVE_FUNC = 64, MONO_NATIVE_ASANY = 66, MONO_NATIVE_LPARRAY = 68, MONO_NATIVE_LPSTRUCT = 69, MONO_NATIVE_CUSTOM = 70, MONO_NATIVE_ERROR = 71, MONO_NATIVE_MAX = 82);

  mono.metadata.MonoMarshalVariant = enum (MONO_VARIANT_EMPTY = 0, MONO_VARIANT_NULL = 1, MONO_VARIANT_I2 = 2, MONO_VARIANT_I4 = 3, MONO_VARIANT_R4 = 4, MONO_VARIANT_R8 = 5, MONO_VARIANT_CY = 6, MONO_VARIANT_DATE = 7, MONO_VARIANT_BSTR = 33, MONO_VARIANT_DISPATCH = 35, MONO_VARIANT_ERROR = 36, MONO_VARIANT_BOOL = 32, MONO_VARIANT_VARIANT = 34, MONO_VARIANT_UNKNOWN = 38, MONO_VARIANT_DECIMAL = 39, MONO_VARIANT_I1 = 40, MONO_VARIANT_UI1 = 41, MONO_VARIANT_UI2 = 42, MONO_VARIANT_UI4 = 43, MONO_VARIANT_I8 = 44, MONO_VARIANT_UI8 = 45, MONO_VARIANT_INT = 46, MONO_VARIANT_UINT = 58, MONO_VARIANT_VOID = 21, MONO_VARIANT_HRESULT = 47, MONO_VARIANT_PTR = 59, MONO_VARIANT_SAFEARRAY = 48, MONO_VARIANT_CARRAY = 27, MONO_VARIANT_USERDEFINED = 49, MONO_VARIANT_LPSTR = 50, MONO_VARIANT_LPWSTR = 51, MONO_VARIANT_RECORD = 62, MONO_VARIANT_FILETIME = 54, MONO_VARIANT_BLOB = 55, MONO_VARIANT_STREAM = 83, MONO_VARIANT_STORAGE = 84, MONO_VARIANT_STREAMED_OBJECT = 85, MONO_VARIANT_STORED_OBJECT = 56, MONO_VARIANT_BLOB_OBJECT = 86, MONO_VARIANT_CF = 87, MONO_VARIANT_CLSID = 88, MONO_VARIANT_VECTOR = 15, MONO_VARIANT_ARRAY = 16, MONO_VARIANT_BYREF = 17);

  mono.metadata.MonoMarshalConv = enum (MONO_MARSHAL_CONV_NONE = 0, MONO_MARSHAL_CONV_BOOL_VARIANTBOOL = 1, MONO_MARSHAL_CONV_BOOL_I4 = 2, MONO_MARSHAL_CONV_STR_BSTR = 3, MONO_MARSHAL_CONV_STR_LPSTR = 4, MONO_MARSHAL_CONV_LPSTR_STR = 5, MONO_MARSHAL_CONV_LPTSTR_STR = 6, MONO_MARSHAL_CONV_STR_LPWSTR = 7, MONO_MARSHAL_CONV_LPWSTR_STR = 33, MONO_MARSHAL_CONV_STR_LPTSTR = 35, MONO_MARSHAL_CONV_STR_ANSIBSTR = 36, MONO_MARSHAL_CONV_STR_TBSTR = 32, MONO_MARSHAL_CONV_STR_BYVALSTR = 34, MONO_MARSHAL_CONV_STR_BYVALWSTR = 38, MONO_MARSHAL_CONV_SB_LPSTR = 39, MONO_MARSHAL_CONV_SB_LPTSTR = 8, MONO_MARSHAL_CONV_SB_LPWSTR = 40, MONO_MARSHAL_CONV_LPSTR_SB = 41, MONO_MARSHAL_CONV_LPTSTR_SB = 42, MONO_MARSHAL_CONV_LPWSTR_SB = 43, MONO_MARSHAL_CONV_ARRAY_BYVALARRAY = 44, MONO_MARSHAL_CONV_ARRAY_BYVALCHARARRAY = 45, MONO_MARSHAL_CONV_ARRAY_SAVEARRAY = 46, MONO_MARSHAL_CONV_ARRAY_LPARRAY = 58, MONO_MARSHAL_FREE_LPARRAY = 21, MONO_MARSHAL_CONV_OBJECT_INTERFACE = 47, MONO_MARSHAL_CONV_OBJECT_IDISPATCH = 59, MONO_MARSHAL_CONV_OBJECT_IUNKNOWN = 48, MONO_MARSHAL_CONV_OBJECT_STRUCT = 27, MONO_MARSHAL_CONV_DEL_FTN = 49, MONO_MARSHAL_CONV_FTN_DEL = 50, MONO_MARSHAL_FREE_ARRAY = 51, MONO_MARSHAL_CONV_BSTR_STR = 52, MONO_MARSHAL_CONV_SAFEHANDLE = 53, MONO_MARSHAL_CONV_HANDLEREF = 60);

  mono.metadata.MonoMarshalSpec = record
  private

    var native: mono.metadata.MonoMarshalNative; public;
    var data: __AnonymousType1; public;

  end;

  // Union
  __AnonymousType1 nested in mono.metadata.MonoMarshalSpec = public record
  private

    var array_data: __AnonymousType1; public;
    var custom_data: __AnonymousType2; public;
    var safearray_data: __AnonymousType3; public;

  end;

  __AnonymousType1 nested in __AnonymousType1 nested in mono.metadata.MonoMarshalSpec = public record
  private

    var elem_type: mono.metadata.MonoMarshalNative; public;
    var num_elem: int32_t; public;
    var param_num: int16_t; public;
    var elem_mult: int16_t; public;

  end;

  __AnonymousType2 nested in __AnonymousType1 nested in mono.metadata.MonoMarshalSpec = public record
  private

    var custom_name: ^AnsiChar; public;
    var cookie: ^AnsiChar; public;
    var image: ^MonoImage; public;

  end;

  __AnonymousType3 nested in __AnonymousType1 nested in mono.metadata.MonoMarshalSpec = public record
  private

    var elem_type: mono.metadata.MonoMarshalVariant; public;
    var num_elem: int32_t; public;

  end;

  mono.metadata.MonoExceptionClause = record
  private

    var &flags: uint32_t; public;
    var try_offset: uint32_t; public;
    var try_len: uint32_t; public;
    var handler_offset: uint32_t; public;
    var handler_len: uint32_t; public;
    var data: __AnonymousType5; public;

  end;

  // Union
  __AnonymousType5 nested in mono.metadata.MonoExceptionClause = public record
  private

    var filter_offset: uint32_t; public;
    var catch_class: ^MonoClass; public;

  end;

  MonoType = Void;

  MonoGenericInst = Void;

  MonoGenericClass = Void;

  MonoGenericContext = Void;

  MonoGenericContainer = Void;

  MonoGenericParam = Void;

  MonoArrayType = mono.metadata.__struct__MonoArrayType;

  MonoMethodSignature = Void;

  MonoGenericMethod = Void;

  mono.metadata.MonoCustomMod = record
  private

    var required: UInt32; public;
    var token: UInt32; public;

  end;

  mono.metadata.__struct__MonoArrayType = record
  private

    var eklass: ^MonoClass; public;
    var rank: uint8_t; public;
    var numsizes: uint8_t; public;
    var numlobounds: uint8_t; public;
    var sizes: ^Int32; public;
    var lobounds: ^Int32; public;

  end;

  MonoMethodHeader = Void;

  mono.metadata.MonoParseTypeMode = enum (MONO_PARSE_TYPE = 0, MONO_PARSE_MOD_TYPE = 1, MONO_PARSE_LOCAL = 2, MONO_PARSE_PARAM = 3, MONO_PARSE_RET = 4, MONO_PARSE_FIELD = 5);

  mono.metadata.MonoStackWalk = block(&method: ^MonoMethod; native_offset: int32_t; il_offset: int32_t; managed: mono_bool; data: ^Void): mono_bool;

  mono.metadata.MonoStackWalkAsyncSafe = block(&method: ^MonoMethod; domain: ^MonoDomain; base_address: ^Void; offset: Int32; data: ^Void): mono_bool;

  MonoVTable = Void;

  MonoClassField = Void;

  MonoProperty = Void;

  MonoEvent = Void;

  MonoBoolean = mono_byte;

  MonoString = Void;

  MonoArray = Void;

  MonoReflectionMethod = Void;

  MonoReflectionAssembly = Void;

  MonoReflectionModule = Void;

  MonoReflectionField = Void;

  MonoReflectionProperty = Void;

  MonoReflectionEvent = Void;

  MonoReflectionType = Void;

  MonoDelegate = Void;

  MonoException = Void;

  MonoThreadsSync = Void;

  MonoThread = Void;

  MonoDynamicAssembly = Void;

  MonoDynamicImage = Void;

  MonoReflectionMethodBody = Void;

  MonoAppContext = Void;

  mono.metadata.MonoObject = record
  private

    var vtable: ^MonoVTable; public;
    var synchronisation: ^MonoThreadsSync; public;

  end;

  mono.metadata.MonoObject = record
  private

    var vtable: ^MonoVTable; public;
    var synchronisation: ^MonoThreadsSync; public;

  end;

  mono.metadata.MonoInvokeFunc = block(&method: ^MonoMethod; obj: ^Void; &params: ^^Void; exc: ^^mono.metadata.MonoObject; error: ^mono.utils.MonoError): ^mono.metadata.MonoObject;

  mono.metadata.MonoCompileFunc = block(&method: ^MonoMethod): ^Void;

  mono.metadata.MonoMainThreadFunc = block(user_data: ^Void): Void;

  mono.metadata.MonoMainThreadFunc = block(user_data: ^Void): Void;

  MonoReferenceQueue = Void;

  MonoTypeNameParse = Void;

  mono.metadata.MonoCustomAttrEntry = record
  private

    var ctor: ^MonoMethod; public;
    var data_size: uint32_t; public;
    var data: ^mono_byte; public;

  end;

  mono.metadata.MonoCustomAttrInfo = record
  private

    var num_attrs: Int32; public;
    var cached: Int32; public;
    var image: ^MonoImage; public;
    var attrs: array of mono.metadata.MonoCustomAttrEntry; public;

  end;

  mono.metadata.MonoReflectionMethodAux = record
  private

    var param_names: ^^AnsiChar; public;
    var param_marshall: ^^mono.metadata.MonoMarshalSpec; public;
    var param_cattr: ^^mono.metadata.MonoCustomAttrInfo; public;
    var param_defaults: ^^uint8_t; public;
    var param_default_types: ^uint32_t; public;
    var dllentry: ^AnsiChar; public;
    var dll: ^AnsiChar; public;

  end;

  mono.metadata.MonoResolveTokenError = enum (ResolveTokenError_OutOfRange = 0, ResolveTokenError_BadTable = 1, ResolveTokenError_Other = 2);

  mono.metadata.MonoDeclSecurityEntry = record
  private

    var blob: ^AnsiChar; public;
    var size: uint32_t; public;
    var &index: uint32_t; public;

  end;

  mono.metadata.MonoDeclSecurityActions = record
  private

    var demand: mono.metadata.MonoDeclSecurityEntry; public;
    var noncasdemand: mono.metadata.MonoDeclSecurityEntry; public;
    var demandchoice: mono.metadata.MonoDeclSecurityEntry; public;

  end;

  mono.metadata.MonoThreadStartCB = block(tid: intptr_t; stack_start: ^Void; func: ^Void): Void;

  mono.metadata.MonoThreadAttachCB = block(tid: intptr_t; stack_start: ^Void): Void;

  MonoAppDomain = Void;

  MonoJitInfo = Void;

  mono.metadata.MonoDomainFunc = block(domain: ^MonoDomain; user_data: ^Void): Void;

  mono.metadata.MonoCoreClrPlatformCB = block(image_name: ^AnsiChar): mono_bool;

  mono.metadata.MonoAssemblyLoadFunc = block(&assembly: ^MonoAssembly; user_data: ^Void): Void;

  mono.metadata.MonoAssemblySearchFunc = block(aname: ^MonoAssemblyName; user_data: ^Void): ^MonoAssembly;

  mono.metadata.MonoAssemblyPreLoadFunc = block(aname: ^MonoAssemblyName; assemblies_path: ^^AnsiChar; user_data: ^Void): ^MonoAssembly;

  mono.metadata.MonoBundledAssembly = record
  private

    var name: ^AnsiChar; public;
    var data: ^Byte; public;
    var size: UInt32; public;

  end;

  MonoDisHelper = mono.metadata.__struct_MonoDisHelper;

  mono.metadata.MonoDisIndenter = block(dh: ^MonoDisHelper; &method: ^MonoMethod; ip_offset: uint32_t): ^AnsiChar;

  mono.metadata.MonoDisTokener = block(dh: ^MonoDisHelper; &method: ^MonoMethod; token: uint32_t): ^AnsiChar;

  mono.metadata.__struct_MonoDisHelper = record
  private

    var newline: ^AnsiChar; public;
    var label_format: ^AnsiChar; public;
    var label_target: ^AnsiChar; public;
    var indenter: method(dh: ^MonoDisHelper; &method: ^MonoMethod; ip_offset: uint32_t): ^AnsiChar; public;
    var tokener: method(dh: ^MonoDisHelper; &method: ^MonoMethod; token: uint32_t): ^AnsiChar; public;
    var user_data: ^Void; public;

  end;

  MonoMethodDesc = Void;

  MonoSymbolTable = mono.metadata.__struct__MonoSymbolTable;

  MonoDebugDataTable = Void;

  MonoSymbolFile = Void;

  MonoPPDBFile = Void;

  MonoDebugHandle = mono.metadata.__struct__MonoDebugHandle;

  MonoDebugLineNumberEntry = Void;

  MonoDebugVarInfo = mono.metadata.__struct__MonoDebugVarInfo;

  MonoDebugMethodJitInfo = mono.metadata.__struct__MonoDebugMethodJitInfo;

  MonoDebugMethodAddress = Void;

  MonoDebugMethodAddressList = mono.metadata.__struct__MonoDebugMethodAddressList;

  MonoDebugClassEntry = Void;

  MonoDebugMethodInfo = Void;

  MonoDebugLocalsInfo = Void;

  MonoDebugSourceLocation = mono.metadata.__struct__MonoDebugSourceLocation;

  MonoDebugList = mono.metadata.__struct__MonoDebugList;

  mono.metadata.MonoDebugFormat = enum (MONO_DEBUG_FORMAT_NONE = 0, MONO_DEBUG_FORMAT_MONO = 1, MONO_DEBUG_FORMAT_DEBUGGER = 2);

  mono.metadata.__struct__MonoDebugList = record
  private

    var next: ^MonoDebugList; public;
    var data: ^Void; public;

  end;

  mono.metadata.__struct__MonoSymbolTable = record
  private

    var magic: uint64_t; public;
    var version: uint32_t; public;
    var total_size: uint32_t; public;
    var corlib: ^MonoDebugHandle; public;
    var global_data_table: ^MonoDebugDataTable; public;
    var data_tables: ^MonoDebugList; public;
    var symbol_files: ^MonoDebugList; public;

  end;

  mono.metadata.__struct__MonoDebugHandle = record
  private

    var &index: uint32_t; public;
    var image_file: ^AnsiChar; public;
    var image: ^MonoImage; public;
    var type_table: ^MonoDebugDataTable; public;
    var symfile: ^MonoSymbolFile; public;
    var ppdb: ^MonoPPDBFile; public;

  end;

  mono.metadata.__struct__MonoDebugMethodJitInfo = record
  private

    var code_start: ^mono_byte; public;
    var code_size: uint32_t; public;
    var prologue_end: uint32_t; public;
    var epilogue_begin: uint32_t; public;
    var wrapper_addr: ^mono_byte; public;
    var num_line_numbers: uint32_t; public;
    var line_numbers: ^MonoDebugLineNumberEntry; public;
    var has_var_info: uint32_t; public;
    var num_params: uint32_t; public;
    var this_var: ^MonoDebugVarInfo; public;
    var &params: ^MonoDebugVarInfo; public;
    var num_locals: uint32_t; public;
    var locals: ^MonoDebugVarInfo; public;
    var gsharedvt_info_var: ^MonoDebugVarInfo; public;
    var gsharedvt_locals_var: ^MonoDebugVarInfo; public;

  end;

  mono.metadata.__struct__MonoDebugMethodAddressList = record
  private

    var size: uint32_t; public;
    var count: uint32_t; public;
    var data: array of mono_byte; public;

  end;

  mono.metadata.__struct__MonoDebugSourceLocation = record
  private

    var source_file: ^AnsiChar; public;
    var row: uint32_t; public;
    var column: uint32_t; public;
    var il_offset: uint32_t; public;

  end;

  mono.metadata.__struct__MonoDebugVarInfo = record
  private

    var &index: uint32_t; public;
    var offset: uint32_t; public;
    var size: uint32_t; public;
    var begin_scope: uint32_t; public;
    var end_scope: uint32_t; public;
    var &type: ^MonoType; public;

  end;

  mono.metadata.MonoGCReferences = block(obj: ^mono.metadata.MonoObject; klass: ^MonoClass; size: uintptr_t; num: uintptr_t; refs: ^^mono.metadata.MonoObject; offsets: ^uintptr_t; data: ^Void): Int32;

  mono.metadata.MonoGCRootSource = enum (MONO_ROOT_SOURCE_EXTERNAL = 0, MONO_ROOT_SOURCE_STACK = 1, MONO_ROOT_SOURCE_FINALIZER_QUEUE = 2, MONO_ROOT_SOURCE_STATIC = 3, MONO_ROOT_SOURCE_THREAD_STATIC = 4, MONO_ROOT_SOURCE_CONTEXT_STATIC = 5, MONO_ROOT_SOURCE_GC_HANDLE = 6, MONO_ROOT_SOURCE_JIT = 7, MONO_ROOT_SOURCE_THREADING = 33, MONO_ROOT_SOURCE_DOMAIN = 35, MONO_ROOT_SOURCE_REFLECTION = 36, MONO_ROOT_SOURCE_MARSHAL = 32, MONO_ROOT_SOURCE_THREAD_POOL = 34, MONO_ROOT_SOURCE_DEBUGGER = 38, MONO_ROOT_SOURCE_HANDLE = 39);

  mono.metadata.MonoOpcodeEnum = enum (MONO_CEE_NOP = 0, MONO_CEE_BREAK = 1, MONO_CEE_LDARG_0 = 2, MONO_CEE_LDARG_1 = 3, MONO_CEE_LDARG_2 = 4, MONO_CEE_LDARG_3 = 5, MONO_CEE_LDLOC_0 = 6, MONO_CEE_LDLOC_1 = 7, MONO_CEE_LDLOC_2 = 33, MONO_CEE_LDLOC_3 = 35, MONO_CEE_STLOC_0 = 36, MONO_CEE_STLOC_1 = 32, MONO_CEE_STLOC_2 = 34, MONO_CEE_STLOC_3 = 38, MONO_CEE_LDARG_S = 39, MONO_CEE_LDARGA_S = 8, MONO_CEE_STARG_S = 40, MONO_CEE_LDLOC_S = 41, MONO_CEE_LDLOCA_S = 42, MONO_CEE_STLOC_S = 43, MONO_CEE_LDNULL = 44, MONO_CEE_LDC_I4_M1 = 45, MONO_CEE_LDC_I4_0 = 46, MONO_CEE_LDC_I4_1 = 58, MONO_CEE_LDC_I4_2 = 21, MONO_CEE_LDC_I4_3 = 47, MONO_CEE_LDC_I4_4 = 59, MONO_CEE_LDC_I4_5 = 48, MONO_CEE_LDC_I4_6 = 27, MONO_CEE_LDC_I4_7 = 49, MONO_CEE_LDC_I4_8 = 50, MONO_CEE_LDC_I4_S = 51, MONO_CEE_LDC_I4 = 52, MONO_CEE_LDC_I8 = 53, MONO_CEE_LDC_R4 = 60, MONO_CEE_LDC_R8 = 61, MONO_CEE_UNUSED99 = 62, MONO_CEE_DUP = 63, MONO_CEE_POP = 64, MONO_CEE_JMP = 65, MONO_CEE_CALL = 66, MONO_CEE_CALLI = 67, MONO_CEE_RET = 68, MONO_CEE_BR_S = 69, MONO_CEE_BRFALSE_S = 70, MONO_CEE_BRTRUE_S = 71, MONO_CEE_BEQ_S = 72, MONO_CEE_BGE_S = 73, MONO_CEE_BGT_S = 74, MONO_CEE_BLE_S = 75, MONO_CEE_BLT_S = 76, MONO_CEE_BNE_UN_S = 77, MONO_CEE_BGE_UN_S = 78, MONO_CEE_BGT_UN_S = 79, MONO_CEE_BLE_UN_S = 80, MONO_CEE_BLT_UN_S = 81, MONO_CEE_BR = 108, MONO_CEE_BRFALSE = 109, MONO_CEE_BRTRUE = 110, MONO_CEE_BEQ = 111, MONO_CEE_BGE = 112, MONO_CEE_BGT = 113, MONO_CEE_BLE = 114, MONO_CEE_BLT = 115, MONO_CEE_BNE_UN = 54, MONO_CEE_BGE_UN = 55, MONO_CEE_BGT_UN = 83, MONO_CEE_BLE_UN = 84, MONO_CEE_BLT_UN = 85, MONO_CEE_SWITCH = 56, MONO_CEE_LDIND_I1 = 86, MONO_CEE_LDIND_U1 = 87, MONO_CEE_LDIND_I2 = 88, MONO_CEE_LDIND_U2 = 116, MONO_CEE_LDIND_I4 = 117, MONO_CEE_LDIND_U4 = 118, MONO_CEE_LDIND_I8 = 119, MONO_CEE_LDIND_I = 120, MONO_CEE_LDIND_R4 = 121, MONO_CEE_LDIND_R8 = 122, MONO_CEE_LDIND_REF = 82, MONO_CEE_STIND_REF = 123, MONO_CEE_STIND_I1 = 124, MONO_CEE_STIND_I2 = 125, MONO_CEE_STIND_I4 = 126, MONO_CEE_STIND_I8 = 57, MONO_CEE_STIND_R4 = 127, MONO_CEE_STIND_R8 = 128, MONO_CEE_ADD = 129, 
MONO_CEE_SUB = 130, MONO_CEE_MUL = 131, MONO_CEE_DIV = 132, MONO_CEE_DIV_UN = 133, MONO_CEE_REM = 134, MONO_CEE_REM_UN = 135, MONO_CEE_AND = 136, MONO_CEE_OR = 137, MONO_CEE_XOR = 138, MONO_CEE_SHL = 139, MONO_CEE_SHR = 140, MONO_CEE_SHR_UN = 141, MONO_CEE_NEG = 142, MONO_CEE_NOT = 143, MONO_CEE_CONV_I1 = 144, MONO_CEE_CONV_I2 = 145, MONO_CEE_CONV_I4 = 146, MONO_CEE_CONV_I8 = 147, MONO_CEE_CONV_R4 = 148, MONO_CEE_CONV_R8 = 149, MONO_CEE_CONV_U4 = 150, MONO_CEE_CONV_U8 = 151, MONO_CEE_CALLVIRT = 152, MONO_CEE_CPOBJ = 153, MONO_CEE_LDOBJ = 154, MONO_CEE_LDSTR = 155, MONO_CEE_NEWOBJ = 156, MONO_CEE_CASTCLASS = 157, MONO_CEE_ISINST = 158, MONO_CEE_CONV_R_UN = 159, MONO_CEE_UNUSED58 = 160, MONO_CEE_UNUSED1 = 161, MONO_CEE_UNBOX = 162, MONO_CEE_THROW = 163, MONO_CEE_LDFLD = 164, MONO_CEE_LDFLDA = 165, MONO_CEE_STFLD = 166, MONO_CEE_LDSFLD = 167, MONO_CEE_LDSFLDA = 168, MONO_CEE_STSFLD = 9, MONO_CEE_STOBJ = 169, MONO_CEE_CONV_OVF_I1_UN = 170, MONO_CEE_CONV_OVF_I2_UN = 171, MONO_CEE_CONV_OVF_I4_UN = 172, MONO_CEE_CONV_OVF_I8_UN = 173, MONO_CEE_CONV_OVF_U1_UN = 174, MONO_CEE_CONV_OVF_U2_UN = 175, MONO_CEE_CONV_OVF_U4_UN = 176, MONO_CEE_CONV_OVF_U8_UN = 177, MONO_CEE_CONV_OVF_I_UN = 178, MONO_CEE_CONV_OVF_U_UN = 179, MONO_CEE_BOX = 180, MONO_CEE_NEWARR = 181, MONO_CEE_LDLEN = 182, MONO_CEE_LDELEMA = 183, MONO_CEE_LDELEM_I1 = 184, MONO_CEE_LDELEM_U1 = 185, MONO_CEE_LDELEM_I2 = 186, MONO_CEE_LDELEM_U2 = 187, MONO_CEE_LDELEM_I4 = 188, MONO_CEE_LDELEM_U4 = 189, MONO_CEE_LDELEM_I8 = 190, MONO_CEE_LDELEM_I = 191, MONO_CEE_LDELEM_R4 = 192, MONO_CEE_LDELEM_R8 = 193, MONO_CEE_LDELEM_REF = 194, MONO_CEE_STELEM_I = 195, MONO_CEE_STELEM_I1 = 196, MONO_CEE_STELEM_I2 = 197, MONO_CEE_STELEM_I4 = 198, MONO_CEE_STELEM_I8 = 199, MONO_CEE_STELEM_R4 = 200, MONO_CEE_STELEM_R8 = 201, MONO_CEE_STELEM_REF = 202, MONO_CEE_LDELEM = 203, MONO_CEE_STELEM = 204, MONO_CEE_UNBOX_ANY = 205, MONO_CEE_UNUSED5 = 206, MONO_CEE_UNUSED6 = 207, MONO_CEE_UNUSED7 = 208, MONO_CEE_UNUSED8 = 209, MONO_CEE_UNUSED9 = 210, MONO_CEE_UNUSED10 = 211, MONO_CEE_UNUSED11 = 212, 
MONO_CEE_UNUSED12 = 213, MONO_CEE_UNUSED13 = 214, MONO_CEE_UNUSED14 = 215, MONO_CEE_UNUSED15 = 216, MONO_CEE_UNUSED16 = 217, MONO_CEE_UNUSED17 = 218, MONO_CEE_CONV_OVF_I1 = 219, MONO_CEE_CONV_OVF_U1 = 220, MONO_CEE_CONV_OVF_I2 = 221, MONO_CEE_CONV_OVF_U2 = 222, MONO_CEE_CONV_OVF_I4 = 223, MONO_CEE_CONV_OVF_U4 = 224, MONO_CEE_CONV_OVF_I8 = 225, MONO_CEE_CONV_OVF_U8 = 226, MONO_CEE_UNUSED50 = 227, MONO_CEE_UNUSED18 = 228, MONO_CEE_UNUSED19 = 229, MONO_CEE_UNUSED20 = 230, MONO_CEE_UNUSED21 = 231, MONO_CEE_UNUSED22 = 232, MONO_CEE_UNUSED23 = 233, MONO_CEE_REFANYVAL = 234, MONO_CEE_CKFINITE = 235, MONO_CEE_UNUSED24 = 236, MONO_CEE_UNUSED25 = 237, MONO_CEE_MKREFANY = 238, MONO_CEE_UNUSED59 = 239, MONO_CEE_UNUSED60 = 240, MONO_CEE_UNUSED61 = 241, MONO_CEE_UNUSED62 = 242, MONO_CEE_UNUSED63 = 243, MONO_CEE_UNUSED64 = 244, MONO_CEE_UNUSED65 = 245, MONO_CEE_UNUSED66 = 246, MONO_CEE_UNUSED67 = 247, MONO_CEE_LDTOKEN = 248, MONO_CEE_CONV_U2 = 249, MONO_CEE_CONV_U1 = 250, MONO_CEE_CONV_I = 251, MONO_CEE_CONV_OVF_I = 252, MONO_CEE_CONV_OVF_U = 253, MONO_CEE_ADD_OVF = 254, MONO_CEE_ADD_OVF_UN = 255, MONO_CEE_MUL_OVF = 256, MONO_CEE_MUL_OVF_UN = 257, MONO_CEE_SUB_OVF = 258, MONO_CEE_SUB_OVF_UN = 259, MONO_CEE_ENDFINALLY = 260, MONO_CEE_LEAVE = 261, MONO_CEE_LEAVE_S = 262, MONO_CEE_STIND_I = 263, MONO_CEE_CONV_U = 264, MONO_CEE_UNUSED26 = 265, MONO_CEE_UNUSED27 = 266, MONO_CEE_UNUSED28 = 267, MONO_CEE_UNUSED29 = 268, MONO_CEE_UNUSED30 = 269, MONO_CEE_UNUSED31 = 270, MONO_CEE_UNUSED32 = 271, MONO_CEE_UNUSED33 = 272, MONO_CEE_UNUSED34 = 273, MONO_CEE_UNUSED35 = 274, MONO_CEE_UNUSED36 = 275, MONO_CEE_UNUSED37 = 276, MONO_CEE_UNUSED38 = 277, MONO_CEE_UNUSED39 = 278, MONO_CEE_UNUSED40 = 279, MONO_CEE_UNUSED41 = 280, MONO_CEE_UNUSED42 = 281, MONO_CEE_UNUSED43 = 282, MONO_CEE_UNUSED44 = 283, MONO_CEE_UNUSED45 = 284, MONO_CEE_UNUSED46 = 285, MONO_CEE_UNUSED47 = 286, MONO_CEE_UNUSED48 = 287, MONO_CEE_PREFIX7 = 288, MONO_CEE_PREFIX6 = 289, MONO_CEE_PREFIX5 = 290, MONO_CEE_PREFIX4 = 291, MONO_CEE_PREFIX3 = 292, MONO_CEE_PREFIX2 = 293, MONO_CEE_PREFIX1 = 294, 
MONO_CEE_PREFIXREF = 295, MONO_CEE_ARGLIST = 11, MONO_CEE_CEQ = 296, MONO_CEE_CGT = 297, MONO_CEE_CGT_UN = 298, MONO_CEE_CLT = 299, MONO_CEE_CLT_UN = 300, MONO_CEE_LDFTN = 301, MONO_CEE_LDVIRTFTN = 302, MONO_CEE_UNUSED56 = 303, MONO_CEE_LDARG = 304, MONO_CEE_LDARGA = 305, MONO_CEE_STARG = 306, MONO_CEE_LDLOC = 307, MONO_CEE_LDLOCA = 308, MONO_CEE_STLOC = 309, MONO_CEE_LOCALLOC = 310, MONO_CEE_UNUSED57 = 311, MONO_CEE_ENDFILTER = 312, MONO_CEE_UNALIGNED_ = 313, MONO_CEE_VOLATILE_ = 314, MONO_CEE_TAIL_ = 315, MONO_CEE_INITOBJ = 316, MONO_CEE_CONSTRAINED_ = 317, MONO_CEE_CPBLK = 318, MONO_CEE_INITBLK = 319, MONO_CEE_NO_ = 320, MONO_CEE_RETHROW = 321, MONO_CEE_UNUSED = 322, MONO_CEE_SIZEOF = 323, MONO_CEE_REFANYTYPE = 324, MONO_CEE_READONLY_ = 325, MONO_CEE_UNUSED53 = 326, MONO_CEE_UNUSED54 = 327, MONO_CEE_UNUSED55 = 328, MONO_CEE_UNUSED70 = 329, MONO_CEE_ILLEGAL = 330, MONO_CEE_ENDMAC = 331, MONO_CEE_MONO_ICALL = 332, MONO_CEE_MONO_OBJADDR = 333, MONO_CEE_MONO_LDPTR = 334, MONO_CEE_MONO_VTADDR = 335, MONO_CEE_MONO_NEWOBJ = 336, MONO_CEE_MONO_RETOBJ = 337, MONO_CEE_MONO_LDNATIVEOBJ = 338, MONO_CEE_MONO_CISINST = 339, MONO_CEE_MONO_CCASTCLASS = 340, MONO_CEE_MONO_SAVE_LMF = 341, MONO_CEE_MONO_RESTORE_LMF = 342, MONO_CEE_MONO_CLASSCONST = 343, MONO_CEE_MONO_NOT_TAKEN = 344, MONO_CEE_MONO_TLS = 345, MONO_CEE_MONO_ICALL_ADDR = 346, MONO_CEE_MONO_DYN_CALL = 347, MONO_CEE_MONO_MEMORY_BARRIER = 348, MONO_CEE_MONO_JIT_ATTACH = 349, MONO_CEE_MONO_JIT_DETACH = 350, MONO_CEE_MONO_JIT_ICALL_ADDR = 351, MONO_CEE_MONO_LDPTR_INT_REQ_FLAG = 352, MONO_CEE_MONO_LDPTR_CARD_TABLE = 353, MONO_CEE_MONO_LDPTR_NURSERY_START = 354, MONO_CEE_MONO_LDPTR_NURSERY_BITS = 355, MONO_CEE_MONO_CALLI_EXTRA_ARG = 356, MONO_CEE_MONO_LDDOMAIN = 357, MONO_CEE_MONO_ATOMIC_STORE_I4 = 358, MONO_CEE_MONO_GET_LAST_ERROR = 359, MONO_CEE_LAST = 360);

  mono.metadata.MonoOpcode = record
  private

    var argument: Byte; public;
    var flow_type: Byte; public;
    var opval: UInt16; public;

  end;

  mono.metadata.MonoProfileFlags = enum (MONO_PROFILE_NONE = 0, MONO_PROFILE_APPDOMAIN_EVENTS = 1, MONO_PROFILE_ASSEMBLY_EVENTS = 2, MONO_PROFILE_MODULE_EVENTS = 4, MONO_PROFILE_CLASS_EVENTS = 33, MONO_PROFILE_JIT_COMPILATION = 40, MONO_PROFILE_INLINING = 52, MONO_PROFILE_EXCEPTIONS = 54, MONO_PROFILE_ALLOCATIONS = 9, MONO_PROFILE_GC = 11, MONO_PROFILE_THREADS = 12, MONO_PROFILE_REMOTING = 13, MONO_PROFILE_TRANSITIONS = 14, MONO_PROFILE_ENTER_LEAVE = 15, MONO_PROFILE_COVERAGE = 16, MONO_PROFILE_INS_COVERAGE = 17, MONO_PROFILE_STATISTICAL = 18, MONO_PROFILE_METHOD_EVENTS = 19, MONO_PROFILE_MONITOR_EVENTS = 89, MONO_PROFILE_IOMAP_EVENTS = 107, MONO_PROFILE_GC_MOVES = 361, MONO_PROFILE_GC_ROOTS = 104, MONO_PROFILE_CONTEXT_EVENTS = 105, MONO_PROFILE_GC_FINALIZATION = 362);

  mono.metadata.MonoProfileResult = enum (MONO_PROFILE_OK = 0, MONO_PROFILE_FAILED = 1);

  mono.metadata.MonoGCEvent = enum (MONO_GC_EVENT_START = 0, MONO_GC_EVENT_MARK_START = 1, MONO_GC_EVENT_MARK_END = 2, MONO_GC_EVENT_RECLAIM_START = 3, MONO_GC_EVENT_RECLAIM_END = 4, MONO_GC_EVENT_END = 5, MONO_GC_EVENT_PRE_STOP_WORLD = 6, MONO_GC_EVENT_POST_STOP_WORLD = 7, MONO_GC_EVENT_PRE_START_WORLD = 33, MONO_GC_EVENT_POST_START_WORLD = 35, MONO_GC_EVENT_PRE_STOP_WORLD_LOCKED = 36, MONO_GC_EVENT_POST_START_WORLD_UNLOCKED = 32);

  mono.metadata.MonoProfileCoverageEntry = record
  private

    var &method: ^MonoMethod; public;
    var iloffset: Int32; public;
    var counter: Int32; public;
    var filename: ^AnsiChar; public;
    var line: Int32; public;
    var col: Int32; public;

  end;

  mono.metadata.MonoProfilerCodeBufferType = enum (MONO_PROFILER_CODE_BUFFER_UNKNOWN = 0, MONO_PROFILER_CODE_BUFFER_METHOD = 1, MONO_PROFILER_CODE_BUFFER_METHOD_TRAMPOLINE = 2, MONO_PROFILER_CODE_BUFFER_UNBOX_TRAMPOLINE = 3, MONO_PROFILER_CODE_BUFFER_IMT_TRAMPOLINE = 4, MONO_PROFILER_CODE_BUFFER_GENERICS_TRAMPOLINE = 5, MONO_PROFILER_CODE_BUFFER_SPECIFIC_TRAMPOLINE = 6, MONO_PROFILER_CODE_BUFFER_HELPER = 7, MONO_PROFILER_CODE_BUFFER_MONITOR = 33, MONO_PROFILER_CODE_BUFFER_DELEGATE_INVOKE = 35, MONO_PROFILER_CODE_BUFFER_EXCEPTION_HANDLING = 36, MONO_PROFILER_CODE_BUFFER_LAST = 32);

  MonoProfiler = Void;

  mono.metadata.MonoProfilerMonitorEvent = enum (MONO_PROFILER_MONITOR_CONTENTION = 1, MONO_PROFILER_MONITOR_DONE = 2, MONO_PROFILER_MONITOR_FAIL = 3);

  mono.metadata.MonoProfilerCallChainStrategy = enum (MONO_PROFILER_CALL_CHAIN_NONE = 0, MONO_PROFILER_CALL_CHAIN_NATIVE = 1, MONO_PROFILER_CALL_CHAIN_GLIBC = 2, MONO_PROFILER_CALL_CHAIN_MANAGED = 3, MONO_PROFILER_CALL_CHAIN_INVALID = 4);

  mono.metadata.MonoProfileGCHandleEvent = enum (MONO_PROFILER_GC_HANDLE_CREATED = 0, MONO_PROFILER_GC_HANDLE_DESTROYED = 1);

  mono.metadata.MonoProfileGCRootType = enum (MONO_PROFILE_GC_ROOT_PINNING = 11, MONO_PROFILE_GC_ROOT_WEAKREF = 12, MONO_PROFILE_GC_ROOT_INTERIOR = 13, MONO_PROFILE_GC_ROOT_STACK = 0, MONO_PROFILE_GC_ROOT_FINALIZER = 1, MONO_PROFILE_GC_ROOT_HANDLE = 2, MONO_PROFILE_GC_ROOT_OTHER = 3, MONO_PROFILE_GC_ROOT_MISC = 4, MONO_PROFILE_GC_ROOT_TYPEMASK = 295);

  mono.metadata.MonoProfileFunc = block(prof: ^MonoProfiler): Void;

  mono.metadata.MonoProfileAppDomainFunc = block(prof: ^MonoProfiler; domain: ^MonoDomain): Void;

  mono.metadata.MonoProfileContextFunc = block(prof: ^MonoProfiler; context: ^MonoAppContext): Void;

  mono.metadata.MonoProfileMethodFunc = block(prof: ^MonoProfiler; &method: ^MonoMethod): Void;

  mono.metadata.MonoProfileClassFunc = block(prof: ^MonoProfiler; klass: ^MonoClass): Void;

  mono.metadata.MonoProfileModuleFunc = block(prof: ^MonoProfiler; &module: ^MonoImage): Void;

  mono.metadata.MonoProfileAssemblyFunc = block(prof: ^MonoProfiler; &assembly: ^MonoAssembly): Void;

  mono.metadata.MonoProfileMonitorFunc = block(prof: ^MonoProfiler; obj: ^mono.metadata.MonoObject; &event: mono.metadata.MonoProfilerMonitorEvent): Void;

  mono.metadata.MonoProfileExceptionFunc = block(prof: ^MonoProfiler; object: ^mono.metadata.MonoObject): Void;

  mono.metadata.MonoProfileExceptionClauseFunc = block(prof: ^MonoProfiler; &method: ^MonoMethod; clause_type: Int32; clause_num: Int32): Void;

  mono.metadata.MonoProfileAppDomainResult = block(prof: ^MonoProfiler; domain: ^MonoDomain; &result: Int32): Void;

  mono.metadata.MonoProfileAppDomainFriendlyNameFunc = block(prof: ^MonoProfiler; domain: ^MonoDomain; name: ^AnsiChar): Void;

  mono.metadata.MonoProfileMethodResult = block(prof: ^MonoProfiler; &method: ^MonoMethod; &result: Int32): Void;

  mono.metadata.MonoProfileJitResult = block(prof: ^MonoProfiler; &method: ^MonoMethod; jinfo: ^MonoJitInfo; &result: Int32): Void;

  mono.metadata.MonoProfileClassResult = block(prof: ^MonoProfiler; klass: ^MonoClass; &result: Int32): Void;

  mono.metadata.MonoProfileModuleResult = block(prof: ^MonoProfiler; &module: ^MonoImage; &result: Int32): Void;

  mono.metadata.MonoProfileAssemblyResult = block(prof: ^MonoProfiler; &assembly: ^MonoAssembly; &result: Int32): Void;

  mono.metadata.MonoProfileMethodInline = block(prof: ^MonoProfiler; parent: ^MonoMethod; child: ^MonoMethod; ok: ^Int32): Void;

  mono.metadata.MonoProfileThreadFunc = block(prof: ^MonoProfiler; tid: uintptr_t): Void;

  mono.metadata.MonoProfileThreadNameFunc = block(prof: ^MonoProfiler; tid: uintptr_t; name: ^AnsiChar): Void;

  mono.metadata.MonoProfileAllocFunc = block(prof: ^MonoProfiler; obj: ^mono.metadata.MonoObject; klass: ^MonoClass): Void;

  mono.metadata.MonoProfileStatFunc = block(prof: ^MonoProfiler; ip: ^mono_byte; context: ^Void): Void;

  mono.metadata.MonoProfileStatCallChainFunc = block(prof: ^MonoProfiler; call_chain_depth: Int32; ip: ^^mono_byte; context: ^Void): Void;

  mono.metadata.MonoProfileGCFunc = block(prof: ^MonoProfiler; &event: mono.metadata.MonoGCEvent; generation: Int32): Void;

  mono.metadata.MonoProfileGCMoveFunc = block(prof: ^MonoProfiler; objects: ^^Void; num: Int32): Void;

  mono.metadata.MonoProfileGCResizeFunc = block(prof: ^MonoProfiler; new_size: int64_t): Void;

  mono.metadata.MonoProfileGCHandleFunc = block(prof: ^MonoProfiler; op: Int32; &type: Int32; handle: uintptr_t; obj: ^mono.metadata.MonoObject): Void;

  mono.metadata.MonoProfileGCRootFunc = block(prof: ^MonoProfiler; num_roots: Int32; objects: ^^Void; root_types: ^Int32; extra_info: ^uintptr_t): Void;

  mono.metadata.MonoProfileFunc = block(prof: ^MonoProfiler): Void;

  mono.metadata.MonoProfileGCFinalizeObjectFunc = block(prof: ^MonoProfiler; obj: ^mono.metadata.MonoObject): Void;

  mono.metadata.MonoProfileIomapFunc = block(prof: ^MonoProfiler; report: ^AnsiChar; pathname: ^AnsiChar; new_pathname: ^AnsiChar): Void;

  mono.metadata.MonoProfileCoverageFilterFunc = block(prof: ^MonoProfiler; &method: ^MonoMethod): mono_bool;

  mono.metadata.MonoProfileCoverageFunc = block(prof: ^MonoProfiler; entry: ^mono.metadata.MonoProfileCoverageEntry): Void;

  mono.metadata.MonoProfilerCodeChunkNew = block(prof: ^MonoProfiler; chunk: ^Void; size: Int32): Void;

  mono.metadata.MonoProfilerCodeChunkDestroy = block(prof: ^MonoProfiler; chunk: ^Void): Void;

  mono.metadata.MonoProfilerCodeBufferNew = block(prof: ^MonoProfiler; buffer: ^Void; size: Int32; &type: mono.metadata.MonoProfilerCodeBufferType; data: ^Void): Void;

  mono.metadata.MonoProfileSamplingMode = enum (MONO_PROFILER_STAT_MODE_PROCESS = 0, MONO_PROFILER_STAT_MODE_REAL = 1);

  mono.metadata.MonoThreadManageCallback = block(thread: ^MonoThread): mono_bool;

  mono.metadata.MonoTokenType = enum (MONO_TOKEN_MODULE = 0, MONO_TOKEN_TYPE_REF = 23, MONO_TOKEN_TYPE_DEF = 24, MONO_TOKEN_FIELD_DEF = 26, MONO_TOKEN_METHOD_DEF = 363, MONO_TOKEN_PARAM_DEF = 364, MONO_TOKEN_INTERFACE_IMPL = 365, MONO_TOKEN_MEMBER_REF = 366, MONO_TOKEN_CUSTOM_ATTRIBUTE = 367, MONO_TOKEN_PERMISSION = 368, MONO_TOKEN_SIGNATURE = 369, MONO_TOKEN_EVENT = 370, MONO_TOKEN_PROPERTY = 371, MONO_TOKEN_MODULE_REF = 372, MONO_TOKEN_TYPE_SPEC = 373, MONO_TOKEN_ASSEMBLY = 30, MONO_TOKEN_ASSEMBLY_REF = 374, MONO_TOKEN_FILE = 375, MONO_TOKEN_EXPORTED_TYPE = 376, MONO_TOKEN_MANIFEST_RESOURCE = 377, MONO_TOKEN_GENERIC_PARAM = 378, MONO_TOKEN_METHOD_SPEC = 379, MONO_TOKEN_STRING = 380, MONO_TOKEN_NAME = 381, MONO_TOKEN_BASE_TYPE = 382);

  mono.jit.__Global = class
  private

    class method mono_jit_init(file: ^AnsiChar): ^MonoDomain; public;
    begin
    end;
    class method mono_jit_init_version(root_domain_name: ^AnsiChar; runtime_version: ^AnsiChar): ^MonoDomain; public;
    begin
    end;
    class method mono_jit_exec(domain: ^MonoDomain; &assembly: ^MonoAssembly; argc: Int32; argv: ^^AnsiChar): Int32; public;
    begin
    end;
    class method mono_jit_cleanup(domain: ^MonoDomain): Void; public;
    begin
    end;
    class method mono_jit_set_trace_options(options: ^AnsiChar): mono_bool; public;
    begin
    end;
    class method mono_set_signal_chaining(chain_signals: mono_bool): Void; public;
    begin
    end;
    class method mono_set_crash_chaining(chain_signals: mono_bool): Void; public;
    begin
    end;
    class method mono_jit_set_aot_only(aot_only: mono_bool): Void; public;
    begin
    end;
    class method mono_jit_set_aot_mode(mode: mono.jit.MonoAotMode): Void; public;
    begin
    end;
    class method mono_set_break_policy(policy_callback: method(&method: ^MonoMethod): mono.jit.MonoBreakPolicy): Void; public;
    begin
    end;
    class method mono_jit_parse_options(argc: Int32; argv: ^^AnsiChar): Void; public;
    begin
    end;
    class method mono_get_runtime_build_info: ^AnsiChar; public;
    begin
    end;
    class method mono_get_jit_info_from_method(domain: ^MonoDomain; &method: ^MonoMethod): ^MonoJitInfo; public;
    begin
    end;
    class method mono_aot_get_method(domain: ^MonoDomain; &method: ^MonoMethod): ^Void; public;
    begin
    end;

  end;

  mono.jit.MonoAotMode = enum (MONO_AOT_MODE_NONE = 0, MONO_AOT_MODE_NORMAL = 1, MONO_AOT_MODE_HYBRID = 2, MONO_AOT_MODE_FULL = 3, MONO_AOT_MODE_LLVMONLY = 4);

  mono.jit.MonoBreakPolicy = enum (MONO_BREAK_POLICY_ALWAYS = 0, MONO_BREAK_POLICY_NEVER = 1, MONO_BREAK_POLICY_ON_DBG = 2);

  mono.jit.MonoBreakPolicyFunc = block(&method: ^MonoMethod): mono.jit.MonoBreakPolicy;

end.
