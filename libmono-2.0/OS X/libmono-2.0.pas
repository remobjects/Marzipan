//  Import of libmono-2 ()
//  Frameworks:
//  Targets: x86_64
//  Dep fx:rtl
//  Dep libs:mono-2.0
//  Platform: OS X
namespace ;

interface

type
  mono.utils.mono_bool = public mono_bool;

  mono.utils.mono_byte = public mono_byte;

  mono.utils.mono_unichar2 = public mono_unichar2;

  mono.utils.mono_unichar4 = public mono_unichar4;

  mono.utils.MonoFunc = public method (data: ^Void; user_data: ^Void);

  mono.utils.MonoHFunc = public method (key: ^Void; value: ^Void; user_data: ^Void);

  mono.utils.__Global = public class
  public
    class method mono_free(Param0: ^Void);
    class const MONO_COUNTER_INT: Int32;
    class const MONO_COUNTER_UINT: Int32;
    class const MONO_COUNTER_WORD: Int32;
    class const MONO_COUNTER_LONG: Int32;
    class const MONO_COUNTER_ULONG: Int32;
    class const MONO_COUNTER_DOUBLE: Int32;
    class const MONO_COUNTER_STRING: Int32;
    class const MONO_COUNTER_TIME_INTERVAL: Int32;
    class const MONO_COUNTER_TYPE_MASK: Int32;
    class const MONO_COUNTER_CALLBACK: Int32;
    class const MONO_COUNTER_SECTION_MASK: Int32;
    class const MONO_COUNTER_JIT: Int64;
    class const MONO_COUNTER_GC: Int64;
    class const MONO_COUNTER_METADATA: Int64;
    class const MONO_COUNTER_GENERICS: Int64;
    class const MONO_COUNTER_SECURITY: Int64;
    class const MONO_COUNTER_RUNTIME: Int64;
    class const MONO_COUNTER_SYSTEM: Int64;
    class const MONO_COUNTER_PERFCOUNTERS: Int64;
    class const MONO_COUNTER_LAST_SECTION: Int32;
    class const MONO_COUNTER_UNIT_SHIFT: Int32;
    class const MONO_COUNTER_UNIT_MASK: Int64;
    class const MONO_COUNTER_RAW: Int64;
    class const MONO_COUNTER_BYTES: Int64;
    class const MONO_COUNTER_TIME: Int64;
    class const MONO_COUNTER_COUNT: Int64;
    class const MONO_COUNTER_PERCENTAGE: Int64;
    class const MONO_COUNTER_VARIANCE_SHIFT: Int32;
    class const MONO_COUNTER_VARIANCE_MASK: Int64;
    class const MONO_COUNTER_MONOTONIC: Int64;
    class const MONO_COUNTER_CONSTANT: Int64;
    class const MONO_COUNTER_VARIABLE: Int64;
    class method mono_counters_enable(section_mask: Int32);
    class method mono_counters_init;
    class method mono_counters_register(descr: ^AnsiChar; &type: Int32; addr: ^Void);
    class method mono_counters_register_with_size(name: ^AnsiChar; &type: Int32; addr: ^Void; size: Int32);
    class method mono_counters_on_register(callback: mono.utils.MonoCounterRegisterCallback);
    class method mono_counters_dump(section_mask: Int32; outfile: ^FILE);
    class method mono_counters_cleanup;
    class method mono_counters_foreach(cb: mono.utils.CountersEnumCallback; user_data: ^Void);
    class method mono_counters_sample(counter: ^MonoCounter; buffer: ^Void; buffer_size: Int32): Int32;
    class method mono_counter_get_name(name: ^MonoCounter): ^AnsiChar;
    class method mono_counter_get_type(counter: ^MonoCounter): Int32;
    class method mono_counter_get_section(counter: ^MonoCounter): Int32;
    class method mono_counter_get_unit(counter: ^MonoCounter): Int32;
    class method mono_counter_get_variance(counter: ^MonoCounter): Int32;
    class method mono_counter_get_size(counter: ^MonoCounter): size_t;
    class method mono_runtime_resource_limit(resource_type: Int32; soft_limit: uintptr_t; hard_limit: uintptr_t): Int32;
    class method mono_runtime_resource_set_callback(callback: mono.utils.MonoResourceCallback);
    class method mono_runtime_resource_check_limit(resource_type: Int32; value: uintptr_t);
    class const MONO_DL_LAZY: Int32;
    class const MONO_DL_LOCAL: Int32;
    class const MONO_DL_MASK: Int32;
    class method mono_dl_fallback_register(load_func: mono.utils.MonoDlFallbackLoad; symbol_func: mono.utils.MonoDlFallbackSymbol; close_func: mono.utils.MonoDlFallbackClose; user_data: ^Void): ^MonoDlFallbackHandler;
    class method mono_dl_fallback_unregister(handler: ^MonoDlFallbackHandler);
    class const MONO_ERROR_FREE_STRINGS: Int32;
    class const MONO_ERROR_INCOMPLETE: Int32;
    class const MONO_ERROR_NONE: Int32;
    class const MONO_ERROR_MISSING_METHOD: Int32;
    class const MONO_ERROR_MISSING_FIELD: Int32;
    class const MONO_ERROR_TYPE_LOAD: Int32;
    class const MONO_ERROR_FILE_NOT_FOUND: Int32;
    class const MONO_ERROR_BAD_IMAGE: Int32;
    class const MONO_ERROR_OUT_OF_MEMORY: Int32;
    class const MONO_ERROR_ARGUMENT: Int32;
    class const MONO_ERROR_NOT_VERIFIABLE: Int32;
    class const MONO_ERROR_GENERIC: Int32;
    class method mono_error_init(error: ^mono.utils.MonoError);
    class method mono_error_init_flags(error: ^mono.utils.MonoError; &flags: UInt16);
    class method mono_error_cleanup(error: ^mono.utils.MonoError);
    class method mono_error_ok(error: ^mono.utils.MonoError): mono_bool;
    class method mono_error_get_error_code(error: ^mono.utils.MonoError): UInt16;
    class method mono_error_get_message(error: ^mono.utils.MonoError): ^AnsiChar;
    class method mono_trace_set_level_string(value: ^AnsiChar);
    class method mono_trace_set_mask_string(value: ^AnsiChar);
    class method mono_trace_set_log_handler(callback: mono.utils.MonoLogCallback; user_data: ^Void);
    class method mono_trace_set_print_handler(callback: mono.utils.MonoPrintCallback);
    class method mono_trace_set_printerr_handler(callback: mono.utils.MonoPrintCallback);
  end;

  mono.utils.MonoCounter = public MonoCounter;

  mono.utils.MonoCounterRegisterCallback = public method (Param0: ^MonoCounter);

  mono.utils.CountersEnumCallback = public method (counter: ^MonoCounter; user_data: ^Void): mono_bool;

  mono.utils.MonoResourceType = public enum (
    MONO_RESOURCE_JIT_CODE,
    MONO_RESOURCE_METADATA,
    MONO_RESOURCE_GC_HEAP,
    MONO_RESOURCE_COUNT
  );

  mono.utils.MonoResourceCallback = public method (resource_type: Int32; value: uintptr_t; is_soft: Int32);

  mono.utils.MonoDlFallbackHandler = public MonoDlFallbackHandler;

  mono.utils.MonoDlFallbackLoad = public method (name: ^AnsiChar; &flags: Int32; err: ^^AnsiChar; user_data: ^Void): ^Void;

  mono.utils.MonoDlFallbackSymbol = public method (handle: ^Void; name: ^AnsiChar; err: ^^AnsiChar; user_data: ^Void): ^Void;

  mono.utils.MonoDlFallbackClose = public method (handle: ^Void; user_data: ^Void): ^Void;

  mono.utils.MonoError = public record
  public
    var error_code: UInt16;
    var hidden_0: UInt16;
    var hidden_1: array of ^Void;
    var hidden_2: array of AnsiChar;
  end;

  mono.utils.__struct__MonoError = public record
  public
    var error_code: UInt16;
    var hidden_0: UInt16;
    var hidden_1: array of ^Void;
    var hidden_2: array of AnsiChar;
  end;

  mono.utils.MonoLogCallback = public method (log_domain: ^AnsiChar; log_level: ^AnsiChar; message: ^AnsiChar; fatal: mono_bool; user_data: ^Void);

  mono.utils.MonoPrintCallback = public method (string: ^AnsiChar; is_stdout: mono_bool);

  mono.metadata.MonoTypeEnum = public enum (
    MONO_TYPE_END,
    MONO_TYPE_VOID,
    MONO_TYPE_BOOLEAN,
    MONO_TYPE_CHAR,
    MONO_TYPE_I1,
    MONO_TYPE_U1,
    MONO_TYPE_I2,
    MONO_TYPE_U2,
    MONO_TYPE_I4,
    MONO_TYPE_U4,
    MONO_TYPE_I8,
    MONO_TYPE_U8,
    MONO_TYPE_R4,
    MONO_TYPE_R8,
    MONO_TYPE_STRING,
    MONO_TYPE_PTR,
    MONO_TYPE_BYREF,
    MONO_TYPE_VALUETYPE,
    MONO_TYPE_CLASS,
    MONO_TYPE_VAR,
    MONO_TYPE_ARRAY,
    MONO_TYPE_GENERICINST,
    MONO_TYPE_TYPEDBYREF,
    MONO_TYPE_I,
    MONO_TYPE_U,
    MONO_TYPE_FNPTR,
    MONO_TYPE_OBJECT,
    MONO_TYPE_SZARRAY,
    MONO_TYPE_MVAR,
    MONO_TYPE_CMOD_REQD,
    MONO_TYPE_CMOD_OPT,
    MONO_TYPE_INTERNAL,
    MONO_TYPE_MODIFIER,
    MONO_TYPE_SENTINEL,
    MONO_TYPE_PINNED,
    MONO_TYPE_ENUM
  );

  mono.metadata.MonoMetaTableEnum = public enum (
    MONO_TABLE_MODULE,
    MONO_TABLE_TYPEREF,
    MONO_TABLE_TYPEDEF,
    MONO_TABLE_FIELD_POINTER,
    MONO_TABLE_FIELD,
    MONO_TABLE_METHOD_POINTER,
    MONO_TABLE_METHOD,
    MONO_TABLE_PARAM_POINTER,
    MONO_TABLE_PARAM,
    MONO_TABLE_INTERFACEIMPL,
    MONO_TABLE_MEMBERREF,
    MONO_TABLE_CONSTANT,
    MONO_TABLE_CUSTOMATTRIBUTE,
    MONO_TABLE_FIELDMARSHAL,
    MONO_TABLE_DECLSECURITY,
    MONO_TABLE_CLASSLAYOUT,
    MONO_TABLE_FIELDLAYOUT,
    MONO_TABLE_STANDALONESIG,
    MONO_TABLE_EVENTMAP,
    MONO_TABLE_EVENT_POINTER,
    MONO_TABLE_EVENT,
    MONO_TABLE_PROPERTYMAP,
    MONO_TABLE_PROPERTY_POINTER,
    MONO_TABLE_PROPERTY,
    MONO_TABLE_METHODSEMANTICS,
    MONO_TABLE_METHODIMPL,
    MONO_TABLE_MODULEREF,
    MONO_TABLE_TYPESPEC,
    MONO_TABLE_IMPLMAP,
    MONO_TABLE_FIELDRVA,
    MONO_TABLE_UNUSED6,
    MONO_TABLE_UNUSED7,
    MONO_TABLE_ASSEMBLY,
    MONO_TABLE_ASSEMBLYPROCESSOR,
    MONO_TABLE_ASSEMBLYOS,
    MONO_TABLE_ASSEMBLYREF,
    MONO_TABLE_ASSEMBLYREFPROCESSOR,
    MONO_TABLE_ASSEMBLYREFOS,
    MONO_TABLE_FILE,
    MONO_TABLE_EXPORTEDTYPE,
    MONO_TABLE_MANIFESTRESOURCE,
    MONO_TABLE_NESTEDCLASS,
    MONO_TABLE_GENERICPARAM,
    MONO_TABLE_METHODSPEC,
    MONO_TABLE_GENERICPARAMCONSTRAINT,
    MONO_TABLE_UNUSED8,
    MONO_TABLE_UNUSED9,
    MONO_TABLE_UNUSED10,
    MONO_TABLE_DOCUMENT,
    MONO_TABLE_METHODBODY,
    MONO_TABLE_LOCALSCOPE,
    MONO_TABLE_LOCALVARIABLE,
    MONO_TABLE_LOCALCONSTANT,
    MONO_TABLE_IMPORTSCOPE,
    MONO_TABLE_ASYNCMETHOD,
    MONO_TABLE_CUSTOMDEBUGINFORMATION
  );

  mono.metadata.__Global = public class
  public
    class const MONO_ASSEMBLY_HASH_ALG: Int32;
    class const MONO_ASSEMBLY_MAJOR_VERSION: Int32;
    class const MONO_ASSEMBLY_MINOR_VERSION: Int32;
    class const MONO_ASSEMBLY_BUILD_NUMBER: Int32;
    class const MONO_ASSEMBLY_REV_NUMBER: Int32;
    class const MONO_ASSEMBLY_FLAGS: Int32;
    class const MONO_ASSEMBLY_PUBLIC_KEY: Int32;
    class const MONO_ASSEMBLY_NAME: Int32;
    class const MONO_ASSEMBLY_CULTURE: Int32;
    class const MONO_ASSEMBLY_SIZE: Int32;
    class const MONO_ASSEMBLYOS_PLATFORM: Int32;
    class const MONO_ASSEMBLYOS_MAJOR_VERSION: Int32;
    class const MONO_ASSEMBLYOS_MINOR_VERSION: Int32;
    class const MONO_ASSEMBLYOS_SIZE: Int32;
    class const MONO_ASSEMBLY_PROCESSOR: Int32;
    class const MONO_ASSEMBLY_PROCESSOR_SIZE: Int32;
    class const MONO_ASSEMBLYREF_MAJOR_VERSION: Int32;
    class const MONO_ASSEMBLYREF_MINOR_VERSION: Int32;
    class const MONO_ASSEMBLYREF_BUILD_NUMBER: Int32;
    class const MONO_ASSEMBLYREF_REV_NUMBER: Int32;
    class const MONO_ASSEMBLYREF_FLAGS: Int32;
    class const MONO_ASSEMBLYREF_PUBLIC_KEY: Int32;
    class const MONO_ASSEMBLYREF_NAME: Int32;
    class const MONO_ASSEMBLYREF_CULTURE: Int32;
    class const MONO_ASSEMBLYREF_HASH_VALUE: Int32;
    class const MONO_ASSEMBLYREF_SIZE: Int32;
    class const MONO_ASSEMBLYREFOS_PLATFORM: Int32;
    class const MONO_ASSEMBLYREFOS_MAJOR_VERSION: Int32;
    class const MONO_ASSEMBLYREFOS_MINOR_VERSION: Int32;
    class const MONO_ASSEMBLYREFOS_ASSEMBLYREF: Int32;
    class const MONO_ASSEMBLYREFOS_SIZE: Int32;
    class const MONO_ASSEMBLYREFPROC_PROCESSOR: Int32;
    class const MONO_ASSEMBLYREFPROC_ASSEMBLYREF: Int32;
    class const MONO_ASSEMBLYREFPROC_SIZE: Int32;
    class const MONO_CLASS_LAYOUT_PACKING_SIZE: Int32;
    class const MONO_CLASS_LAYOUT_CLASS_SIZE: Int32;
    class const MONO_CLASS_LAYOUT_PARENT: Int32;
    class const MONO_CLASS_LAYOUT_SIZE: Int32;
    class const MONO_CONSTANT_TYPE: Int32;
    class const MONO_CONSTANT_PADDING: Int32;
    class const MONO_CONSTANT_PARENT: Int32;
    class const MONO_CONSTANT_VALUE: Int32;
    class const MONO_CONSTANT_SIZE: Int32;
    class const MONO_CUSTOM_ATTR_PARENT: Int32;
    class const MONO_CUSTOM_ATTR_TYPE: Int32;
    class const MONO_CUSTOM_ATTR_VALUE: Int32;
    class const MONO_CUSTOM_ATTR_SIZE: Int32;
    class const MONO_DECL_SECURITY_ACTION: Int32;
    class const MONO_DECL_SECURITY_PARENT: Int32;
    class const MONO_DECL_SECURITY_PERMISSIONSET: Int32;
    class const MONO_DECL_SECURITY_SIZE: Int32;
    class const MONO_EVENT_MAP_PARENT: Int32;
    class const MONO_EVENT_MAP_EVENTLIST: Int32;
    class const MONO_EVENT_MAP_SIZE: Int32;
    class const MONO_EVENT_FLAGS: Int32;
    class const MONO_EVENT_NAME: Int32;
    class const MONO_EVENT_TYPE: Int32;
    class const MONO_EVENT_SIZE: Int32;
    class const MONO_EVENT_POINTER_EVENT: Int32;
    class const MONO_EVENT_POINTER_SIZE: Int32;
    class const MONO_EXP_TYPE_FLAGS: Int32;
    class const MONO_EXP_TYPE_TYPEDEF: Int32;
    class const MONO_EXP_TYPE_NAME: Int32;
    class const MONO_EXP_TYPE_NAMESPACE: Int32;
    class const MONO_EXP_TYPE_IMPLEMENTATION: Int32;
    class const MONO_EXP_TYPE_SIZE: Int32;
    class const MONO_FIELD_FLAGS: Int32;
    class const MONO_FIELD_NAME: Int32;
    class const MONO_FIELD_SIGNATURE: Int32;
    class const MONO_FIELD_SIZE: Int32;
    class const MONO_FIELD_LAYOUT_OFFSET: Int32;
    class const MONO_FIELD_LAYOUT_FIELD: Int32;
    class const MONO_FIELD_LAYOUT_SIZE: Int32;
    class const MONO_FIELD_MARSHAL_PARENT: Int32;
    class const MONO_FIELD_MARSHAL_NATIVE_TYPE: Int32;
    class const MONO_FIELD_MARSHAL_SIZE: Int32;
    class const MONO_FIELD_POINTER_FIELD: Int32;
    class const MONO_FIELD_POINTER_SIZE: Int32;
    class const MONO_FIELD_RVA_RVA: Int32;
    class const MONO_FIELD_RVA_FIELD: Int32;
    class const MONO_FIELD_RVA_SIZE: Int32;
    class const MONO_FILE_FLAGS: Int32;
    class const MONO_FILE_NAME: Int32;
    class const MONO_FILE_HASH_VALUE: Int32;
    class const MONO_FILE_SIZE: Int32;
    class const MONO_IMPLMAP_FLAGS: Int32;
    class const MONO_IMPLMAP_MEMBER: Int32;
    class const MONO_IMPLMAP_NAME: Int32;
    class const MONO_IMPLMAP_SCOPE: Int32;
    class const MONO_IMPLMAP_SIZE: Int32;
    class const MONO_INTERFACEIMPL_CLASS: Int32;
    class const MONO_INTERFACEIMPL_INTERFACE: Int32;
    class const MONO_INTERFACEIMPL_SIZE: Int32;
    class const MONO_MANIFEST_OFFSET: Int32;
    class const MONO_MANIFEST_FLAGS: Int32;
    class const MONO_MANIFEST_NAME: Int32;
    class const MONO_MANIFEST_IMPLEMENTATION: Int32;
    class const MONO_MANIFEST_SIZE: Int32;
    class const MONO_MEMBERREF_CLASS: Int32;
    class const MONO_MEMBERREF_NAME: Int32;
    class const MONO_MEMBERREF_SIGNATURE: Int32;
    class const MONO_MEMBERREF_SIZE: Int32;
    class const MONO_METHOD_RVA: Int32;
    class const MONO_METHOD_IMPLFLAGS: Int32;
    class const MONO_METHOD_FLAGS: Int32;
    class const MONO_METHOD_NAME: Int32;
    class const MONO_METHOD_SIGNATURE: Int32;
    class const MONO_METHOD_PARAMLIST: Int32;
    class const MONO_METHOD_SIZE: Int32;
    class const MONO_METHODIMPL_CLASS: Int32;
    class const MONO_METHODIMPL_BODY: Int32;
    class const MONO_METHODIMPL_DECLARATION: Int32;
    class const MONO_METHODIMPL_SIZE: Int32;
    class const MONO_METHOD_POINTER_METHOD: Int32;
    class const MONO_METHOD_POINTER_SIZE: Int32;
    class const MONO_METHOD_SEMA_SEMANTICS: Int32;
    class const MONO_METHOD_SEMA_METHOD: Int32;
    class const MONO_METHOD_SEMA_ASSOCIATION: Int32;
    class const MONO_METHOD_SEMA_SIZE: Int32;
    class const MONO_MODULE_GENERATION: Int32;
    class const MONO_MODULE_NAME: Int32;
    class const MONO_MODULE_MVID: Int32;
    class const MONO_MODULE_ENC: Int32;
    class const MONO_MODULE_ENCBASE: Int32;
    class const MONO_MODULE_SIZE: Int32;
    class const MONO_MODULEREF_NAME: Int32;
    class const MONO_MODULEREF_SIZE: Int32;
    class const MONO_NESTED_CLASS_NESTED: Int32;
    class const MONO_NESTED_CLASS_ENCLOSING: Int32;
    class const MONO_NESTED_CLASS_SIZE: Int32;
    class const MONO_PARAM_FLAGS: Int32;
    class const MONO_PARAM_SEQUENCE: Int32;
    class const MONO_PARAM_NAME: Int32;
    class const MONO_PARAM_SIZE: Int32;
    class const MONO_PARAM_POINTER_PARAM: Int32;
    class const MONO_PARAM_POINTER_SIZE: Int32;
    class const MONO_PROPERTY_FLAGS: Int32;
    class const MONO_PROPERTY_NAME: Int32;
    class const MONO_PROPERTY_TYPE: Int32;
    class const MONO_PROPERTY_SIZE: Int32;
    class const MONO_PROPERTY_POINTER_PROPERTY: Int32;
    class const MONO_PROPERTY_POINTER_SIZE: Int32;
    class const MONO_PROPERTY_MAP_PARENT: Int32;
    class const MONO_PROPERTY_MAP_PROPERTY_LIST: Int32;
    class const MONO_PROPERTY_MAP_SIZE: Int32;
    class const MONO_STAND_ALONE_SIGNATURE: Int32;
    class const MONO_STAND_ALONE_SIGNATURE_SIZE: Int32;
    class const MONO_TYPEDEF_FLAGS: Int32;
    class const MONO_TYPEDEF_NAME: Int32;
    class const MONO_TYPEDEF_NAMESPACE: Int32;
    class const MONO_TYPEDEF_EXTENDS: Int32;
    class const MONO_TYPEDEF_FIELD_LIST: Int32;
    class const MONO_TYPEDEF_METHOD_LIST: Int32;
    class const MONO_TYPEDEF_SIZE: Int32;
    class const MONO_TYPEREF_SCOPE: Int32;
    class const MONO_TYPEREF_NAME: Int32;
    class const MONO_TYPEREF_NAMESPACE: Int32;
    class const MONO_TYPEREF_SIZE: Int32;
    class const MONO_TYPESPEC_SIGNATURE: Int32;
    class const MONO_TYPESPEC_SIZE: Int32;
    class const MONO_GENERICPARAM_NUMBER: Int32;
    class const MONO_GENERICPARAM_FLAGS: Int32;
    class const MONO_GENERICPARAM_OWNER: Int32;
    class const MONO_GENERICPARAM_NAME: Int32;
    class const MONO_GENERICPARAM_SIZE: Int32;
    class const MONO_METHODSPEC_METHOD: Int32;
    class const MONO_METHODSPEC_SIGNATURE: Int32;
    class const MONO_METHODSPEC_SIZE: Int32;
    class const MONO_GENPARCONSTRAINT_GENERICPAR: Int32;
    class const MONO_GENPARCONSTRAINT_CONSTRAINT: Int32;
    class const MONO_GENPARCONSTRAINT_SIZE: Int32;
    class const MONO_DOCUMENT_NAME: Int32;
    class const MONO_DOCUMENT_HASHALG: Int32;
    class const MONO_DOCUMENT_HASH: Int32;
    class const MONO_DOCUMENT_LANGUAGE: Int32;
    class const MONO_DOCUMENT_SIZE: Int32;
    class const MONO_METHODBODY_SEQ_POINTS: Int32;
    class const MONO_METHODBODY_SIZE: Int32;
    class const MONO_LOCALSCOPE_METHOD: Int32;
    class const MONO_LOCALSCOPE_IMPORTSCOPE: Int32;
    class const MONO_LOCALSCOPE_VARIABLELIST: Int32;
    class const MONO_LOCALSCOPE_CONSTANTLIST: Int32;
    class const MONO_LOCALSCOPE_STARTOFFSET: Int32;
    class const MONO_LOCALSCOPE_LENGTH: Int32;
    class const MONO_LOCALSCOPE_SIZE: Int32;
    class const MONO_LOCALVARIABLE_ATTRIBUTES: Int32;
    class const MONO_LOCALVARIABLE_INDEX: Int32;
    class const MONO_LOCALVARIABLE_NAME: Int32;
    class const MONO_LOCALVARIABLE_SIZE: Int32;
    class const MONO_TYPEDEFORREF_TYPEDEF: Int32;
    class const MONO_TYPEDEFORREF_TYPEREF: Int32;
    class const MONO_TYPEDEFORREF_TYPESPEC: Int32;
    class const MONO_TYPEDEFORREF_BITS: Int32;
    class const MONO_TYPEDEFORREF_MASK: Int32;
    class const MONO_HASCONSTANT_FIEDDEF: Int32;
    class const MONO_HASCONSTANT_PARAM: Int32;
    class const MONO_HASCONSTANT_PROPERTY: Int32;
    class const MONO_HASCONSTANT_BITS: Int32;
    class const MONO_HASCONSTANT_MASK: Int32;
    class const MONO_CUSTOM_ATTR_METHODDEF: Int32;
    class const MONO_CUSTOM_ATTR_FIELDDEF: Int32;
    class const MONO_CUSTOM_ATTR_TYPEREF: Int32;
    class const MONO_CUSTOM_ATTR_TYPEDEF: Int32;
    class const MONO_CUSTOM_ATTR_PARAMDEF: Int32;
    class const MONO_CUSTOM_ATTR_INTERFACE: Int32;
    class const MONO_CUSTOM_ATTR_MEMBERREF: Int32;
    class const MONO_CUSTOM_ATTR_MODULE: Int32;
    class const MONO_CUSTOM_ATTR_PERMISSION: Int32;
    class const MONO_CUSTOM_ATTR_PROPERTY: Int32;
    class const MONO_CUSTOM_ATTR_EVENT: Int32;
    class const MONO_CUSTOM_ATTR_SIGNATURE: Int32;
    class const MONO_CUSTOM_ATTR_MODULEREF: Int32;
    class const MONO_CUSTOM_ATTR_TYPESPEC: Int32;
    class const MONO_CUSTOM_ATTR_ASSEMBLY: Int32;
    class const MONO_CUSTOM_ATTR_ASSEMBLYREF: Int32;
    class const MONO_CUSTOM_ATTR_FILE: Int32;
    class const MONO_CUSTOM_ATTR_EXP_TYPE: Int32;
    class const MONO_CUSTOM_ATTR_MANIFEST: Int32;
    class const MONO_CUSTOM_ATTR_GENERICPAR: Int32;
    class const MONO_CUSTOM_ATTR_BITS: Int32;
    class const MONO_CUSTOM_ATTR_MASK: Int32;
    class const MONO_HAS_FIELD_MARSHAL_FIELDSREF: Int32;
    class const MONO_HAS_FIELD_MARSHAL_PARAMDEF: Int32;
    class const MONO_HAS_FIELD_MARSHAL_BITS: Int32;
    class const MONO_HAS_FIELD_MARSHAL_MASK: Int32;
    class const MONO_HAS_DECL_SECURITY_TYPEDEF: Int32;
    class const MONO_HAS_DECL_SECURITY_METHODDEF: Int32;
    class const MONO_HAS_DECL_SECURITY_ASSEMBLY: Int32;
    class const MONO_HAS_DECL_SECURITY_BITS: Int32;
    class const MONO_HAS_DECL_SECURITY_MASK: Int32;
    class const MONO_MEMBERREF_PARENT_TYPEDEF: Int32;
    class const MONO_MEMBERREF_PARENT_TYPEREF: Int32;
    class const MONO_MEMBERREF_PARENT_MODULEREF: Int32;
    class const MONO_MEMBERREF_PARENT_METHODDEF: Int32;
    class const MONO_MEMBERREF_PARENT_TYPESPEC: Int32;
    class const MONO_MEMBERREF_PARENT_BITS: Int32;
    class const MONO_MEMBERREF_PARENT_MASK: Int32;
    class const MONO_HAS_SEMANTICS_EVENT: Int32;
    class const MONO_HAS_SEMANTICS_PROPERTY: Int32;
    class const MONO_HAS_SEMANTICS_BITS: Int32;
    class const MONO_HAS_SEMANTICS_MASK: Int32;
    class const MONO_METHODDEFORREF_METHODDEF: Int32;
    class const MONO_METHODDEFORREF_METHODREF: Int32;
    class const MONO_METHODDEFORREF_BITS: Int32;
    class const MONO_METHODDEFORREF_MASK: Int32;
    class const MONO_MEMBERFORWD_FIELDDEF: Int32;
    class const MONO_MEMBERFORWD_METHODDEF: Int32;
    class const MONO_MEMBERFORWD_BITS: Int32;
    class const MONO_MEMBERFORWD_MASK: Int32;
    class const MONO_IMPLEMENTATION_FILE: Int32;
    class const MONO_IMPLEMENTATION_ASSEMBLYREF: Int32;
    class const MONO_IMPLEMENTATION_EXP_TYPE: Int32;
    class const MONO_IMPLEMENTATION_BITS: Int32;
    class const MONO_IMPLEMENTATION_MASK: Int32;
    class const MONO_CUSTOM_ATTR_TYPE_TYPEREF: Int32;
    class const MONO_CUSTOM_ATTR_TYPE_TYPEDEF: Int32;
    class const MONO_CUSTOM_ATTR_TYPE_METHODDEF: Int32;
    class const MONO_CUSTOM_ATTR_TYPE_MEMBERREF: Int32;
    class const MONO_CUSTOM_ATTR_TYPE_STRING: Int32;
    class const MONO_CUSTOM_ATTR_TYPE_BITS: Int32;
    class const MONO_CUSTOM_ATTR_TYPE_MASK: Int32;
    class const MONO_RESOLUTION_SCOPE_MODULE: Int32;
    class const MONO_RESOLUTION_SCOPE_MODULEREF: Int32;
    class const MONO_RESOLUTION_SCOPE_ASSEMBLYREF: Int32;
    class const MONO_RESOLUTION_SCOPE_TYPEREF: Int32;
    class const MONO_RESOLUTION_SCOPE_BITS: Int32;
    class const MONO_RESOLUTION_SCOPE_MASK: Int32;
    class const MONO_RESOLTION_SCOPE_MODULE: Int32;
    class const MONO_RESOLTION_SCOPE_MODULEREF: Int32;
    class const MONO_RESOLTION_SCOPE_ASSEMBLYREF: Int32;
    class const MONO_RESOLTION_SCOPE_TYPEREF: Int32;
    class const MONO_RESOLTION_SCOPE_BITS: Int32;
    class const MONO_RESOLTION_SCOPE_MASK: Int32;
    class const MONO_TYPEORMETHOD_TYPE: Int32;
    class const MONO_TYPEORMETHOD_METHOD: Int32;
    class const MONO_TYPEORMETHOD_BITS: Int32;
    class const MONO_TYPEORMETHOD_MASK: Int32;
    class method mono_images_init;
    class method mono_images_cleanup;
    class method mono_image_open(fname: ^AnsiChar; status: ^mono.metadata.MonoImageOpenStatus): ^MonoImage;
    class method mono_image_open_full(fname: ^AnsiChar; status: ^mono.metadata.MonoImageOpenStatus; refonly: mono_bool): ^MonoImage;
    class method mono_pe_file_open(fname: ^AnsiChar; status: ^mono.metadata.MonoImageOpenStatus): ^MonoImage;
    class method mono_image_open_from_data(data: ^AnsiChar; data_len: uint32_t; need_copy: mono_bool; status: ^mono.metadata.MonoImageOpenStatus): ^MonoImage;
    class method mono_image_open_from_data_full(data: ^AnsiChar; data_len: uint32_t; need_copy: mono_bool; status: ^mono.metadata.MonoImageOpenStatus; refonly: mono_bool): ^MonoImage;
    class method mono_image_open_from_data_with_name(data: ^AnsiChar; data_len: uint32_t; need_copy: mono_bool; status: ^mono.metadata.MonoImageOpenStatus; refonly: mono_bool; name: ^AnsiChar): ^MonoImage;
    class method mono_image_fixup_vtable(image: ^MonoImage);
    class method mono_image_loaded(name: ^AnsiChar): ^MonoImage;
    class method mono_image_loaded_full(name: ^AnsiChar; refonly: mono_bool): ^MonoImage;
    class method mono_image_loaded_by_guid(guid: ^AnsiChar): ^MonoImage;
    class method mono_image_loaded_by_guid_full(guid: ^AnsiChar; refonly: mono_bool): ^MonoImage;
    class method mono_image_init(image: ^MonoImage);
    class method mono_image_close(image: ^MonoImage);
    class method mono_image_addref(image: ^MonoImage);
    class method mono_image_strerror(status: mono.metadata.MonoImageOpenStatus): ^AnsiChar;
    class method mono_image_ensure_section(image: ^MonoImage; section: ^AnsiChar): Int32;
    class method mono_image_ensure_section_idx(image: ^MonoImage; section: Int32): Int32;
    class method mono_image_get_entry_point(image: ^MonoImage): uint32_t;
    class method mono_image_get_resource(image: ^MonoImage; offset: uint32_t; size: ^uint32_t): ^AnsiChar;
    class method mono_image_load_file_for_image(image: ^MonoImage; fileidx: Int32): ^MonoImage;
    class method mono_image_load_module(image: ^MonoImage; idx: Int32): ^MonoImage;
    class method mono_image_get_name(image: ^MonoImage): ^AnsiChar;
    class method mono_image_get_filename(image: ^MonoImage): ^AnsiChar;
    class method mono_image_get_guid(image: ^MonoImage): ^AnsiChar;
    class method mono_image_get_assembly(image: ^MonoImage): ^MonoAssembly;
    class method mono_image_is_dynamic(image: ^MonoImage): mono_bool;
    class method mono_image_rva_map(image: ^MonoImage; rva: uint32_t): ^AnsiChar;
    class method mono_image_get_table_info(image: ^MonoImage; table_id: Int32): ^MonoTableInfo;
    class method mono_image_get_table_rows(image: ^MonoImage; table_id: Int32): Int32;
    class method mono_table_info_get_rows(table: ^MonoTableInfo): Int32;
    class method mono_image_lookup_resource(image: ^MonoImage; res_id: uint32_t; lang_id: uint32_t; name: ^mono_unichar2): ^Void;
    class method mono_image_get_public_key(image: ^MonoImage; size: ^uint32_t): ^AnsiChar;
    class method mono_image_get_strong_name(image: ^MonoImage; size: ^uint32_t): ^AnsiChar;
    class method mono_image_strong_name_position(image: ^MonoImage; size: ^uint32_t): uint32_t;
    class method mono_image_add_to_name_cache(image: ^MonoImage; nspace: ^AnsiChar; name: ^AnsiChar; idx: uint32_t);
    class method mono_image_has_authenticode_entry(image: ^MonoImage): mono_bool;
    class method mono_metadata_init;
    class method mono_metadata_decode_row(t: ^MonoTableInfo; idx: Int32; res: ^uint32_t; res_size: Int32);
    class method mono_metadata_decode_row_col(t: ^MonoTableInfo; idx: Int32; col: UInt32): uint32_t;
    class method mono_metadata_compute_size(meta: ^MonoImage; tableindex: Int32; result_bitfield: ^uint32_t): Int32;
    class method mono_metadata_locate(meta: ^MonoImage; table: Int32; idx: Int32): ^AnsiChar;
    class method mono_metadata_locate_token(meta: ^MonoImage; token: uint32_t): ^AnsiChar;
    class method mono_metadata_string_heap(meta: ^MonoImage; table_index: uint32_t): ^AnsiChar;
    class method mono_metadata_blob_heap(meta: ^MonoImage; table_index: uint32_t): ^AnsiChar;
    class method mono_metadata_user_string(meta: ^MonoImage; table_index: uint32_t): ^AnsiChar;
    class method mono_metadata_guid_heap(meta: ^MonoImage; table_index: uint32_t): ^AnsiChar;
    class method mono_metadata_typedef_from_field(meta: ^MonoImage; table_index: uint32_t): uint32_t;
    class method mono_metadata_typedef_from_method(meta: ^MonoImage; table_index: uint32_t): uint32_t;
    class method mono_metadata_nested_in_typedef(meta: ^MonoImage; table_index: uint32_t): uint32_t;
    class method mono_metadata_nesting_typedef(meta: ^MonoImage; table_index: uint32_t; start_index: uint32_t): uint32_t;
    class method mono_metadata_interfaces_from_typedef(meta: ^MonoImage; table_index: uint32_t; count: ^UInt32): ^^MonoClass;
    class method mono_metadata_events_from_typedef(meta: ^MonoImage; table_index: uint32_t; end_idx: ^UInt32): uint32_t;
    class method mono_metadata_methods_from_event(meta: ^MonoImage; table_index: uint32_t; &end: ^UInt32): uint32_t;
    class method mono_metadata_properties_from_typedef(meta: ^MonoImage; table_index: uint32_t; &end: ^UInt32): uint32_t;
    class method mono_metadata_methods_from_property(meta: ^MonoImage; table_index: uint32_t; &end: ^UInt32): uint32_t;
    class method mono_metadata_packing_from_typedef(meta: ^MonoImage; table_index: uint32_t; packing: ^uint32_t; size: ^uint32_t): uint32_t;
    class method mono_metadata_get_marshal_info(meta: ^MonoImage; idx: uint32_t; is_field: mono_bool): ^AnsiChar;
    class method mono_metadata_custom_attrs_from_index(meta: ^MonoImage; cattr_index: uint32_t): uint32_t;
    class method mono_metadata_parse_marshal_spec(image: ^MonoImage; ptr: ^AnsiChar): ^mono.metadata.MonoMarshalSpec;
    class method mono_metadata_free_marshal_spec(spec: ^mono.metadata.MonoMarshalSpec);
    class method mono_metadata_implmap_from_method(meta: ^MonoImage; method_idx: uint32_t): uint32_t;
    class method mono_metadata_field_info(meta: ^MonoImage; table_index: uint32_t; offset: ^uint32_t; rva: ^uint32_t; marshal_spec: ^^mono.metadata.MonoMarshalSpec);
    class method mono_metadata_get_constant_index(meta: ^MonoImage; token: uint32_t; hint: uint32_t): uint32_t;
    class method mono_metadata_decode_value(ptr: ^AnsiChar; rptr: ^^AnsiChar): uint32_t;
    class method mono_metadata_decode_signed_value(ptr: ^AnsiChar; rptr: ^^AnsiChar): int32_t;
    class method mono_metadata_decode_blob_size(ptr: ^AnsiChar; rptr: ^^AnsiChar): uint32_t;
    class method mono_metadata_encode_value(value: uint32_t; bug: ^AnsiChar; endbuf: ^^AnsiChar);
    class method mono_type_is_byref(&type: ^MonoType): mono_bool;
    class method mono_type_get_type(&type: ^MonoType): Int32;
    class method mono_type_get_signature(&type: ^MonoType): ^MonoMethodSignature;
    class method mono_type_get_class(&type: ^MonoType): ^MonoClass;
    class method mono_type_get_array_type(&type: ^MonoType): ^MonoArrayType;
    class method mono_type_get_ptr_type(&type: ^MonoType): ^MonoType;
    class method mono_type_get_modifiers(&type: ^MonoType; is_required: ^mono_bool; iter: ^^Void): ^MonoClass;
    class method mono_type_is_struct(&type: ^MonoType): mono_bool;
    class method mono_type_is_void(&type: ^MonoType): mono_bool;
    class method mono_type_is_pointer(&type: ^MonoType): mono_bool;
    class method mono_type_is_reference(&type: ^MonoType): mono_bool;
    class method mono_signature_get_return_type(sig: ^MonoMethodSignature): ^MonoType;
    class method mono_signature_get_params(sig: ^MonoMethodSignature; iter: ^^Void): ^MonoType;
    class method mono_signature_get_param_count(sig: ^MonoMethodSignature): uint32_t;
    class method mono_signature_get_call_conv(sig: ^MonoMethodSignature): uint32_t;
    class method mono_signature_vararg_start(sig: ^MonoMethodSignature): Int32;
    class method mono_signature_is_instance(sig: ^MonoMethodSignature): mono_bool;
    class method mono_signature_explicit_this(sig: ^MonoMethodSignature): mono_bool;
    class method mono_signature_param_is_out(sig: ^MonoMethodSignature; param_num: Int32): mono_bool;
    class method mono_metadata_parse_typedef_or_ref(m: ^MonoImage; ptr: ^AnsiChar; rptr: ^^AnsiChar): uint32_t;
    class method mono_metadata_parse_custom_mod(m: ^MonoImage; dest: ^mono.metadata.MonoCustomMod; ptr: ^AnsiChar; rptr: ^^AnsiChar): Int32;
    class method mono_metadata_parse_array(m: ^MonoImage; ptr: ^AnsiChar; rptr: ^^AnsiChar): ^MonoArrayType;
    class method mono_metadata_free_array(&array: ^MonoArrayType);
    class method mono_metadata_parse_type(m: ^MonoImage; mode: mono.metadata.MonoParseTypeMode; opt_attrs: Int16; ptr: ^AnsiChar; rptr: ^^AnsiChar): ^MonoType;
    class method mono_metadata_parse_param(m: ^MonoImage; ptr: ^AnsiChar; rptr: ^^AnsiChar): ^MonoType;
    class method mono_metadata_parse_ret_type(m: ^MonoImage; ptr: ^AnsiChar; rptr: ^^AnsiChar): ^MonoType;
    class method mono_metadata_parse_field_type(m: ^MonoImage; field_flags: Int16; ptr: ^AnsiChar; rptr: ^^AnsiChar): ^MonoType;
    class method mono_type_create_from_typespec(image: ^MonoImage; type_spec: uint32_t): ^MonoType;
    class method mono_metadata_free_type(&type: ^MonoType);
    class method mono_type_size(&type: ^MonoType; alignment: ^Int32): Int32;
    class method mono_type_stack_size(&type: ^MonoType; alignment: ^Int32): Int32;
    class method mono_type_generic_inst_is_valuetype(&type: ^MonoType): mono_bool;
    class method mono_metadata_generic_class_is_valuetype(gclass: ^MonoGenericClass): mono_bool;
    class method mono_metadata_generic_class_hash(gclass: ^MonoGenericClass): UInt32;
    class method mono_metadata_generic_class_equal(g1: ^MonoGenericClass; g2: ^MonoGenericClass): mono_bool;
    class method mono_metadata_type_hash(t1: ^MonoType): UInt32;
    class method mono_metadata_type_equal(t1: ^MonoType; t2: ^MonoType): mono_bool;
    class method mono_metadata_signature_alloc(image: ^MonoImage; nparams: uint32_t): ^MonoMethodSignature;
    class method mono_metadata_signature_dup(sig: ^MonoMethodSignature): ^MonoMethodSignature;
    class method mono_metadata_parse_signature(image: ^MonoImage; token: uint32_t): ^MonoMethodSignature;
    class method mono_metadata_parse_method_signature(m: ^MonoImage; def: Int32; ptr: ^AnsiChar; rptr: ^^AnsiChar): ^MonoMethodSignature;
    class method mono_metadata_free_method_signature(&method: ^MonoMethodSignature);
    class method mono_metadata_signature_equal(sig1: ^MonoMethodSignature; sig2: ^MonoMethodSignature): mono_bool;
    class method mono_signature_hash(sig: ^MonoMethodSignature): UInt32;
    class method mono_metadata_parse_mh(m: ^MonoImage; ptr: ^AnsiChar): ^MonoMethodHeader;
    class method mono_metadata_free_mh(mh: ^MonoMethodHeader);
    class method mono_method_header_get_code(header: ^MonoMethodHeader; code_size: ^uint32_t; max_stack: ^uint32_t): ^Byte;
    class method mono_method_header_get_locals(header: ^MonoMethodHeader; num_locals: ^uint32_t; init_locals: ^mono_bool): ^^MonoType;
    class method mono_method_header_get_num_clauses(header: ^MonoMethodHeader): Int32;
    class method mono_method_header_get_clauses(header: ^MonoMethodHeader; &method: ^MonoMethod; iter: ^^Void; clause: ^mono.metadata.MonoExceptionClause): Int32;
    class method mono_type_to_unmanaged(&type: ^MonoType; mspec: ^mono.metadata.MonoMarshalSpec; as_field: mono_bool; unicode: mono_bool; conv: ^mono.metadata.MonoMarshalConv): uint32_t;
    class method mono_metadata_token_from_dor(dor_index: uint32_t): uint32_t;
    class method mono_guid_to_string(guid: ^uint8_t): ^AnsiChar;
    class method mono_metadata_declsec_from_index(meta: ^MonoImage; idx: uint32_t): uint32_t;
    class method mono_metadata_translate_token_index(image: ^MonoImage; table: Int32; idx: uint32_t): uint32_t;
    class method mono_metadata_decode_table_row(image: ^MonoImage; table: Int32; idx: Int32; res: ^uint32_t; res_size: Int32);
    class method mono_metadata_decode_table_row_col(image: ^MonoImage; table: Int32; idx: Int32; col: UInt32): uint32_t;
    class method mono_get_method(image: ^MonoImage; token: uint32_t; klass: ^MonoClass): ^MonoMethod;
    class method mono_get_method_full(image: ^MonoImage; token: uint32_t; klass: ^MonoClass; context: ^MonoGenericContext): ^MonoMethod;
    class method mono_get_method_constrained(image: ^MonoImage; token: uint32_t; constrained_class: ^MonoClass; context: ^MonoGenericContext; cil_method: ^^MonoMethod): ^MonoMethod;
    class method mono_free_method(&method: ^MonoMethod);
    class method mono_method_get_signature_full(&method: ^MonoMethod; image: ^MonoImage; token: uint32_t; context: ^MonoGenericContext): ^MonoMethodSignature;
    class method mono_method_get_signature(&method: ^MonoMethod; image: ^MonoImage; token: uint32_t): ^MonoMethodSignature;
    class method mono_method_signature(&method: ^MonoMethod): ^MonoMethodSignature;
    class method mono_method_get_header(&method: ^MonoMethod): ^MonoMethodHeader;
    class method mono_method_get_name(&method: ^MonoMethod): ^AnsiChar;
    class method mono_method_get_class(&method: ^MonoMethod): ^MonoClass;
    class method mono_method_get_token(&method: ^MonoMethod): uint32_t;
    class method mono_method_get_flags(&method: ^MonoMethod; iflags: ^uint32_t): uint32_t;
    class method mono_method_get_index(&method: ^MonoMethod): uint32_t;
    class method mono_load_image(fname: ^AnsiChar; status: ^mono.metadata.MonoImageOpenStatus): ^MonoImage;
    class method mono_add_internal_call(name: ^AnsiChar; &method: ^Void);
    class method mono_lookup_internal_call(&method: ^MonoMethod): ^Void;
    class method mono_lookup_icall_symbol(m: ^MonoMethod): ^AnsiChar;
    class method mono_dllmap_insert(&assembly: ^MonoImage; dll: ^AnsiChar; func: ^AnsiChar; tdll: ^AnsiChar; tfunc: ^AnsiChar);
    class method mono_lookup_pinvoke_call(&method: ^MonoMethod; exc_class: ^^AnsiChar; exc_arg: ^^AnsiChar): ^Void;
    class method mono_method_get_param_names(&method: ^MonoMethod; names: ^^AnsiChar);
    class method mono_method_get_param_token(&method: ^MonoMethod; idx: Int32): uint32_t;
    class method mono_method_get_marshal_info(&method: ^MonoMethod; mspecs: ^^mono.metadata.MonoMarshalSpec);
    class method mono_method_has_marshal_info(&method: ^MonoMethod): mono_bool;
    class method mono_method_get_last_managed: ^MonoMethod;
    class method mono_stack_walk(func: mono.metadata.MonoStackWalk; user_data: ^Void);
    class method mono_stack_walk_no_il(func: mono.metadata.MonoStackWalk; user_data: ^Void);
    class method mono_stack_walk_async_safe(func: mono.metadata.MonoStackWalkAsyncSafe; initial_sig_context: ^Void; user_data: ^Void);
    class method mono_class_get(image: ^MonoImage; type_token: uint32_t): ^MonoClass;
    class method mono_class_get_full(image: ^MonoImage; type_token: uint32_t; context: ^MonoGenericContext): ^MonoClass;
    class method mono_class_init(klass: ^MonoClass): mono_bool;
    class method mono_class_vtable(domain: ^MonoDomain; klass: ^MonoClass): ^MonoVTable;
    class method mono_class_from_name(image: ^MonoImage; name_space: ^AnsiChar; name: ^AnsiChar): ^MonoClass;
    class method mono_class_from_name_case(image: ^MonoImage; name_space: ^AnsiChar; name: ^AnsiChar): ^MonoClass;
    class method mono_class_get_method_from_name_flags(klass: ^MonoClass; name: ^AnsiChar; param_count: Int32; &flags: Int32): ^MonoMethod;
    class method mono_class_from_typeref(image: ^MonoImage; type_token: uint32_t): ^MonoClass;
    class method mono_class_from_typeref_checked(image: ^MonoImage; type_token: uint32_t; error: ^mono.utils.MonoError): ^MonoClass;
    class method mono_class_from_generic_parameter(param: ^MonoGenericParam; image: ^MonoImage; is_mvar: mono_bool): ^MonoClass;
    class method mono_class_inflate_generic_type(&type: ^MonoType; context: ^MonoGenericContext): ^MonoType;
    class method mono_class_inflate_generic_method(&method: ^MonoMethod; context: ^MonoGenericContext): ^MonoMethod;
    class method mono_get_inflated_method(&method: ^MonoMethod): ^MonoMethod;
    class method mono_field_from_token(image: ^MonoImage; token: uint32_t; retklass: ^^MonoClass; context: ^MonoGenericContext): ^MonoClassField;
    class method mono_bounded_array_class_get(element_class: ^MonoClass; rank: uint32_t; bounded: mono_bool): ^MonoClass;
    class method mono_array_class_get(element_class: ^MonoClass; rank: uint32_t): ^MonoClass;
    class method mono_ptr_class_get(&type: ^MonoType): ^MonoClass;
    class method mono_class_get_field(klass: ^MonoClass; field_token: uint32_t): ^MonoClassField;
    class method mono_class_get_field_from_name(klass: ^MonoClass; name: ^AnsiChar): ^MonoClassField;
    class method mono_class_get_field_token(field: ^MonoClassField): uint32_t;
    class method mono_class_get_event_token(&event: ^MonoEvent): uint32_t;
    class method mono_class_get_property_from_name(klass: ^MonoClass; name: ^AnsiChar): ^MonoProperty;
    class method mono_class_get_property_token(prop: ^MonoProperty): uint32_t;
    class method mono_array_element_size(ac: ^MonoClass): int32_t;
    class method mono_class_instance_size(klass: ^MonoClass): int32_t;
    class method mono_class_array_element_size(klass: ^MonoClass): int32_t;
    class method mono_class_data_size(klass: ^MonoClass): int32_t;
    class method mono_class_value_size(klass: ^MonoClass; align: ^uint32_t): int32_t;
    class method mono_class_min_align(klass: ^MonoClass): int32_t;
    class method mono_class_from_mono_type(&type: ^MonoType): ^MonoClass;
    class method mono_class_is_subclass_of(klass: ^MonoClass; klassc: ^MonoClass; check_interfaces: mono_bool): mono_bool;
    class method mono_class_is_assignable_from(klass: ^MonoClass; oklass: ^MonoClass): mono_bool;
    class method mono_ldtoken(image: ^MonoImage; token: uint32_t; retclass: ^^MonoClass; context: ^MonoGenericContext): ^Void;
    class method mono_type_get_name(&type: ^MonoType): ^AnsiChar;
    class method mono_type_get_underlying_type(&type: ^MonoType): ^MonoType;
    class method mono_class_get_image(klass: ^MonoClass): ^MonoImage;
    class method mono_class_get_element_class(klass: ^MonoClass): ^MonoClass;
    class method mono_class_is_valuetype(klass: ^MonoClass): mono_bool;
    class method mono_class_is_enum(klass: ^MonoClass): mono_bool;
    class method mono_class_enum_basetype(klass: ^MonoClass): ^MonoType;
    class method mono_class_get_parent(klass: ^MonoClass): ^MonoClass;
    class method mono_class_get_nesting_type(klass: ^MonoClass): ^MonoClass;
    class method mono_class_get_rank(klass: ^MonoClass): Int32;
    class method mono_class_get_flags(klass: ^MonoClass): uint32_t;
    class method mono_class_get_name(klass: ^MonoClass): ^AnsiChar;
    class method mono_class_get_namespace(klass: ^MonoClass): ^AnsiChar;
    class method mono_class_get_type(klass: ^MonoClass): ^MonoType;
    class method mono_class_get_type_token(klass: ^MonoClass): uint32_t;
    class method mono_class_get_byref_type(klass: ^MonoClass): ^MonoType;
    class method mono_class_num_fields(klass: ^MonoClass): Int32;
    class method mono_class_num_methods(klass: ^MonoClass): Int32;
    class method mono_class_num_properties(klass: ^MonoClass): Int32;
    class method mono_class_num_events(klass: ^MonoClass): Int32;
    class method mono_class_get_fields(klass: ^MonoClass; iter: ^^Void): ^MonoClassField;
    class method mono_class_get_methods(klass: ^MonoClass; iter: ^^Void): ^MonoMethod;
    class method mono_class_get_properties(klass: ^MonoClass; iter: ^^Void): ^MonoProperty;
    class method mono_class_get_events(klass: ^MonoClass; iter: ^^Void): ^MonoEvent;
    class method mono_class_get_interfaces(klass: ^MonoClass; iter: ^^Void): ^MonoClass;
    class method mono_class_get_nested_types(klass: ^MonoClass; iter: ^^Void): ^MonoClass;
    class method mono_class_is_delegate(klass: ^MonoClass): mono_bool;
    class method mono_class_implements_interface(klass: ^MonoClass; iface: ^MonoClass): mono_bool;
    class method mono_field_get_name(field: ^MonoClassField): ^AnsiChar;
    class method mono_field_get_type(field: ^MonoClassField): ^MonoType;
    class method mono_field_get_parent(field: ^MonoClassField): ^MonoClass;
    class method mono_field_get_flags(field: ^MonoClassField): uint32_t;
    class method mono_field_get_offset(field: ^MonoClassField): uint32_t;
    class method mono_field_get_data(field: ^MonoClassField): ^AnsiChar;
    class method mono_property_get_name(prop: ^MonoProperty): ^AnsiChar;
    class method mono_property_get_set_method(prop: ^MonoProperty): ^MonoMethod;
    class method mono_property_get_get_method(prop: ^MonoProperty): ^MonoMethod;
    class method mono_property_get_parent(prop: ^MonoProperty): ^MonoClass;
    class method mono_property_get_flags(prop: ^MonoProperty): uint32_t;
    class method mono_event_get_name(&event: ^MonoEvent): ^AnsiChar;
    class method mono_event_get_add_method(&event: ^MonoEvent): ^MonoMethod;
    class method mono_event_get_remove_method(&event: ^MonoEvent): ^MonoMethod;
    class method mono_event_get_raise_method(&event: ^MonoEvent): ^MonoMethod;
    class method mono_event_get_parent(&event: ^MonoEvent): ^MonoClass;
    class method mono_event_get_flags(&event: ^MonoEvent): uint32_t;
    class method mono_class_get_method_from_name(klass: ^MonoClass; name: ^AnsiChar; param_count: Int32): ^MonoMethod;
    class method mono_class_name_from_token(image: ^MonoImage; type_token: uint32_t): ^AnsiChar;
    class method mono_method_can_access_field(&method: ^MonoMethod; field: ^MonoClassField): mono_bool;
    class method mono_method_can_access_method(&method: ^MonoMethod; called: ^MonoMethod): mono_bool;
    class method mono_string_chars(s: ^MonoString): ^mono_unichar2;
    class method mono_string_length(s: ^MonoString): Int32;
    class method mono_object_new(domain: ^MonoDomain; klass: ^MonoClass): ^mono.metadata.MonoObject;
    class method mono_object_new_specific(vtable: ^MonoVTable): ^mono.metadata.MonoObject;
    class method mono_object_new_fast(vtable: ^MonoVTable): ^mono.metadata.MonoObject;
    class method mono_object_new_alloc_specific(vtable: ^MonoVTable): ^mono.metadata.MonoObject;
    class method mono_object_new_from_token(domain: ^MonoDomain; image: ^MonoImage; token: uint32_t): ^mono.metadata.MonoObject;
    class method mono_array_new(domain: ^MonoDomain; eclass: ^MonoClass; n: uintptr_t): ^MonoArray;
    class method mono_array_new_full(domain: ^MonoDomain; array_class: ^MonoClass; lengths: ^uintptr_t; lower_bounds: ^intptr_t): ^MonoArray;
    class method mono_array_new_specific(vtable: ^MonoVTable; n: uintptr_t): ^MonoArray;
    class method mono_array_clone(&array: ^MonoArray): ^MonoArray;
    class method mono_array_addr_with_size(&array: ^MonoArray; size: Int32; idx: uintptr_t): ^AnsiChar;
    class method mono_array_length(&array: ^MonoArray): uintptr_t;
    class method mono_string_new_utf16(domain: ^MonoDomain; text: ^mono_unichar2; len: int32_t): ^MonoString;
    class method mono_string_new_size(domain: ^MonoDomain; len: int32_t): ^MonoString;
    class method mono_ldstr(domain: ^MonoDomain; image: ^MonoImage; str_index: uint32_t): ^MonoString;
    class method mono_string_is_interned(str: ^MonoString): ^MonoString;
    class method mono_string_intern(str: ^MonoString): ^MonoString;
    class method mono_string_new(domain: ^MonoDomain; text: ^AnsiChar): ^MonoString;
    class method mono_string_new_wrapper(text: ^AnsiChar): ^MonoString;
    class method mono_string_new_len(domain: ^MonoDomain; text: ^AnsiChar; length: UInt32): ^MonoString;
    class method mono_string_new_utf32(domain: ^MonoDomain; text: ^mono_unichar4; len: int32_t): ^MonoString;
    class method mono_string_to_utf8(string_obj: ^MonoString): ^AnsiChar;
    class method mono_string_to_utf8_checked(string_obj: ^MonoString; error: ^mono.utils.MonoError): ^AnsiChar;
    class method mono_string_to_utf16(string_obj: ^MonoString): ^mono_unichar2;
    class method mono_string_to_utf32(string_obj: ^MonoString): ^mono_unichar4;
    class method mono_string_from_utf16(data: ^mono_unichar2): ^MonoString;
    class method mono_string_from_utf32(data: ^mono_unichar4): ^MonoString;
    class method mono_string_equal(s1: ^MonoString; s2: ^MonoString): mono_bool;
    class method mono_string_hash(s: ^MonoString): UInt32;
    class method mono_object_hash(obj: ^mono.metadata.MonoObject): Int32;
    class method mono_object_to_string(obj: ^mono.metadata.MonoObject; exc: ^^mono.metadata.MonoObject): ^MonoString;
    class method mono_value_box(domain: ^MonoDomain; klass: ^MonoClass; val: ^Void): ^mono.metadata.MonoObject;
    class method mono_value_copy(dest: ^Void; src: ^Void; klass: ^MonoClass);
    class method mono_value_copy_array(dest: ^MonoArray; dest_idx: Int32; src: ^Void; count: Int32);
    class method mono_object_get_domain(obj: ^mono.metadata.MonoObject): ^MonoDomain;
    class method mono_object_get_class(obj: ^mono.metadata.MonoObject): ^MonoClass;
    class method mono_object_unbox(obj: ^mono.metadata.MonoObject): ^Void;
    class method mono_object_clone(obj: ^mono.metadata.MonoObject): ^mono.metadata.MonoObject;
    class method mono_object_isinst(obj: ^mono.metadata.MonoObject; klass: ^MonoClass): ^mono.metadata.MonoObject;
    class method mono_object_isinst_mbyref(obj: ^mono.metadata.MonoObject; klass: ^MonoClass): ^mono.metadata.MonoObject;
    class method mono_object_castclass_mbyref(obj: ^mono.metadata.MonoObject; klass: ^MonoClass): ^mono.metadata.MonoObject;
    class method mono_monitor_try_enter(obj: ^mono.metadata.MonoObject; ms: uint32_t): mono_bool;
    class method mono_monitor_enter(obj: ^mono.metadata.MonoObject): mono_bool;
    class method mono_monitor_enter_v4(obj: ^mono.metadata.MonoObject; lock_taken: ^AnsiChar);
    class method mono_object_get_size(o: ^mono.metadata.MonoObject): UInt32;
    class method mono_monitor_exit(obj: ^mono.metadata.MonoObject);
    class method mono_raise_exception(ex: ^MonoException);
    class method mono_runtime_object_init(this_obj: ^mono.metadata.MonoObject);
    class method mono_runtime_class_init(vtable: ^MonoVTable);
    class method mono_object_get_virtual_method(obj: ^mono.metadata.MonoObject; &method: ^MonoMethod): ^MonoMethod;
    class method mono_runtime_invoke(&method: ^MonoMethod; obj: ^Void; &params: ^^Void; exc: ^^mono.metadata.MonoObject): ^mono.metadata.MonoObject;
    class method mono_get_delegate_invoke(klass: ^MonoClass): ^MonoMethod;
    class method mono_get_delegate_begin_invoke(klass: ^MonoClass): ^MonoMethod;
    class method mono_get_delegate_end_invoke(klass: ^MonoClass): ^MonoMethod;
    class method mono_runtime_delegate_invoke(&delegate: ^mono.metadata.MonoObject; &params: ^^Void; exc: ^^mono.metadata.MonoObject): ^mono.metadata.MonoObject;
    class method mono_runtime_invoke_array(&method: ^MonoMethod; obj: ^Void; &params: ^MonoArray; exc: ^^mono.metadata.MonoObject): ^mono.metadata.MonoObject;
    class method mono_method_get_unmanaged_thunk(&method: ^MonoMethod): ^Void;
    class method mono_runtime_get_main_args: ^MonoArray;
    class method mono_runtime_exec_managed_code(domain: ^MonoDomain; main_func: mono.metadata.MonoMainThreadFunc; main_args: ^Void);
    class method mono_runtime_run_main(&method: ^MonoMethod; argc: Int32; argv: ^^AnsiChar; exc: ^^mono.metadata.MonoObject): Int32;
    class method mono_runtime_exec_main(&method: ^MonoMethod; args: ^MonoArray; exc: ^^mono.metadata.MonoObject): Int32;
    class method mono_runtime_set_main_args(argc: Int32; argv: ^^AnsiChar): Int32;
    class method mono_load_remote_field(this_obj: ^mono.metadata.MonoObject; klass: ^MonoClass; field: ^MonoClassField; res: ^^Void): ^Void;
    class method mono_load_remote_field_new(this_obj: ^mono.metadata.MonoObject; klass: ^MonoClass; field: ^MonoClassField): ^mono.metadata.MonoObject;
    class method mono_store_remote_field(this_obj: ^mono.metadata.MonoObject; klass: ^MonoClass; field: ^MonoClassField; val: ^Void);
    class method mono_store_remote_field_new(this_obj: ^mono.metadata.MonoObject; klass: ^MonoClass; field: ^MonoClassField; arg: ^mono.metadata.MonoObject);
    class method mono_unhandled_exception(exc: ^mono.metadata.MonoObject);
    class method mono_print_unhandled_exception(exc: ^mono.metadata.MonoObject);
    class method mono_compile_method(&method: ^MonoMethod): ^Void;
    class method mono_field_set_value(obj: ^mono.metadata.MonoObject; field: ^MonoClassField; value: ^Void);
    class method mono_field_static_set_value(vt: ^MonoVTable; field: ^MonoClassField; value: ^Void);
    class method mono_field_get_value(obj: ^mono.metadata.MonoObject; field: ^MonoClassField; value: ^Void);
    class method mono_field_static_get_value(vt: ^MonoVTable; field: ^MonoClassField; value: ^Void);
    class method mono_field_get_value_object(domain: ^MonoDomain; field: ^MonoClassField; obj: ^mono.metadata.MonoObject): ^mono.metadata.MonoObject;
    class method mono_property_set_value(prop: ^MonoProperty; obj: ^Void; &params: ^^Void; exc: ^^mono.metadata.MonoObject);
    class method mono_property_get_value(prop: ^MonoProperty; obj: ^Void; &params: ^^Void; exc: ^^mono.metadata.MonoObject): ^mono.metadata.MonoObject;
    class method mono_gchandle_new(obj: ^mono.metadata.MonoObject; &pinned: mono_bool): uint32_t;
    class method mono_gchandle_new_weakref(obj: ^mono.metadata.MonoObject; track_resurrection: mono_bool): uint32_t;
    class method mono_gchandle_get_target(gchandle: uint32_t): ^mono.metadata.MonoObject;
    class method mono_gchandle_free(gchandle: uint32_t);
    class method mono_gc_reference_queue_new(callback: mono.metadata.MonoMainThreadFunc): ^MonoReferenceQueue;
    class method mono_gc_reference_queue_free(queue: ^MonoReferenceQueue);
    class method mono_gc_reference_queue_add(queue: ^MonoReferenceQueue; obj: ^mono.metadata.MonoObject; user_data: ^Void): mono_bool;
    class method mono_gc_wbarrier_set_field(obj: ^mono.metadata.MonoObject; field_ptr: ^Void; value: ^mono.metadata.MonoObject);
    class method mono_gc_wbarrier_set_arrayref(arr: ^MonoArray; slot_ptr: ^Void; value: ^mono.metadata.MonoObject);
    class method mono_gc_wbarrier_arrayref_copy(dest_ptr: ^Void; src_ptr: ^Void; count: Int32);
    class method mono_gc_wbarrier_generic_store(ptr: ^Void; value: ^mono.metadata.MonoObject);
    class method mono_gc_wbarrier_generic_store_atomic(ptr: ^Void; value: ^mono.metadata.MonoObject);
    class method mono_gc_wbarrier_generic_nostore(ptr: ^Void);
    class method mono_gc_wbarrier_value_copy(dest: ^Void; src: ^Void; count: Int32; klass: ^MonoClass);
    class method mono_gc_wbarrier_object_copy(obj: ^mono.metadata.MonoObject; src: ^mono.metadata.MonoObject);
    class method mono_reflection_parse_type(name: ^AnsiChar; info: ^MonoTypeNameParse): Int32;
    class method mono_reflection_get_type(image: ^MonoImage; info: ^MonoTypeNameParse; ignorecase: mono_bool; type_resolve: ^mono_bool): ^MonoType;
    class method mono_reflection_free_type_info(info: ^MonoTypeNameParse);
    class method mono_reflection_type_from_name(name: ^AnsiChar; image: ^MonoImage): ^MonoType;
    class method mono_reflection_get_token(obj: ^mono.metadata.MonoObject): uint32_t;
    class method mono_assembly_get_object(domain: ^MonoDomain; &assembly: ^MonoAssembly): ^MonoReflectionAssembly;
    class method mono_module_get_object(domain: ^MonoDomain; image: ^MonoImage): ^MonoReflectionModule;
    class method mono_module_file_get_object(domain: ^MonoDomain; image: ^MonoImage; table_index: Int32): ^MonoReflectionModule;
    class method mono_type_get_object(domain: ^MonoDomain; &type: ^MonoType): ^MonoReflectionType;
    class method mono_method_get_object(domain: ^MonoDomain; &method: ^MonoMethod; refclass: ^MonoClass): ^MonoReflectionMethod;
    class method mono_field_get_object(domain: ^MonoDomain; klass: ^MonoClass; field: ^MonoClassField): ^MonoReflectionField;
    class method mono_property_get_object(domain: ^MonoDomain; klass: ^MonoClass; &property: ^MonoProperty): ^MonoReflectionProperty;
    class method mono_event_get_object(domain: ^MonoDomain; klass: ^MonoClass; &event: ^MonoEvent): ^MonoReflectionEvent;
    class method mono_param_get_objects(domain: ^MonoDomain; &method: ^MonoMethod): ^MonoArray;
    class method mono_method_body_get_object(domain: ^MonoDomain; &method: ^MonoMethod): ^MonoReflectionMethodBody;
    class method mono_get_dbnull_object(domain: ^MonoDomain): ^mono.metadata.MonoObject;
    class method mono_reflection_get_custom_attrs_by_type(obj: ^mono.metadata.MonoObject; attr_klass: ^MonoClass; error: ^mono.utils.MonoError): ^MonoArray;
    class method mono_reflection_get_custom_attrs(obj: ^mono.metadata.MonoObject): ^MonoArray;
    class method mono_reflection_get_custom_attrs_data(obj: ^mono.metadata.MonoObject): ^MonoArray;
    class method mono_reflection_get_custom_attrs_blob(&assembly: ^MonoReflectionAssembly; ctor: ^mono.metadata.MonoObject; ctorArgs: ^MonoArray; properties: ^MonoArray; porpValues: ^MonoArray; fields: ^MonoArray; fieldValues: ^MonoArray): ^MonoArray;
    class method mono_reflection_get_custom_attrs_info(obj: ^mono.metadata.MonoObject): ^mono.metadata.MonoCustomAttrInfo;
    class method mono_custom_attrs_construct(cinfo: ^mono.metadata.MonoCustomAttrInfo): ^MonoArray;
    class method mono_custom_attrs_from_index(image: ^MonoImage; idx: uint32_t): ^mono.metadata.MonoCustomAttrInfo;
    class method mono_custom_attrs_from_method(&method: ^MonoMethod): ^mono.metadata.MonoCustomAttrInfo;
    class method mono_custom_attrs_from_class(klass: ^MonoClass): ^mono.metadata.MonoCustomAttrInfo;
    class method mono_custom_attrs_from_assembly(&assembly: ^MonoAssembly): ^mono.metadata.MonoCustomAttrInfo;
    class method mono_custom_attrs_from_property(klass: ^MonoClass; &property: ^MonoProperty): ^mono.metadata.MonoCustomAttrInfo;
    class method mono_custom_attrs_from_event(klass: ^MonoClass; &event: ^MonoEvent): ^mono.metadata.MonoCustomAttrInfo;
    class method mono_custom_attrs_from_field(klass: ^MonoClass; field: ^MonoClassField): ^mono.metadata.MonoCustomAttrInfo;
    class method mono_custom_attrs_from_param(&method: ^MonoMethod; param: uint32_t): ^mono.metadata.MonoCustomAttrInfo;
    class method mono_custom_attrs_has_attr(ainfo: ^mono.metadata.MonoCustomAttrInfo; attr_klass: ^MonoClass): mono_bool;
    class method mono_custom_attrs_get_attr(ainfo: ^mono.metadata.MonoCustomAttrInfo; attr_klass: ^MonoClass): ^mono.metadata.MonoObject;
    class method mono_custom_attrs_free(ainfo: ^mono.metadata.MonoCustomAttrInfo);
    class const MONO_DECLSEC_FLAG_REQUEST: Int32;
    class const MONO_DECLSEC_FLAG_DEMAND: Int32;
    class const MONO_DECLSEC_FLAG_ASSERT: Int32;
    class const MONO_DECLSEC_FLAG_DENY: Int32;
    class const MONO_DECLSEC_FLAG_PERMITONLY: Int32;
    class const MONO_DECLSEC_FLAG_LINKDEMAND: Int32;
    class const MONO_DECLSEC_FLAG_INHERITANCEDEMAND: Int32;
    class const MONO_DECLSEC_FLAG_REQUEST_MINIMUM: Int32;
    class const MONO_DECLSEC_FLAG_REQUEST_OPTIONAL: Int32;
    class const MONO_DECLSEC_FLAG_REQUEST_REFUSE: Int32;
    class const MONO_DECLSEC_FLAG_PREJIT_GRANT: Int32;
    class const MONO_DECLSEC_FLAG_PREJIT_DENY: Int32;
    class const MONO_DECLSEC_FLAG_NONCAS_DEMAND: Int32;
    class const MONO_DECLSEC_FLAG_NONCAS_LINKDEMAND: Int32;
    class const MONO_DECLSEC_FLAG_NONCAS_INHERITANCEDEMAND: Int32;
    class const MONO_DECLSEC_FLAG_LINKDEMAND_CHOICE: Int32;
    class const MONO_DECLSEC_FLAG_INHERITANCEDEMAND_CHOICE: Int32;
    class const MONO_DECLSEC_FLAG_DEMAND_CHOICE: Int32;
    class method mono_declsec_flags_from_method(&method: ^MonoMethod): uint32_t;
    class method mono_declsec_flags_from_class(klass: ^MonoClass): uint32_t;
    class method mono_declsec_flags_from_assembly(&assembly: ^MonoAssembly): uint32_t;
    class method mono_declsec_get_demands(callee: ^MonoMethod; demands: ^mono.metadata.MonoDeclSecurityActions): MonoBoolean;
    class method mono_declsec_get_linkdemands(callee: ^MonoMethod; klass: ^mono.metadata.MonoDeclSecurityActions; cmethod: ^mono.metadata.MonoDeclSecurityActions): MonoBoolean;
    class method mono_declsec_get_inheritdemands_class(klass: ^MonoClass; demands: ^mono.metadata.MonoDeclSecurityActions): MonoBoolean;
    class method mono_declsec_get_inheritdemands_method(callee: ^MonoMethod; demands: ^mono.metadata.MonoDeclSecurityActions): MonoBoolean;
    class method mono_declsec_get_method_action(&method: ^MonoMethod; action: uint32_t; entry: ^mono.metadata.MonoDeclSecurityEntry): MonoBoolean;
    class method mono_declsec_get_class_action(klass: ^MonoClass; action: uint32_t; entry: ^mono.metadata.MonoDeclSecurityEntry): MonoBoolean;
    class method mono_declsec_get_assembly_action(&assembly: ^MonoAssembly; action: uint32_t; entry: ^mono.metadata.MonoDeclSecurityEntry): MonoBoolean;
    class method mono_reflection_type_get_type(reftype: ^MonoReflectionType): ^MonoType;
    class method mono_reflection_assembly_get_assembly(refassembly: ^MonoReflectionAssembly): ^MonoAssembly;
    class method mono_init(filename: ^AnsiChar): ^MonoDomain;
    class method mono_init_from_assembly(domain_name: ^AnsiChar; filename: ^AnsiChar): ^MonoDomain;
    class method mono_init_version(domain_name: ^AnsiChar; version: ^AnsiChar): ^MonoDomain;
    class method mono_get_root_domain: ^MonoDomain;
    class method mono_runtime_init(domain: ^MonoDomain; start_cb: mono.metadata.MonoThreadStartCB; attach_cb: mono.metadata.MonoThreadAttachCB);
    class method mono_runtime_cleanup(domain: ^MonoDomain);
    class method mono_install_runtime_cleanup(func: mono.metadata.MonoDomainFunc);
    class method mono_runtime_quit;
    class method mono_runtime_set_shutting_down;
    class method mono_runtime_is_shutting_down: mono_bool;
    class method mono_check_corlib_version: ^AnsiChar;
    class method mono_domain_create: ^MonoDomain;
    class method mono_domain_create_appdomain(friendly_name: ^AnsiChar; configuration_file: ^AnsiChar): ^MonoDomain;
    class method mono_domain_set_config(domain: ^MonoDomain; base_dir: ^AnsiChar; config_file_name: ^AnsiChar);
    class method mono_domain_get: ^MonoDomain;
    class method mono_domain_get_by_id(domainid: int32_t): ^MonoDomain;
    class method mono_domain_get_id(domain: ^MonoDomain): int32_t;
    class method mono_domain_set(domain: ^MonoDomain; force: mono_bool): mono_bool;
    class method mono_domain_set_internal(domain: ^MonoDomain);
    class method mono_domain_unload(domain: ^MonoDomain);
    class method mono_domain_try_unload(domain: ^MonoDomain; exc: ^^mono.metadata.MonoObject);
    class method mono_domain_is_unloading(domain: ^MonoDomain): mono_bool;
    class method mono_domain_from_appdomain(appdomain: ^MonoAppDomain): ^MonoDomain;
    class method mono_domain_foreach(func: mono.metadata.MonoDomainFunc; user_data: ^Void);
    class method mono_domain_assembly_open(domain: ^MonoDomain; name: ^AnsiChar): ^MonoAssembly;
    class method mono_domain_finalize(domain: ^MonoDomain; timeout: uint32_t): mono_bool;
    class method mono_domain_free(domain: ^MonoDomain; force: mono_bool);
    class method mono_domain_has_type_resolve(domain: ^MonoDomain): mono_bool;
    class method mono_domain_try_type_resolve(domain: ^MonoDomain; name: ^AnsiChar; tb: ^mono.metadata.MonoObject): ^MonoReflectionAssembly;
    class method mono_domain_owns_vtable_slot(domain: ^MonoDomain; vtable_slot: ^Void): mono_bool;
    class method mono_context_init(domain: ^MonoDomain);
    class method mono_context_set(new_context: ^MonoAppContext);
    class method mono_context_get: ^MonoAppContext;
    class method mono_jit_info_table_find(domain: ^MonoDomain; addr: ^AnsiChar): ^MonoJitInfo;
    class method mono_jit_info_get_code_start(ji: ^MonoJitInfo): ^Void;
    class method mono_jit_info_get_code_size(ji: ^MonoJitInfo): Int32;
    class method mono_jit_info_get_method(ji: ^MonoJitInfo): ^MonoMethod;
    class method mono_get_corlib: ^MonoImage;
    class method mono_get_object_class: ^MonoClass;
    class method mono_get_byte_class: ^MonoClass;
    class method mono_get_void_class: ^MonoClass;
    class method mono_get_boolean_class: ^MonoClass;
    class method mono_get_sbyte_class: ^MonoClass;
    class method mono_get_int16_class: ^MonoClass;
    class method mono_get_uint16_class: ^MonoClass;
    class method mono_get_int32_class: ^MonoClass;
    class method mono_get_uint32_class: ^MonoClass;
    class method mono_get_intptr_class: ^MonoClass;
    class method mono_get_uintptr_class: ^MonoClass;
    class method mono_get_int64_class: ^MonoClass;
    class method mono_get_uint64_class: ^MonoClass;
    class method mono_get_single_class: ^MonoClass;
    class method mono_get_double_class: ^MonoClass;
    class method mono_get_char_class: ^MonoClass;
    class method mono_get_string_class: ^MonoClass;
    class method mono_get_enum_class: ^MonoClass;
    class method mono_get_array_class: ^MonoClass;
    class method mono_get_thread_class: ^MonoClass;
    class method mono_get_exception_class: ^MonoClass;
    class method mono_security_enable_core_clr;
    class method mono_security_set_core_clr_platform_callback(callback: mono.metadata.MonoCoreClrPlatformCB);
    class method mono_assemblies_init;
    class method mono_assemblies_cleanup;
    class method mono_assembly_open(filename: ^AnsiChar; status: ^mono.metadata.MonoImageOpenStatus): ^MonoAssembly;
    class method mono_assembly_open_full(filename: ^AnsiChar; status: ^mono.metadata.MonoImageOpenStatus; refonly: mono_bool): ^MonoAssembly;
    class method mono_assembly_load(aname: ^MonoAssemblyName; basedir: ^AnsiChar; status: ^mono.metadata.MonoImageOpenStatus): ^MonoAssembly;
    class method mono_assembly_load_full(aname: ^MonoAssemblyName; basedir: ^AnsiChar; status: ^mono.metadata.MonoImageOpenStatus; refonly: mono_bool): ^MonoAssembly;
    class method mono_assembly_load_from(image: ^MonoImage; fname: ^AnsiChar; status: ^mono.metadata.MonoImageOpenStatus): ^MonoAssembly;
    class method mono_assembly_load_from_full(image: ^MonoImage; fname: ^AnsiChar; status: ^mono.metadata.MonoImageOpenStatus; refonly: mono_bool): ^MonoAssembly;
    class method mono_assembly_load_with_partial_name(name: ^AnsiChar; status: ^mono.metadata.MonoImageOpenStatus): ^MonoAssembly;
    class method mono_assembly_loaded(aname: ^MonoAssemblyName): ^MonoAssembly;
    class method mono_assembly_loaded_full(aname: ^MonoAssemblyName; refonly: mono_bool): ^MonoAssembly;
    class method mono_assembly_get_assemblyref(image: ^MonoImage; &index: Int32; aname: ^MonoAssemblyName);
    class method mono_assembly_load_reference(image: ^MonoImage; &index: Int32);
    class method mono_assembly_load_references(image: ^MonoImage; status: ^mono.metadata.MonoImageOpenStatus);
    class method mono_assembly_load_module(&assembly: ^MonoAssembly; idx: uint32_t): ^MonoImage;
    class method mono_assembly_close(&assembly: ^MonoAssembly);
    class method mono_assembly_setrootdir(root_dir: ^AnsiChar);
    class method mono_assembly_getrootdir: ^AnsiChar;
    class method mono_assembly_foreach(func: mono.utils.MonoFunc; user_data: ^Void);
    class method mono_assembly_set_main(&assembly: ^MonoAssembly);
    class method mono_assembly_get_main: ^MonoAssembly;
    class method mono_assembly_get_image(&assembly: ^MonoAssembly): ^MonoImage;
    class method mono_assembly_fill_assembly_name(image: ^MonoImage; aname: ^MonoAssemblyName): mono_bool;
    class method mono_assembly_names_equal(l: ^MonoAssemblyName; r: ^MonoAssemblyName): mono_bool;
    class method mono_stringify_assembly_name(aname: ^MonoAssemblyName): ^AnsiChar;
    class method mono_install_assembly_load_hook(func: mono.metadata.MonoAssemblyLoadFunc; user_data: ^Void);
    class method mono_install_assembly_search_hook(func: mono.metadata.MonoAssemblySearchFunc; user_data: ^Void);
    class method mono_install_assembly_refonly_search_hook(func: mono.metadata.MonoAssemblySearchFunc; user_data: ^Void);
    class method mono_assembly_invoke_search_hook(aname: ^MonoAssemblyName): ^MonoAssembly;
    class method mono_install_assembly_postload_search_hook(func: mono.metadata.MonoAssemblySearchFunc; user_data: ^Void);
    class method mono_install_assembly_postload_refonly_search_hook(func: mono.metadata.MonoAssemblySearchFunc; user_data: ^Void);
    class method mono_install_assembly_preload_hook(func: mono.metadata.MonoAssemblyPreLoadFunc; user_data: ^Void);
    class method mono_install_assembly_refonly_preload_hook(func: mono.metadata.MonoAssemblyPreLoadFunc; user_data: ^Void);
    class method mono_assembly_invoke_load_hook(ass: ^MonoAssembly);
    class method mono_assembly_name_new(name: ^AnsiChar): ^MonoAssemblyName;
    class method mono_assembly_name_get_name(aname: ^MonoAssemblyName): ^AnsiChar;
    class method mono_assembly_name_get_culture(aname: ^MonoAssemblyName): ^AnsiChar;
    class method mono_assembly_name_get_version(aname: ^MonoAssemblyName; minor: ^uint16_t; build: ^uint16_t; revision: ^uint16_t): uint16_t;
    class method mono_assembly_name_get_pubkeytoken(aname: ^MonoAssemblyName): ^mono_byte;
    class method mono_assembly_name_free(aname: ^MonoAssemblyName);
    class method mono_register_bundled_assemblies(assemblies: ^^mono.metadata.MonoBundledAssembly);
    class method mono_register_config_for_assembly(assembly_name: ^AnsiChar; config_xml: ^AnsiChar);
    class method mono_register_symfile_for_assembly(assembly_name: ^AnsiChar; raw_contents: ^mono_byte; size: Int32);
    class method mono_register_machine_config(config_xml: ^AnsiChar);
    class method mono_set_rootdir;
    class method mono_set_dirs(assembly_dir: ^AnsiChar; config_dir: ^AnsiChar);
    class method mono_set_assemblies_path(path: ^AnsiChar);
    class const MONO_ASSEMBLY_HASH_NONE: Int32;
    class const MONO_ASSEMBLY_HASH_MD5: Int32;
    class const MONO_ASSEMBLY_HASH_SHA1: Int32;
    class const MONO_ASSEMBLYREF_FULL_PUBLIC_KEY: Int32;
    class const MONO_ASSEMBLYREF_RETARGETABLE: Int32;
    class const MONO_ASSEMBLYREF_JIT_TRACKING: Int32;
    class const MONO_ASSEMBLYREF_NO_JIT_OPT: Int32;
    class const MONO_EVENT_SPECIALNAME: Int32;
    class const MONO_EVENT_RTSPECIALNAME: Int32;
    class const MONO_FIELD_ATTR_FIELD_ACCESS_MASK: Int32;
    class const MONO_FIELD_ATTR_COMPILER_CONTROLLED: Int32;
    class const MONO_FIELD_ATTR_PRIVATE: Int32;
    class const MONO_FIELD_ATTR_FAM_AND_ASSEM: Int32;
    class const MONO_FIELD_ATTR_ASSEMBLY: Int32;
    class const MONO_FIELD_ATTR_FAMILY: Int32;
    class const MONO_FIELD_ATTR_FAM_OR_ASSEM: Int32;
    class const MONO_FIELD_ATTR_PUBLIC: Int32;
    class const MONO_FIELD_ATTR_STATIC: Int32;
    class const MONO_FIELD_ATTR_INIT_ONLY: Int32;
    class const MONO_FIELD_ATTR_LITERAL: Int32;
    class const MONO_FIELD_ATTR_NOT_SERIALIZED: Int32;
    class const MONO_FIELD_ATTR_SPECIAL_NAME: Int32;
    class const MONO_FIELD_ATTR_PINVOKE_IMPL: Int32;
    class const MONO_FIELD_ATTR_RESERVED_MASK: Int32;
    class const MONO_FIELD_ATTR_RT_SPECIAL_NAME: Int32;
    class const MONO_FIELD_ATTR_HAS_MARSHAL: Int32;
    class const MONO_FIELD_ATTR_HAS_DEFAULT: Int32;
    class const MONO_FIELD_ATTR_HAS_RVA: Int32;
    class const MONO_FILE_HAS_METADATA: Int32;
    class const MONO_FILE_HAS_NO_METADATA: Int32;
    class const MONO_GEN_PARAM_VARIANCE_MASK: Int32;
    class const MONO_GEN_PARAM_NON_VARIANT: Int32;
    class const MONO_GEN_PARAM_VARIANT: Int32;
    class const MONO_GEN_PARAM_COVARIANT: Int32;
    class const MONO_GEN_PARAM_CONSTRAINT_MASK: Int32;
    class const MONO_GEN_PARAM_CONSTRAINT_CLASS: Int32;
    class const MONO_GEN_PARAM_CONSTRAINT_VTYPE: Int32;
    class const MONO_GEN_PARAM_CONSTRAINT_DCTOR: Int32;
    class const MONO_PINVOKE_NO_MANGLE: Int32;
    class const MONO_PINVOKE_CHAR_SET_MASK: Int32;
    class const MONO_PINVOKE_CHAR_SET_NOT_SPEC: Int32;
    class const MONO_PINVOKE_CHAR_SET_ANSI: Int32;
    class const MONO_PINVOKE_CHAR_SET_UNICODE: Int32;
    class const MONO_PINVOKE_CHAR_SET_AUTO: Int32;
    class const MONO_PINVOKE_BEST_FIT_ENABLED: Int32;
    class const MONO_PINVOKE_BEST_FIT_DISABLED: Int32;
    class const MONO_PINVOKE_BEST_FIT_MASK: Int32;
    class const MONO_PINVOKE_SUPPORTS_LAST_ERROR: Int32;
    class const MONO_PINVOKE_CALL_CONV_MASK: Int32;
    class const MONO_PINVOKE_CALL_CONV_WINAPI: Int32;
    class const MONO_PINVOKE_CALL_CONV_CDECL: Int32;
    class const MONO_PINVOKE_CALL_CONV_STDCALL: Int32;
    class const MONO_PINVOKE_CALL_CONV_THISCALL: Int32;
    class const MONO_PINVOKE_CALL_CONV_FASTCALL: Int32;
    class const MONO_PINVOKE_THROW_ON_UNMAPPABLE_ENABLED: Int32;
    class const MONO_PINVOKE_THROW_ON_UNMAPPABLE_DISABLED: Int32;
    class const MONO_PINVOKE_THROW_ON_UNMAPPABLE_MASK: Int32;
    class const MONO_PINVOKE_CALL_CONV_GENERIC: Int32;
    class const MONO_PINVOKE_CALL_CONV_GENERICINST: Int32;
    class const MONO_MANIFEST_RESOURCE_VISIBILITY_MASK: Int32;
    class const MONO_MANIFEST_RESOURCE_PUBLIC: Int32;
    class const MONO_MANIFEST_RESOURCE_PRIVATE: Int32;
    class const MONO_METHOD_ATTR_ACCESS_MASK: Int32;
    class const MONO_METHOD_ATTR_COMPILER_CONTROLLED: Int32;
    class const MONO_METHOD_ATTR_PRIVATE: Int32;
    class const MONO_METHOD_ATTR_FAM_AND_ASSEM: Int32;
    class const MONO_METHOD_ATTR_ASSEM: Int32;
    class const MONO_METHOD_ATTR_FAMILY: Int32;
    class const MONO_METHOD_ATTR_FAM_OR_ASSEM: Int32;
    class const MONO_METHOD_ATTR_PUBLIC: Int32;
    class const MONO_METHOD_ATTR_STATIC: Int32;
    class const MONO_METHOD_ATTR_FINAL: Int32;
    class const MONO_METHOD_ATTR_VIRTUAL: Int32;
    class const MONO_METHOD_ATTR_HIDE_BY_SIG: Int32;
    class const MONO_METHOD_ATTR_VTABLE_LAYOUT_MASK: Int32;
    class const MONO_METHOD_ATTR_REUSE_SLOT: Int32;
    class const MONO_METHOD_ATTR_NEW_SLOT: Int32;
    class const MONO_METHOD_ATTR_STRICT: Int32;
    class const MONO_METHOD_ATTR_ABSTRACT: Int32;
    class const MONO_METHOD_ATTR_SPECIAL_NAME: Int32;
    class const MONO_METHOD_ATTR_PINVOKE_IMPL: Int32;
    class const MONO_METHOD_ATTR_UNMANAGED_EXPORT: Int32;
    class const MONO_METHOD_ATTR_RESERVED_MASK: Int32;
    class const MONO_METHOD_ATTR_RT_SPECIAL_NAME: Int32;
    class const MONO_METHOD_ATTR_HAS_SECURITY: Int32;
    class const MONO_METHOD_ATTR_REQUIRE_SEC_OBJECT: Int32;
    class const MONO_METHOD_IMPL_ATTR_CODE_TYPE_MASK: Int32;
    class const MONO_METHOD_IMPL_ATTR_IL: Int32;
    class const MONO_METHOD_IMPL_ATTR_NATIVE: Int32;
    class const MONO_METHOD_IMPL_ATTR_OPTIL: Int32;
    class const MONO_METHOD_IMPL_ATTR_RUNTIME: Int32;
    class const MONO_METHOD_IMPL_ATTR_MANAGED_MASK: Int32;
    class const MONO_METHOD_IMPL_ATTR_UNMANAGED: Int32;
    class const MONO_METHOD_IMPL_ATTR_MANAGED: Int32;
    class const MONO_METHOD_IMPL_ATTR_FORWARD_REF: Int32;
    class const MONO_METHOD_IMPL_ATTR_PRESERVE_SIG: Int32;
    class const MONO_METHOD_IMPL_ATTR_INTERNAL_CALL: Int32;
    class const MONO_METHOD_IMPL_ATTR_SYNCHRONIZED: Int32;
    class const MONO_METHOD_IMPL_ATTR_NOINLINING: Int32;
    class const MONO_METHOD_IMPL_ATTR_NOOPTIMIZATION: Int32;
    class const MONO_METHOD_IMPL_ATTR_MAX_METHOD_IMPL_VAL: Int32;
    class const MONO_METHOD_SEMANTIC_SETTER: Int32;
    class const MONO_METHOD_SEMANTIC_GETTER: Int32;
    class const MONO_METHOD_SEMANTIC_OTHER: Int32;
    class const MONO_METHOD_SEMANTIC_ADD_ON: Int32;
    class const MONO_METHOD_SEMANTIC_REMOVE_ON: Int32;
    class const MONO_METHOD_SEMANTIC_FIRE: Int32;
    class const MONO_PARAM_ATTR_IN: Int32;
    class const MONO_PARAM_ATTR_OUT: Int32;
    class const MONO_PARAM_ATTR_OPTIONAL: Int32;
    class const MONO_PARAM_ATTR_RESERVED_MASK: Int32;
    class const MONO_PARAM_ATTR_HAS_DEFAULT: Int32;
    class const MONO_PARAM_ATTR_HAS_MARSHAL: Int32;
    class const MONO_PARAM_ATTR_UNUSED: Int32;
    class const MONO_PROPERTY_ATTR_SPECIAL_NAME: Int32;
    class const MONO_PROPERTY_ATTR_RESERVED_MASK: Int32;
    class const MONO_PROPERTY_ATTR_RT_SPECIAL_NAME: Int32;
    class const MONO_PROPERTY_ATTR_HAS_DEFAULT: Int32;
    class const MONO_PROPERTY_ATTR_UNUSED: Int32;
    class const MONO_TYPE_ATTR_VISIBILITY_MASK: Int32;
    class const MONO_TYPE_ATTR_NOT_PUBLIC: Int32;
    class const MONO_TYPE_ATTR_PUBLIC: Int32;
    class const MONO_TYPE_ATTR_NESTED_PUBLIC: Int32;
    class const MONO_TYPE_ATTR_NESTED_PRIVATE: Int32;
    class const MONO_TYPE_ATTR_NESTED_FAMILY: Int32;
    class const MONO_TYPE_ATTR_NESTED_ASSEMBLY: Int32;
    class const MONO_TYPE_ATTR_NESTED_FAM_AND_ASSEM: Int32;
    class const MONO_TYPE_ATTR_NESTED_FAM_OR_ASSEM: Int32;
    class const MONO_TYPE_ATTR_LAYOUT_MASK: Int32;
    class const MONO_TYPE_ATTR_AUTO_LAYOUT: Int32;
    class const MONO_TYPE_ATTR_SEQUENTIAL_LAYOUT: Int32;
    class const MONO_TYPE_ATTR_EXPLICIT_LAYOUT: Int32;
    class const MONO_TYPE_ATTR_CLASS_SEMANTIC_MASK: Int32;
    class const MONO_TYPE_ATTR_CLASS: Int32;
    class const MONO_TYPE_ATTR_INTERFACE: Int32;
    class const MONO_TYPE_ATTR_ABSTRACT: Int32;
    class const MONO_TYPE_ATTR_SEALED: Int32;
    class const MONO_TYPE_ATTR_SPECIAL_NAME: Int32;
    class const MONO_TYPE_ATTR_IMPORT: Int32;
    class const MONO_TYPE_ATTR_SERIALIZABLE: Int32;
    class const MONO_TYPE_ATTR_STRING_FORMAT_MASK: Int32;
    class const MONO_TYPE_ATTR_ANSI_CLASS: Int32;
    class const MONO_TYPE_ATTR_UNICODE_CLASS: Int32;
    class const MONO_TYPE_ATTR_AUTO_CLASS: Int32;
    class const MONO_TYPE_ATTR_CUSTOM_CLASS: Int32;
    class const MONO_TYPE_ATTR_CUSTOM_MASK: Int32;
    class const MONO_TYPE_ATTR_BEFORE_FIELD_INIT: Int32;
    class const MONO_TYPE_ATTR_FORWARDER: Int32;
    class const MONO_TYPE_ATTR_RESERVED_MASK: Int32;
    class const MONO_TYPE_ATTR_RT_SPECIAL_NAME: Int32;
    class const MONO_TYPE_ATTR_HAS_SECURITY: Int32;
    class method mono_disasm_code_one(dh: ^MonoDisHelper; &method: ^MonoMethod; ip: ^mono_byte; endp: ^^mono_byte): ^AnsiChar;
    class method mono_disasm_code(dh: ^MonoDisHelper; &method: ^MonoMethod; ip: ^mono_byte; &end: ^mono_byte): ^AnsiChar;
    class method mono_type_full_name(&type: ^MonoType): ^AnsiChar;
    class method mono_signature_get_desc(sig: ^MonoMethodSignature; include_namespace: mono_bool): ^AnsiChar;
    class method mono_context_get_desc(context: ^MonoGenericContext): ^AnsiChar;
    class method mono_method_desc_new(name: ^AnsiChar; include_namespace: mono_bool): ^MonoMethodDesc;
    class method mono_method_desc_from_method(&method: ^MonoMethod): ^MonoMethodDesc;
    class method mono_method_desc_free(&desc: ^MonoMethodDesc);
    class method mono_method_desc_match(&desc: ^MonoMethodDesc; &method: ^MonoMethod): mono_bool;
    class method mono_method_desc_full_match(&desc: ^MonoMethodDesc; &method: ^MonoMethod): mono_bool;
    class method mono_method_desc_search_in_class(&desc: ^MonoMethodDesc; klass: ^MonoClass): ^MonoMethod;
    class method mono_method_desc_search_in_image(&desc: ^MonoMethodDesc; image: ^MonoImage): ^MonoMethod;
    class method mono_method_full_name(&method: ^MonoMethod; signature: mono_bool): ^AnsiChar;
    class method mono_field_full_name(field: ^MonoClassField): ^AnsiChar;
    class method mono_environment_exitcode_get: int32_t;
    class method mono_environment_exitcode_set(value: int32_t);
    class method mono_exception_from_name(image: ^MonoImage; name_space: ^AnsiChar; name: ^AnsiChar): ^MonoException;
    class method mono_exception_from_token(image: ^MonoImage; token: uint32_t): ^MonoException;
    class method mono_exception_from_name_two_strings(image: ^MonoImage; name_space: ^AnsiChar; name: ^AnsiChar; a1: ^MonoString; a2: ^MonoString): ^MonoException;
    class method mono_exception_from_name_msg(image: ^MonoImage; name_space: ^AnsiChar; name: ^AnsiChar; msg: ^AnsiChar): ^MonoException;
    class method mono_exception_from_token_two_strings(image: ^MonoImage; token: uint32_t; a1: ^MonoString; a2: ^MonoString): ^MonoException;
    class method mono_exception_from_name_domain(domain: ^MonoDomain; image: ^MonoImage; name_space: ^AnsiChar; name: ^AnsiChar): ^MonoException;
    class method mono_get_exception_divide_by_zero: ^MonoException;
    class method mono_get_exception_security: ^MonoException;
    class method mono_get_exception_arithmetic: ^MonoException;
    class method mono_get_exception_overflow: ^MonoException;
    class method mono_get_exception_null_reference: ^MonoException;
    class method mono_get_exception_execution_engine(msg: ^AnsiChar): ^MonoException;
    class method mono_get_exception_thread_abort: ^MonoException;
    class method mono_get_exception_thread_state(msg: ^AnsiChar): ^MonoException;
    class method mono_get_exception_thread_interrupted: ^MonoException;
    class method mono_get_exception_serialization(msg: ^AnsiChar): ^MonoException;
    class method mono_get_exception_invalid_cast: ^MonoException;
    class method mono_get_exception_invalid_operation(msg: ^AnsiChar): ^MonoException;
    class method mono_get_exception_index_out_of_range: ^MonoException;
    class method mono_get_exception_array_type_mismatch: ^MonoException;
    class method mono_get_exception_type_load(class_name: ^MonoString; assembly_name: ^AnsiChar): ^MonoException;
    class method mono_get_exception_missing_method(class_name: ^AnsiChar; member_name: ^AnsiChar): ^MonoException;
    class method mono_get_exception_missing_field(class_name: ^AnsiChar; member_name: ^AnsiChar): ^MonoException;
    class method mono_get_exception_not_implemented(msg: ^AnsiChar): ^MonoException;
    class method mono_get_exception_not_supported(msg: ^AnsiChar): ^MonoException;
    class method mono_get_exception_argument_null(arg: ^AnsiChar): ^MonoException;
    class method mono_get_exception_argument(arg: ^AnsiChar; msg: ^AnsiChar): ^MonoException;
    class method mono_get_exception_argument_out_of_range(arg: ^AnsiChar): ^MonoException;
    class method mono_get_exception_io(msg: ^AnsiChar): ^MonoException;
    class method mono_get_exception_file_not_found(fname: ^MonoString): ^MonoException;
    class method mono_get_exception_file_not_found2(msg: ^AnsiChar; fname: ^MonoString): ^MonoException;
    class method mono_get_exception_type_initialization(type_name: ^AnsiChar; inner: ^MonoException): ^MonoException;
    class method mono_get_exception_synchronization_lock(msg: ^AnsiChar): ^MonoException;
    class method mono_get_exception_cannot_unload_appdomain(msg: ^AnsiChar): ^MonoException;
    class method mono_get_exception_appdomain_unloaded: ^MonoException;
    class method mono_get_exception_bad_image_format(msg: ^AnsiChar): ^MonoException;
    class method mono_get_exception_bad_image_format2(msg: ^AnsiChar; fname: ^MonoString): ^MonoException;
    class method mono_get_exception_stack_overflow: ^MonoException;
    class method mono_get_exception_out_of_memory: ^MonoException;
    class method mono_get_exception_field_access: ^MonoException;
    class method mono_get_exception_method_access: ^MonoException;
    class method mono_get_exception_reflection_type_load(types: ^MonoArray; exceptions: ^MonoArray): ^MonoException;
    class method mono_get_exception_runtime_wrapped(wrapped_exception: ^mono.metadata.MonoObject): ^MonoException;
    class method mono_get_config_dir: ^AnsiChar;
    class method mono_set_config_dir(dir: ^AnsiChar);
    class method mono_get_machine_config: ^AnsiChar;
    class method mono_config_cleanup;
    class method mono_config_parse(filename: ^AnsiChar);
    class method mono_config_for_assembly(&assembly: ^MonoImage);
    class method mono_config_parse_memory(buffer: ^AnsiChar);
    class method mono_config_string_for_assembly_file(filename: ^AnsiChar): ^AnsiChar;
    class method mono_config_set_server_mode(server_mode: mono_bool);
    class method mono_config_is_server_mode: mono_bool;
    class method mono_debug_enabled: mono_bool;
    class method mono_debug_init(format: mono.metadata.MonoDebugFormat);
    class method mono_debug_open_image_from_memory(image: ^MonoImage; raw_contents: ^mono_byte; size: Int32);
    class method mono_debug_cleanup;
    class method mono_debug_close_image(image: ^MonoImage);
    class method mono_debug_domain_unload(domain: ^MonoDomain);
    class method mono_debug_domain_create(domain: ^MonoDomain);
    class method mono_debug_add_method(&method: ^MonoMethod; jit: ^MonoDebugMethodJitInfo; domain: ^MonoDomain): ^MonoDebugMethodAddress;
    class method mono_debug_remove_method(&method: ^MonoMethod; domain: ^MonoDomain);
    class method mono_debug_lookup_method(&method: ^MonoMethod): ^MonoDebugMethodInfo;
    class method mono_debug_lookup_method_addresses(&method: ^MonoMethod): ^MonoDebugMethodAddressList;
    class method mono_debug_find_method(&method: ^MonoMethod; domain: ^MonoDomain): ^MonoDebugMethodJitInfo;
    class method mono_debug_free_method_jit_info(jit: ^MonoDebugMethodJitInfo);
    class method mono_debug_add_delegate_trampoline(code: ^Void; size: Int32);
    class method mono_debug_lookup_locals(&method: ^MonoMethod): ^MonoDebugLocalsInfo;
    class method mono_debug_lookup_source_location(&method: ^MonoMethod; address: uint32_t; domain: ^MonoDomain): ^MonoDebugSourceLocation;
    class method mono_debug_il_offset_from_address(&method: ^MonoMethod; domain: ^MonoDomain; native_offset: uint32_t): int32_t;
    class method mono_debug_free_source_location(location: ^MonoDebugSourceLocation);
    class method mono_debug_print_stack_frame(&method: ^MonoMethod; native_offset: uint32_t; domain: ^MonoDomain): ^AnsiChar;
    class method mono_debugger_method_has_breakpoint(&method: ^MonoMethod): Int32;
    class method mono_debugger_insert_breakpoint(method_name: ^AnsiChar; include_namespace: mono_bool): Int32;
    class method mono_set_is_debugger_attached(attached: mono_bool);
    class method mono_is_debugger_attached: mono_bool;
    class method mono_gc_collect(generation: Int32);
    class method mono_gc_max_generation: Int32;
    class method mono_gc_get_generation(object: ^mono.metadata.MonoObject): Int32;
    class method mono_gc_collection_count(generation: Int32): Int32;
    class method mono_gc_get_used_size: int64_t;
    class method mono_gc_get_heap_size: int64_t;
    class method mono_gc_invoke_finalizers: Int32;
    class method mono_gc_walk_heap(&flags: Int32; callback: mono.metadata.MonoGCReferences; data: ^Void): Int32;
    class const MONO_FLOW_NEXT: Int32;
    class const MONO_FLOW_BRANCH: Int32;
    class const MONO_FLOW_COND_BRANCH: Int32;
    class const MONO_FLOW_ERROR: Int32;
    class const MONO_FLOW_CALL: Int32;
    class const MONO_FLOW_RETURN: Int32;
    class const MONO_FLOW_META: Int32;
    class const MonoInlineNone: Int32;
    class const MonoInlineType: Int32;
    class const MonoInlineField: Int32;
    class const MonoInlineMethod: Int32;
    class const MonoInlineTok: Int32;
    class const MonoInlineString: Int32;
    class const MonoInlineSig: Int32;
    class const MonoInlineVar: Int32;
    class const MonoShortInlineVar: Int32;
    class const MonoInlineBrTarget: Int32;
    class const MonoShortInlineBrTarget: Int32;
    class const MonoInlineSwitch: Int32;
    class const MonoInlineR: Int32;
    class const MonoShortInlineR: Int32;
    class const MonoInlineI: Int32;
    class const MonoShortInlineI: Int32;
    class const MonoInlineI8: Int32;
    class var mono_opcodes: ^mono.metadata.MonoOpcode;
    class method mono_opcode_name(opcode: Int32): ^AnsiChar;
    class method mono_opcode_value(ip: ^^mono_byte; &end: ^mono_byte): mono.metadata.MonoOpcodeEnum;
    class method mono_profiler_install(prof: ^MonoProfiler; shutdown_callback: mono.metadata.MonoProfileFunc);
    class method mono_profiler_set_events(events: mono.metadata.MonoProfileFlags);
    class method mono_profiler_get_events: mono.metadata.MonoProfileFlags;
    class method mono_profiler_install_appdomain(start_load: mono.metadata.MonoProfileAppDomainFunc; end_load: mono.metadata.MonoProfileAppDomainResult; start_unload: mono.metadata.MonoProfileAppDomainFunc; end_unload: mono.metadata.MonoProfileAppDomainFunc);
    class method mono_profiler_install_assembly(start_load: mono.metadata.MonoProfileAssemblyFunc; end_load: mono.metadata.MonoProfileAssemblyResult; start_unload: mono.metadata.MonoProfileAssemblyFunc; end_unload: mono.metadata.MonoProfileAssemblyFunc);
    class method mono_profiler_install_module(start_load: mono.metadata.MonoProfileModuleFunc; end_load: mono.metadata.MonoProfileModuleResult; start_unload: mono.metadata.MonoProfileModuleFunc; end_unload: mono.metadata.MonoProfileModuleFunc);
    class method mono_profiler_install_class(start_load: mono.metadata.MonoProfileClassFunc; end_load: mono.metadata.MonoProfileClassResult; start_unload: mono.metadata.MonoProfileClassFunc; end_unload: mono.metadata.MonoProfileClassFunc);
    class method mono_profiler_install_jit_compile(start: mono.metadata.MonoProfileMethodFunc; &end: mono.metadata.MonoProfileMethodResult);
    class method mono_profiler_install_jit_end(&end: mono.metadata.MonoProfileJitResult);
    class method mono_profiler_install_method_free(callback: mono.metadata.MonoProfileMethodFunc);
    class method mono_profiler_install_method_invoke(start: mono.metadata.MonoProfileMethodFunc; &end: mono.metadata.MonoProfileMethodFunc);
    class method mono_profiler_install_enter_leave(enter: mono.metadata.MonoProfileMethodFunc; fleave: mono.metadata.MonoProfileMethodFunc);
    class method mono_profiler_install_thread(start: mono.metadata.MonoProfileThreadFunc; &end: mono.metadata.MonoProfileThreadFunc);
    class method mono_profiler_install_thread_name(thread_name_cb: mono.metadata.MonoProfileThreadNameFunc);
    class method mono_profiler_install_transition(callback: mono.metadata.MonoProfileMethodResult);
    class method mono_profiler_install_allocation(callback: mono.metadata.MonoProfileAllocFunc);
    class method mono_profiler_install_monitor(callback: mono.metadata.MonoProfileMonitorFunc);
    class method mono_profiler_install_statistical(callback: mono.metadata.MonoProfileStatFunc);
    class method mono_profiler_install_statistical_call_chain(callback: mono.metadata.MonoProfileStatCallChainFunc; call_chain_depth: Int32; call_chain_strategy: mono.metadata.MonoProfilerCallChainStrategy);
    class method mono_profiler_install_exception(throw_callback: mono.metadata.MonoProfileExceptionFunc; exc_method_leave: mono.metadata.MonoProfileMethodFunc; clause_callback: mono.metadata.MonoProfileExceptionClauseFunc);
    class method mono_profiler_install_coverage_filter(callback: mono.metadata.MonoProfileCoverageFilterFunc);
    class method mono_profiler_coverage_get(prof: ^MonoProfiler; &method: ^MonoMethod; func: mono.metadata.MonoProfileCoverageFunc);
    class method mono_profiler_install_gc(callback: mono.metadata.MonoProfileGCFunc; heap_resize_callback: mono.metadata.MonoProfileGCResizeFunc);
    class method mono_profiler_install_gc_moves(callback: mono.metadata.MonoProfileGCMoveFunc);
    class method mono_profiler_install_gc_roots(handle_callback: mono.metadata.MonoProfileGCHandleFunc; roots_callback: mono.metadata.MonoProfileGCRootFunc);
    class method mono_profiler_install_runtime_initialized(runtime_initialized_callback: mono.metadata.MonoProfileFunc);
    class method mono_profiler_install_code_chunk_new(callback: mono.metadata.MonoProfilerCodeChunkNew);
    class method mono_profiler_install_code_chunk_destroy(callback: mono.metadata.MonoProfilerCodeChunkDestroy);
    class method mono_profiler_install_code_buffer_new(callback: mono.metadata.MonoProfilerCodeBufferNew);
    class method mono_profiler_install_iomap(callback: mono.metadata.MonoProfileIomapFunc);
    class method mono_profiler_load(&desc: ^AnsiChar);
    class method mono_profiler_set_statistical_mode(mode: mono.metadata.MonoProfileSamplingMode; sampling_frequency_is_us: int64_t);
    class method mono_thread_init(start_cb: mono.metadata.MonoThreadStartCB; attach_cb: mono.metadata.MonoThreadAttachCB);
    class method mono_thread_cleanup;
    class method mono_thread_manage;
    class method mono_thread_current: ^MonoThread;
    class method mono_thread_set_main(thread: ^MonoThread);
    class method mono_thread_get_main: ^MonoThread;
    class method mono_thread_stop(thread: ^MonoThread);
    class method mono_thread_new_init(tid: intptr_t; stack_start: ^Void; func: ^Void);
    class method mono_thread_create(domain: ^MonoDomain; func: ^Void; arg: ^Void);
    class method mono_thread_attach(domain: ^MonoDomain): ^MonoThread;
    class method mono_thread_detach(thread: ^MonoThread);
    class method mono_thread_exit;
    class method mono_thread_set_manage_callback(thread: ^MonoThread; func: mono.metadata.MonoThreadManageCallback);
    class method mono_threads_set_default_stacksize(stacksize: uint32_t);
    class method mono_threads_get_default_stacksize: uint32_t;
    class method mono_threads_request_thread_dump;
    class method mono_thread_is_foreign(thread: ^MonoThread): mono_bool;
    class method mono_thread_detach_if_exiting;
    class const MONO_TABLE_LAST: Int32;
    class const MONO_TABLE_NUM: Int32;
    class const MONO_ZERO_LEN_ARRAY: Int32;
    class const _MONO_METADATA_LOADER_H_: Int32;
    class const MONO_DECLSEC_ACTION_MIN: Int32;
    class const MONO_DECLSEC_ACTION_MAX: Int32;
    class const MONO_DEBUG_VAR_ADDRESS_MODE_FLAGS: Int32;
    class const MONO_DEBUG_VAR_ADDRESS_MODE_REGISTER: Int32;
    class const MONO_DEBUG_VAR_ADDRESS_MODE_REGOFFSET: Int32;
    class const MONO_DEBUG_VAR_ADDRESS_MODE_TWO_REGISTERS: Int32;
    class const MONO_DEBUG_VAR_ADDRESS_MODE_DEAD: Int32;
    class const MONO_DEBUG_VAR_ADDRESS_MODE_REGOFFSET_INDIR: Int32;
    class const MONO_DEBUG_VAR_ADDRESS_MODE_GSHAREDVT_LOCAL: Int32;
    class const MONO_DEBUG_VAR_ADDRESS_MODE_VTADDR: Int32;
    class const MONO_DEBUGGER_MAJOR_VERSION: Int32;
    class const MONO_DEBUGGER_MINOR_VERSION: Int32;
    class const MONO_DEBUGGER_MAGIC: UInt64;
    class const MONO_CUSTOM_PREFIX: Int32;
    class const MONO_PROFILER_MAX_STAT_CALL_CHAIN_DEPTH: Int32;
  end;

  mono.metadata.MonoImage = public MonoImage;

  mono.metadata.MonoAssembly = public MonoAssembly;

  mono.metadata.MonoAssemblyName = public MonoAssemblyName;

  mono.metadata.MonoTableInfo = public MonoTableInfo;

  mono.metadata.MonoImageOpenStatus = public enum (
    MONO_IMAGE_OK,
    MONO_IMAGE_ERROR_ERRNO,
    MONO_IMAGE_MISSING_ASSEMBLYREF,
    MONO_IMAGE_IMAGE_INVALID
  );

  mono.metadata.MonoClass = public MonoClass;

  mono.metadata.MonoDomain = public MonoDomain;

  mono.metadata.MonoMethod = public MonoMethod;

  mono.metadata.MonoExceptionEnum = public enum (
    MONO_EXCEPTION_CLAUSE_NONE,
    MONO_EXCEPTION_CLAUSE_FILTER,
    MONO_EXCEPTION_CLAUSE_FINALLY,
    MONO_EXCEPTION_CLAUSE_FAULT
  );

  mono.metadata.MonoCallConvention = public enum (
    MONO_CALL_DEFAULT,
    MONO_CALL_C,
    MONO_CALL_STDCALL,
    MONO_CALL_THISCALL,
    MONO_CALL_FASTCALL,
    MONO_CALL_VARARG
  );

  mono.metadata.MonoMarshalNative = public enum (
    MONO_NATIVE_BOOLEAN,
    MONO_NATIVE_I1,
    MONO_NATIVE_U1,
    MONO_NATIVE_I2,
    MONO_NATIVE_U2,
    MONO_NATIVE_I4,
    MONO_NATIVE_U4,
    MONO_NATIVE_I8,
    MONO_NATIVE_U8,
    MONO_NATIVE_R4,
    MONO_NATIVE_R8,
    MONO_NATIVE_CURRENCY,
    MONO_NATIVE_BSTR,
    MONO_NATIVE_LPSTR,
    MONO_NATIVE_LPWSTR,
    MONO_NATIVE_LPTSTR,
    MONO_NATIVE_BYVALTSTR,
    MONO_NATIVE_IUNKNOWN,
    MONO_NATIVE_IDISPATCH,
    MONO_NATIVE_STRUCT,
    MONO_NATIVE_INTERFACE,
    MONO_NATIVE_SAFEARRAY,
    MONO_NATIVE_BYVALARRAY,
    MONO_NATIVE_INT,
    MONO_NATIVE_UINT,
    MONO_NATIVE_VBBYREFSTR,
    MONO_NATIVE_ANSIBSTR,
    MONO_NATIVE_TBSTR,
    MONO_NATIVE_VARIANTBOOL,
    MONO_NATIVE_FUNC,
    MONO_NATIVE_ASANY,
    MONO_NATIVE_LPARRAY,
    MONO_NATIVE_LPSTRUCT,
    MONO_NATIVE_CUSTOM,
    MONO_NATIVE_ERROR,
    MONO_NATIVE_MAX
  );

  mono.metadata.MonoMarshalVariant = public enum (
    MONO_VARIANT_EMPTY,
    MONO_VARIANT_NULL,
    MONO_VARIANT_I2,
    MONO_VARIANT_I4,
    MONO_VARIANT_R4,
    MONO_VARIANT_R8,
    MONO_VARIANT_CY,
    MONO_VARIANT_DATE,
    MONO_VARIANT_BSTR,
    MONO_VARIANT_DISPATCH,
    MONO_VARIANT_ERROR,
    MONO_VARIANT_BOOL,
    MONO_VARIANT_VARIANT,
    MONO_VARIANT_UNKNOWN,
    MONO_VARIANT_DECIMAL,
    MONO_VARIANT_I1,
    MONO_VARIANT_UI1,
    MONO_VARIANT_UI2,
    MONO_VARIANT_UI4,
    MONO_VARIANT_I8,
    MONO_VARIANT_UI8,
    MONO_VARIANT_INT,
    MONO_VARIANT_UINT,
    MONO_VARIANT_VOID,
    MONO_VARIANT_HRESULT,
    MONO_VARIANT_PTR,
    MONO_VARIANT_SAFEARRAY,
    MONO_VARIANT_CARRAY,
    MONO_VARIANT_USERDEFINED,
    MONO_VARIANT_LPSTR,
    MONO_VARIANT_LPWSTR,
    MONO_VARIANT_RECORD,
    MONO_VARIANT_FILETIME,
    MONO_VARIANT_BLOB,
    MONO_VARIANT_STREAM,
    MONO_VARIANT_STORAGE,
    MONO_VARIANT_STREAMED_OBJECT,
    MONO_VARIANT_STORED_OBJECT,
    MONO_VARIANT_BLOB_OBJECT,
    MONO_VARIANT_CF,
    MONO_VARIANT_CLSID,
    MONO_VARIANT_VECTOR,
    MONO_VARIANT_ARRAY,
    MONO_VARIANT_BYREF
  );

  mono.metadata.MonoMarshalConv = public enum (
    MONO_MARSHAL_CONV_NONE,
    MONO_MARSHAL_CONV_BOOL_VARIANTBOOL,
    MONO_MARSHAL_CONV_BOOL_I4,
    MONO_MARSHAL_CONV_STR_BSTR,
    MONO_MARSHAL_CONV_STR_LPSTR,
    MONO_MARSHAL_CONV_LPSTR_STR,
    MONO_MARSHAL_CONV_LPTSTR_STR,
    MONO_MARSHAL_CONV_STR_LPWSTR,
    MONO_MARSHAL_CONV_LPWSTR_STR,
    MONO_MARSHAL_CONV_STR_LPTSTR,
    MONO_MARSHAL_CONV_STR_ANSIBSTR,
    MONO_MARSHAL_CONV_STR_TBSTR,
    MONO_MARSHAL_CONV_STR_BYVALSTR,
    MONO_MARSHAL_CONV_STR_BYVALWSTR,
    MONO_MARSHAL_CONV_SB_LPSTR,
    MONO_MARSHAL_CONV_SB_LPTSTR,
    MONO_MARSHAL_CONV_SB_LPWSTR,
    MONO_MARSHAL_CONV_LPSTR_SB,
    MONO_MARSHAL_CONV_LPTSTR_SB,
    MONO_MARSHAL_CONV_LPWSTR_SB,
    MONO_MARSHAL_CONV_ARRAY_BYVALARRAY,
    MONO_MARSHAL_CONV_ARRAY_BYVALCHARARRAY,
    MONO_MARSHAL_CONV_ARRAY_SAVEARRAY,
    MONO_MARSHAL_CONV_ARRAY_LPARRAY,
    MONO_MARSHAL_FREE_LPARRAY,
    MONO_MARSHAL_CONV_OBJECT_INTERFACE,
    MONO_MARSHAL_CONV_OBJECT_IDISPATCH,
    MONO_MARSHAL_CONV_OBJECT_IUNKNOWN,
    MONO_MARSHAL_CONV_OBJECT_STRUCT,
    MONO_MARSHAL_CONV_DEL_FTN,
    MONO_MARSHAL_CONV_FTN_DEL,
    MONO_MARSHAL_FREE_ARRAY,
    MONO_MARSHAL_CONV_BSTR_STR,
    MONO_MARSHAL_CONV_SAFEHANDLE,
    MONO_MARSHAL_CONV_HANDLEREF
  );

  mono.metadata.MonoMarshalSpec = public record
  public
    var native: mono.metadata.MonoMarshalNative;
    var data: data_type;
  end;

  data_type nested in mono.metadata.MonoMarshalSpec  //  union!
 = public record
  public
    var array_data: array_data_type;
    var custom_data: custom_data_type;
    var safearray_data: safearray_data_type;
  end;

  array_data_type nested in mono.metadata.MonoMarshalSpec.data_type = public record
  public
    var elem_type: mono.metadata.MonoMarshalNative;
    var num_elem: int32_t;
    var param_num: int16_t;
    var elem_mult: int16_t;
  end;

  custom_data_type nested in mono.metadata.MonoMarshalSpec.data_type = public record
  public
    var custom_name: ^AnsiChar;
    var cookie: ^AnsiChar;
    var image: ^MonoImage;
  end;

  safearray_data_type nested in mono.metadata.MonoMarshalSpec.data_type = public record
  public
    var elem_type: mono.metadata.MonoMarshalVariant;
    var num_elem: int32_t;
  end;

  mono.metadata.MonoExceptionClause = public record
  public
    var &flags: uint32_t;
    var try_offset: uint32_t;
    var try_len: uint32_t;
    var handler_offset: uint32_t;
    var handler_len: uint32_t;
    var data: data_type;
  end;

  data_type nested in mono.metadata.MonoExceptionClause  //  union!
 = public record
  public
    var filter_offset: uint32_t;
    var catch_class: ^MonoClass;
  end;

  mono.metadata.MonoType = public MonoType;

  mono.metadata.MonoGenericInst = public MonoGenericInst;

  mono.metadata.MonoGenericClass = public MonoGenericClass;

  mono.metadata.MonoDynamicGenericClass = public MonoDynamicGenericClass;

  mono.metadata.MonoGenericContext = public MonoGenericContext;

  mono.metadata.MonoGenericContainer = public MonoGenericContainer;

  mono.metadata.MonoGenericParam = public MonoGenericParam;

  mono.metadata.MonoArrayType = public MonoArrayType;

  mono.metadata.MonoMethodSignature = public MonoMethodSignature;

  mono.metadata.MonoGenericMethod = public MonoGenericMethod;

  mono.metadata.MonoCustomMod = public record
  public
    var required: UInt32;
    var token: UInt32;
  end;

  mono.metadata.__struct__MonoArrayType = public record
  public
    var eklass: ^MonoClass;
    var rank: uint8_t;
    var numsizes: uint8_t;
    var numlobounds: uint8_t;
    var sizes: ^Int32;
    var lobounds: ^Int32;
  end;

  mono.metadata.MonoMethodHeader = public MonoMethodHeader;

  mono.metadata.MonoParseTypeMode = public enum (
    MONO_PARSE_TYPE,
    MONO_PARSE_MOD_TYPE,
    MONO_PARSE_LOCAL,
    MONO_PARSE_PARAM,
    MONO_PARSE_RET,
    MONO_PARSE_FIELD
  );

  mono.metadata.MonoStackWalk = public method (&method: ^MonoMethod; native_offset: int32_t; il_offset: int32_t; managed: mono_bool; data: ^Void): mono_bool;

  mono.metadata.MonoStackWalkAsyncSafe = public method (&method: ^MonoMethod; domain: ^MonoDomain; base_address: ^Void; offset: Int32; data: ^Void): mono_bool;

  mono.metadata.MonoVTable = public MonoVTable;

  mono.metadata.MonoClassField = public MonoClassField;

  mono.metadata.MonoProperty = public MonoProperty;

  mono.metadata.MonoEvent = public MonoEvent;

  mono.metadata.MonoBoolean = public MonoBoolean;

  mono.metadata.MonoString = public MonoString;

  mono.metadata.MonoArray = public MonoArray;

  mono.metadata.MonoReflectionMethod = public MonoReflectionMethod;

  mono.metadata.MonoReflectionAssembly = public MonoReflectionAssembly;

  mono.metadata.MonoReflectionModule = public MonoReflectionModule;

  mono.metadata.MonoReflectionField = public MonoReflectionField;

  mono.metadata.MonoReflectionProperty = public MonoReflectionProperty;

  mono.metadata.MonoReflectionEvent = public MonoReflectionEvent;

  mono.metadata.MonoReflectionType = public MonoReflectionType;

  mono.metadata.MonoDelegate = public MonoDelegate;

  mono.metadata.MonoException = public MonoException;

  mono.metadata.MonoThreadsSync = public MonoThreadsSync;

  mono.metadata.MonoThread = public MonoThread;

  mono.metadata.MonoDynamicAssembly = public MonoDynamicAssembly;

  mono.metadata.MonoDynamicImage = public MonoDynamicImage;

  mono.metadata.MonoReflectionMethodBody = public MonoReflectionMethodBody;

  mono.metadata.MonoAppContext = public MonoAppContext;

  mono.metadata.MonoObject = public record
  public
    var vtable: ^MonoVTable;
    var synchronisation: ^MonoThreadsSync;
  end;

  mono.metadata.__struct__MonoObject = public record
  public
    var vtable: ^MonoVTable;
    var synchronisation: ^MonoThreadsSync;
  end;

  mono.metadata.MonoInvokeFunc = public method (&method: ^MonoMethod; obj: ^Void; &params: ^^Void; exc: ^^mono.metadata.MonoObject): ^mono.metadata.MonoObject;

  mono.metadata.MonoCompileFunc = public method (&method: ^MonoMethod): ^Void;

  mono.metadata.MonoMainThreadFunc = public method (user_data: ^Void);

  mono.metadata.mono_reference_queue_callback = public method (user_data: ^Void);

  mono.metadata.MonoReferenceQueue = public MonoReferenceQueue;

  mono.metadata.MonoTypeNameParse = public MonoTypeNameParse;

  mono.metadata.MonoCustomAttrEntry = public record
  public
    var ctor: ^MonoMethod;
    var data_size: uint32_t;
    var data: ^mono_byte;
  end;

  mono.metadata.MonoCustomAttrInfo = public record
  public
    var num_attrs: Int32;
    var cached: Int32;
    var image: ^MonoImage;
    var attrs: array of mono.metadata.MonoCustomAttrEntry;
  end;

  mono.metadata.MonoReflectionMethodAux = public record
  public
    var param_names: ^^AnsiChar;
    var param_marshall: ^^mono.metadata.MonoMarshalSpec;
    var param_cattr: ^^mono.metadata.MonoCustomAttrInfo;
    var param_defaults: ^^uint8_t;
    var param_default_types: ^uint32_t;
    var dllentry: ^AnsiChar;
    var dll: ^AnsiChar;
  end;

  mono.metadata.MonoResolveTokenError = public enum (
    ResolveTokenError_OutOfRange,
    ResolveTokenError_BadTable,
    ResolveTokenError_Other
  );

  mono.metadata.MonoDeclSecurityEntry = public record
  public
    var blob: ^AnsiChar;
    var size: uint32_t;
    var &index: uint32_t;
  end;

  mono.metadata.MonoDeclSecurityActions = public record
  public
    var demand: mono.metadata.MonoDeclSecurityEntry;
    var noncasdemand: mono.metadata.MonoDeclSecurityEntry;
    var demandchoice: mono.metadata.MonoDeclSecurityEntry;
  end;

  mono.metadata.MonoThreadStartCB = public method (tid: intptr_t; stack_start: ^Void; func: ^Void);

  mono.metadata.MonoThreadAttachCB = public method (tid: intptr_t; stack_start: ^Void);

  mono.metadata.MonoAppDomain = public MonoAppDomain;

  mono.metadata.MonoJitInfo = public MonoJitInfo;

  mono.metadata.MonoDomainFunc = public method (domain: ^MonoDomain; user_data: ^Void);

  mono.metadata.MonoCoreClrPlatformCB = public method (image_name: ^AnsiChar): mono_bool;

  mono.metadata.MonoAssemblyLoadFunc = public method (&assembly: ^MonoAssembly; user_data: ^Void);

  mono.metadata.MonoAssemblySearchFunc = public method (aname: ^MonoAssemblyName; user_data: ^Void): ^MonoAssembly;

  mono.metadata.MonoAssemblyPreLoadFunc = public method (aname: ^MonoAssemblyName; assemblies_path: ^^AnsiChar; user_data: ^Void): ^MonoAssembly;

  mono.metadata.MonoBundledAssembly = public record
  public
    var name: ^AnsiChar;
    var data: ^Byte;
    var size: UInt32;
  end;

  mono.metadata.MonoDisHelper = public MonoDisHelper;

  mono.metadata.MonoDisIndenter = public method (dh: ^MonoDisHelper; &method: ^MonoMethod; ip_offset: uint32_t): ^AnsiChar;

  mono.metadata.MonoDisTokener = public method (dh: ^MonoDisHelper; &method: ^MonoMethod; token: uint32_t): ^AnsiChar;

  mono.metadata.__struct_MonoDisHelper = public record
  public
    var newline: ^AnsiChar;
    var label_format: ^AnsiChar;
    var label_target: ^AnsiChar;
    var indenter: mono.metadata.MonoDisIndenter;
    var tokener: mono.metadata.MonoDisTokener;
    var user_data: ^Void;
  end;

  mono.metadata.MonoMethodDesc = public MonoMethodDesc;

  mono.metadata.MonoSymbolTable = public MonoSymbolTable;

  mono.metadata.MonoDebugDataTable = public MonoDebugDataTable;

  mono.metadata.MonoSymbolFile = public MonoSymbolFile;

  mono.metadata.MonoPPDBFile = public MonoPPDBFile;

  mono.metadata.MonoDebugHandle = public MonoDebugHandle;

  mono.metadata.MonoDebugLineNumberEntry = public MonoDebugLineNumberEntry;

  mono.metadata.MonoDebugVarInfo = public MonoDebugVarInfo;

  mono.metadata.MonoDebugMethodJitInfo = public MonoDebugMethodJitInfo;

  mono.metadata.MonoDebugMethodAddress = public MonoDebugMethodAddress;

  mono.metadata.MonoDebugMethodAddressList = public MonoDebugMethodAddressList;

  mono.metadata.MonoDebugClassEntry = public MonoDebugClassEntry;

  mono.metadata.MonoDebugMethodInfo = public MonoDebugMethodInfo;

  mono.metadata.MonoDebugLocalsInfo = public MonoDebugLocalsInfo;

  mono.metadata.MonoDebugSourceLocation = public MonoDebugSourceLocation;

  mono.metadata.MonoDebugList = public MonoDebugList;

  mono.metadata.MonoDebugFormat = public enum (
    MONO_DEBUG_FORMAT_NONE,
    MONO_DEBUG_FORMAT_MONO,
    MONO_DEBUG_FORMAT_DEBUGGER
  );

  mono.metadata.__struct__MonoDebugList = public record
  public
    var next: ^MonoDebugList;
    var data: ^Void;
  end;

  mono.metadata.__struct__MonoSymbolTable = public record
  public
    var magic: uint64_t;
    var version: uint32_t;
    var total_size: uint32_t;
    var corlib: ^MonoDebugHandle;
    var global_data_table: ^MonoDebugDataTable;
    var data_tables: ^MonoDebugList;
    var symbol_files: ^MonoDebugList;
  end;

  mono.metadata.__struct__MonoDebugHandle = public record
  public
    var &index: uint32_t;
    var image_file: ^AnsiChar;
    var image: ^MonoImage;
    var type_table: ^MonoDebugDataTable;
    var symfile: ^MonoSymbolFile;
    var ppdb: ^MonoPPDBFile;
  end;

  mono.metadata.__struct__MonoDebugMethodJitInfo = public record
  public
    var code_start: ^mono_byte;
    var code_size: uint32_t;
    var prologue_end: uint32_t;
    var epilogue_begin: uint32_t;
    var wrapper_addr: ^mono_byte;
    var num_line_numbers: uint32_t;
    var line_numbers: ^MonoDebugLineNumberEntry;
    var num_params: uint32_t;
    var this_var: ^MonoDebugVarInfo;
    var &params: ^MonoDebugVarInfo;
    var num_locals: uint32_t;
    var locals: ^MonoDebugVarInfo;
    var gsharedvt_info_var: ^MonoDebugVarInfo;
    var gsharedvt_locals_var: ^MonoDebugVarInfo;
  end;

  mono.metadata.__struct__MonoDebugMethodAddressList = public record
  public
    var size: uint32_t;
    var count: uint32_t;
    var data: array of mono_byte;
  end;

  mono.metadata.__struct__MonoDebugSourceLocation = public record
  public
    var source_file: ^AnsiChar;
    var row: uint32_t;
    var column: uint32_t;
    var il_offset: uint32_t;
  end;

  mono.metadata.__struct__MonoDebugVarInfo = public record
  public
    var &index: uint32_t;
    var offset: uint32_t;
    var size: uint32_t;
    var begin_scope: uint32_t;
    var end_scope: uint32_t;
    var &type: ^MonoType;
  end;

  mono.metadata.MonoGCReferences = public method (obj: ^mono.metadata.MonoObject; klass: ^MonoClass; size: uintptr_t; num: uintptr_t; refs: ^^mono.metadata.MonoObject; offsets: ^uintptr_t; data: ^Void): Int32;

  mono.metadata.MonoOpcodeEnum = public enum (
    MONO_CEE_NOP,
    MONO_CEE_BREAK,
    MONO_CEE_LDARG_0,
    MONO_CEE_LDARG_1,
    MONO_CEE_LDARG_2,
    MONO_CEE_LDARG_3,
    MONO_CEE_LDLOC_0,
    MONO_CEE_LDLOC_1,
    MONO_CEE_LDLOC_2,
    MONO_CEE_LDLOC_3,
    MONO_CEE_STLOC_0,
    MONO_CEE_STLOC_1,
    MONO_CEE_STLOC_2,
    MONO_CEE_STLOC_3,
    MONO_CEE_LDARG_S,
    MONO_CEE_LDARGA_S,
    MONO_CEE_STARG_S,
    MONO_CEE_LDLOC_S,
    MONO_CEE_LDLOCA_S,
    MONO_CEE_STLOC_S,
    MONO_CEE_LDNULL,
    MONO_CEE_LDC_I4_M1,
    MONO_CEE_LDC_I4_0,
    MONO_CEE_LDC_I4_1,
    MONO_CEE_LDC_I4_2,
    MONO_CEE_LDC_I4_3,
    MONO_CEE_LDC_I4_4,
    MONO_CEE_LDC_I4_5,
    MONO_CEE_LDC_I4_6,
    MONO_CEE_LDC_I4_7,
    MONO_CEE_LDC_I4_8,
    MONO_CEE_LDC_I4_S,
    MONO_CEE_LDC_I4,
    MONO_CEE_LDC_I8,
    MONO_CEE_LDC_R4,
    MONO_CEE_LDC_R8,
    MONO_CEE_UNUSED99,
    MONO_CEE_DUP,
    MONO_CEE_POP,
    MONO_CEE_JMP,
    MONO_CEE_CALL,
    MONO_CEE_CALLI,
    MONO_CEE_RET,
    MONO_CEE_BR_S,
    MONO_CEE_BRFALSE_S,
    MONO_CEE_BRTRUE_S,
    MONO_CEE_BEQ_S,
    MONO_CEE_BGE_S,
    MONO_CEE_BGT_S,
    MONO_CEE_BLE_S,
    MONO_CEE_BLT_S,
    MONO_CEE_BNE_UN_S,
    MONO_CEE_BGE_UN_S,
    MONO_CEE_BGT_UN_S,
    MONO_CEE_BLE_UN_S,
    MONO_CEE_BLT_UN_S,
    MONO_CEE_BR,
    MONO_CEE_BRFALSE,
    MONO_CEE_BRTRUE,
    MONO_CEE_BEQ,
    MONO_CEE_BGE,
    MONO_CEE_BGT,
    MONO_CEE_BLE,
    MONO_CEE_BLT,
    MONO_CEE_BNE_UN,
    MONO_CEE_BGE_UN,
    MONO_CEE_BGT_UN,
    MONO_CEE_BLE_UN,
    MONO_CEE_BLT_UN,
    MONO_CEE_SWITCH,
    MONO_CEE_LDIND_I1,
    MONO_CEE_LDIND_U1,
    MONO_CEE_LDIND_I2,
    MONO_CEE_LDIND_U2,
    MONO_CEE_LDIND_I4,
    MONO_CEE_LDIND_U4,
    MONO_CEE_LDIND_I8,
    MONO_CEE_LDIND_I,
    MONO_CEE_LDIND_R4,
    MONO_CEE_LDIND_R8,
    MONO_CEE_LDIND_REF,
    MONO_CEE_STIND_REF,
    MONO_CEE_STIND_I1,
    MONO_CEE_STIND_I2,
    MONO_CEE_STIND_I4,
    MONO_CEE_STIND_I8,
    MONO_CEE_STIND_R4,
    MONO_CEE_STIND_R8,
    MONO_CEE_ADD,
    MONO_CEE_SUB,
    MONO_CEE_MUL,
    MONO_CEE_DIV,
    MONO_CEE_DIV_UN,
    MONO_CEE_REM,
    MONO_CEE_REM_UN,
    MONO_CEE_AND,
    MONO_CEE_OR,
    MONO_CEE_XOR,
    MONO_CEE_SHL,
    MONO_CEE_SHR,
    MONO_CEE_SHR_UN,
    MONO_CEE_NEG,
    MONO_CEE_NOT,
    MONO_CEE_CONV_I1,
    MONO_CEE_CONV_I2,
    MONO_CEE_CONV_I4,
    MONO_CEE_CONV_I8,
    MONO_CEE_CONV_R4,
    MONO_CEE_CONV_R8,
    MONO_CEE_CONV_U4,
    MONO_CEE_CONV_U8,
    MONO_CEE_CALLVIRT,
    MONO_CEE_CPOBJ,
    MONO_CEE_LDOBJ,
    MONO_CEE_LDSTR,
    MONO_CEE_NEWOBJ,
    MONO_CEE_CASTCLASS,
    MONO_CEE_ISINST,
    MONO_CEE_CONV_R_UN,
    MONO_CEE_UNUSED58,
    MONO_CEE_UNUSED1,
    MONO_CEE_UNBOX,
    MONO_CEE_THROW,
    MONO_CEE_LDFLD,
    MONO_CEE_LDFLDA,
    MONO_CEE_STFLD,
    MONO_CEE_LDSFLD,
    MONO_CEE_LDSFLDA,
    MONO_CEE_STSFLD,
    MONO_CEE_STOBJ,
    MONO_CEE_CONV_OVF_I1_UN,
    MONO_CEE_CONV_OVF_I2_UN,
    MONO_CEE_CONV_OVF_I4_UN,
    MONO_CEE_CONV_OVF_I8_UN,
    MONO_CEE_CONV_OVF_U1_UN,
    MONO_CEE_CONV_OVF_U2_UN,
    MONO_CEE_CONV_OVF_U4_UN,
    MONO_CEE_CONV_OVF_U8_UN,
    MONO_CEE_CONV_OVF_I_UN,
    MONO_CEE_CONV_OVF_U_UN,
    MONO_CEE_BOX,
    MONO_CEE_NEWARR,
    MONO_CEE_LDLEN,
    MONO_CEE_LDELEMA,
    MONO_CEE_LDELEM_I1,
    MONO_CEE_LDELEM_U1,
    MONO_CEE_LDELEM_I2,
    MONO_CEE_LDELEM_U2,
    MONO_CEE_LDELEM_I4,
    MONO_CEE_LDELEM_U4,
    MONO_CEE_LDELEM_I8,
    MONO_CEE_LDELEM_I,
    MONO_CEE_LDELEM_R4,
    MONO_CEE_LDELEM_R8,
    MONO_CEE_LDELEM_REF,
    MONO_CEE_STELEM_I,
    MONO_CEE_STELEM_I1,
    MONO_CEE_STELEM_I2,
    MONO_CEE_STELEM_I4,
    MONO_CEE_STELEM_I8,
    MONO_CEE_STELEM_R4,
    MONO_CEE_STELEM_R8,
    MONO_CEE_STELEM_REF,
    MONO_CEE_LDELEM,
    MONO_CEE_STELEM,
    MONO_CEE_UNBOX_ANY,
    MONO_CEE_UNUSED5,
    MONO_CEE_UNUSED6,
    MONO_CEE_UNUSED7,
    MONO_CEE_UNUSED8,
    MONO_CEE_UNUSED9,
    MONO_CEE_UNUSED10,
    MONO_CEE_UNUSED11,
    MONO_CEE_UNUSED12,
    MONO_CEE_UNUSED13,
    MONO_CEE_UNUSED14,
    MONO_CEE_UNUSED15,
    MONO_CEE_UNUSED16,
    MONO_CEE_UNUSED17,
    MONO_CEE_CONV_OVF_I1,
    MONO_CEE_CONV_OVF_U1,
    MONO_CEE_CONV_OVF_I2,
    MONO_CEE_CONV_OVF_U2,
    MONO_CEE_CONV_OVF_I4,
    MONO_CEE_CONV_OVF_U4,
    MONO_CEE_CONV_OVF_I8,
    MONO_CEE_CONV_OVF_U8,
    MONO_CEE_UNUSED50,
    MONO_CEE_UNUSED18,
    MONO_CEE_UNUSED19,
    MONO_CEE_UNUSED20,
    MONO_CEE_UNUSED21,
    MONO_CEE_UNUSED22,
    MONO_CEE_UNUSED23,
    MONO_CEE_REFANYVAL,
    MONO_CEE_CKFINITE,
    MONO_CEE_UNUSED24,
    MONO_CEE_UNUSED25,
    MONO_CEE_MKREFANY,
    MONO_CEE_UNUSED59,
    MONO_CEE_UNUSED60,
    MONO_CEE_UNUSED61,
    MONO_CEE_UNUSED62,
    MONO_CEE_UNUSED63,
    MONO_CEE_UNUSED64,
    MONO_CEE_UNUSED65,
    MONO_CEE_UNUSED66,
    MONO_CEE_UNUSED67,
    MONO_CEE_LDTOKEN,
    MONO_CEE_CONV_U2,
    MONO_CEE_CONV_U1,
    MONO_CEE_CONV_I,
    MONO_CEE_CONV_OVF_I,
    MONO_CEE_CONV_OVF_U,
    MONO_CEE_ADD_OVF,
    MONO_CEE_ADD_OVF_UN,
    MONO_CEE_MUL_OVF,
    MONO_CEE_MUL_OVF_UN,
    MONO_CEE_SUB_OVF,
    MONO_CEE_SUB_OVF_UN,
    MONO_CEE_ENDFINALLY,
    MONO_CEE_LEAVE,
    MONO_CEE_LEAVE_S,
    MONO_CEE_STIND_I,
    MONO_CEE_CONV_U,
    MONO_CEE_UNUSED26,
    MONO_CEE_UNUSED27,
    MONO_CEE_UNUSED28,
    MONO_CEE_UNUSED29,
    MONO_CEE_UNUSED30,
    MONO_CEE_UNUSED31,
    MONO_CEE_UNUSED32,
    MONO_CEE_UNUSED33,
    MONO_CEE_UNUSED34,
    MONO_CEE_UNUSED35,
    MONO_CEE_UNUSED36,
    MONO_CEE_UNUSED37,
    MONO_CEE_UNUSED38,
    MONO_CEE_UNUSED39,
    MONO_CEE_UNUSED40,
    MONO_CEE_UNUSED41,
    MONO_CEE_UNUSED42,
    MONO_CEE_UNUSED43,
    MONO_CEE_UNUSED44,
    MONO_CEE_UNUSED45,
    MONO_CEE_UNUSED46,
    MONO_CEE_UNUSED47,
    MONO_CEE_UNUSED48,
    MONO_CEE_PREFIX7,
    MONO_CEE_PREFIX6,
    MONO_CEE_PREFIX5,
    MONO_CEE_PREFIX4,
    MONO_CEE_PREFIX3,
    MONO_CEE_PREFIX2,
    MONO_CEE_PREFIX1,
    MONO_CEE_PREFIXREF,
    MONO_CEE_ARGLIST,
    MONO_CEE_CEQ,
    MONO_CEE_CGT,
    MONO_CEE_CGT_UN,
    MONO_CEE_CLT,
    MONO_CEE_CLT_UN,
    MONO_CEE_LDFTN,
    MONO_CEE_LDVIRTFTN,
    MONO_CEE_UNUSED56,
    MONO_CEE_LDARG,
    MONO_CEE_LDARGA,
    MONO_CEE_STARG,
    MONO_CEE_LDLOC,
    MONO_CEE_LDLOCA,
    MONO_CEE_STLOC,
    MONO_CEE_LOCALLOC,
    MONO_CEE_UNUSED57,
    MONO_CEE_ENDFILTER,
    MONO_CEE_UNALIGNED_,
    MONO_CEE_VOLATILE_,
    MONO_CEE_TAIL_,
    MONO_CEE_INITOBJ,
    MONO_CEE_CONSTRAINED_,
    MONO_CEE_CPBLK,
    MONO_CEE_INITBLK,
    MONO_CEE_NO_,
    MONO_CEE_RETHROW,
    MONO_CEE_UNUSED,
    MONO_CEE_SIZEOF,
    MONO_CEE_REFANYTYPE,
    MONO_CEE_READONLY_,
    MONO_CEE_UNUSED53,
    MONO_CEE_UNUSED54,
    MONO_CEE_UNUSED55,
    MONO_CEE_UNUSED70,
    MONO_CEE_ILLEGAL,
    MONO_CEE_ENDMAC,
    MONO_CEE_MONO_ICALL,
    MONO_CEE_MONO_OBJADDR,
    MONO_CEE_MONO_LDPTR,
    MONO_CEE_MONO_VTADDR,
    MONO_CEE_MONO_NEWOBJ,
    MONO_CEE_MONO_RETOBJ,
    MONO_CEE_MONO_LDNATIVEOBJ,
    MONO_CEE_MONO_CISINST,
    MONO_CEE_MONO_CCASTCLASS,
    MONO_CEE_MONO_SAVE_LMF,
    MONO_CEE_MONO_RESTORE_LMF,
    MONO_CEE_MONO_CLASSCONST,
    MONO_CEE_MONO_NOT_TAKEN,
    MONO_CEE_MONO_TLS,
    MONO_CEE_MONO_ICALL_ADDR,
    MONO_CEE_MONO_DYN_CALL,
    MONO_CEE_MONO_MEMORY_BARRIER,
    MONO_CEE_MONO_JIT_ATTACH,
    MONO_CEE_MONO_JIT_DETACH,
    MONO_CEE_MONO_JIT_ICALL_ADDR,
    MONO_CEE_MONO_LDPTR_INT_REQ_FLAG,
    MONO_CEE_MONO_LDPTR_CARD_TABLE,
    MONO_CEE_MONO_LDPTR_NURSERY_START,
    MONO_CEE_LAST
  );

  mono.metadata.MonoOpcode = public record
  public
    var argument: Byte;
    var flow_type: Byte;
    var opval: UInt16;
  end;

  mono.metadata.MonoProfileFlags = public enum (
    MONO_PROFILE_NONE,
    MONO_PROFILE_APPDOMAIN_EVENTS,
    MONO_PROFILE_ASSEMBLY_EVENTS,
    MONO_PROFILE_MODULE_EVENTS,
    MONO_PROFILE_CLASS_EVENTS,
    MONO_PROFILE_JIT_COMPILATION,
    MONO_PROFILE_INLINING,
    MONO_PROFILE_EXCEPTIONS,
    MONO_PROFILE_ALLOCATIONS,
    MONO_PROFILE_GC,
    MONO_PROFILE_THREADS,
    MONO_PROFILE_REMOTING,
    MONO_PROFILE_TRANSITIONS,
    MONO_PROFILE_ENTER_LEAVE,
    MONO_PROFILE_COVERAGE,
    MONO_PROFILE_INS_COVERAGE,
    MONO_PROFILE_STATISTICAL,
    MONO_PROFILE_METHOD_EVENTS,
    MONO_PROFILE_MONITOR_EVENTS,
    MONO_PROFILE_IOMAP_EVENTS,
    MONO_PROFILE_GC_MOVES,
    MONO_PROFILE_GC_ROOTS
  );

  mono.metadata.MonoProfileResult = public enum (
    MONO_PROFILE_OK,
    MONO_PROFILE_FAILED
  );

  mono.metadata.MonoGCEvent = public enum (
    MONO_GC_EVENT_START,
    MONO_GC_EVENT_MARK_START,
    MONO_GC_EVENT_MARK_END,
    MONO_GC_EVENT_RECLAIM_START,
    MONO_GC_EVENT_RECLAIM_END,
    MONO_GC_EVENT_END,
    MONO_GC_EVENT_PRE_STOP_WORLD,
    MONO_GC_EVENT_POST_STOP_WORLD,
    MONO_GC_EVENT_PRE_START_WORLD,
    MONO_GC_EVENT_POST_START_WORLD
  );

  mono.metadata.MonoProfileCoverageEntry = public record
  public
    var &method: ^MonoMethod;
    var iloffset: Int32;
    var counter: Int32;
    var filename: ^AnsiChar;
    var line: Int32;
    var col: Int32;
  end;

  mono.metadata.MonoProfilerCodeBufferType = public enum (
    MONO_PROFILER_CODE_BUFFER_UNKNOWN,
    MONO_PROFILER_CODE_BUFFER_METHOD,
    MONO_PROFILER_CODE_BUFFER_METHOD_TRAMPOLINE,
    MONO_PROFILER_CODE_BUFFER_UNBOX_TRAMPOLINE,
    MONO_PROFILER_CODE_BUFFER_IMT_TRAMPOLINE,
    MONO_PROFILER_CODE_BUFFER_GENERICS_TRAMPOLINE,
    MONO_PROFILER_CODE_BUFFER_SPECIFIC_TRAMPOLINE,
    MONO_PROFILER_CODE_BUFFER_HELPER,
    MONO_PROFILER_CODE_BUFFER_MONITOR,
    MONO_PROFILER_CODE_BUFFER_DELEGATE_INVOKE,
    MONO_PROFILER_CODE_BUFFER_EXCEPTION_HANDLING,
    MONO_PROFILER_CODE_BUFFER_LAST
  );

  mono.metadata.MonoProfiler = public MonoProfiler;

  mono.metadata.MonoProfilerMonitorEvent = public enum (
    MONO_PROFILER_MONITOR_CONTENTION,
    MONO_PROFILER_MONITOR_DONE,
    MONO_PROFILER_MONITOR_FAIL
  );

  mono.metadata.MonoProfilerCallChainStrategy = public enum (
    MONO_PROFILER_CALL_CHAIN_NONE,
    MONO_PROFILER_CALL_CHAIN_NATIVE,
    MONO_PROFILER_CALL_CHAIN_GLIBC,
    MONO_PROFILER_CALL_CHAIN_MANAGED,
    MONO_PROFILER_CALL_CHAIN_INVALID
  );

  mono.metadata.MonoProfileGCHandleEvent = public enum (
    MONO_PROFILER_GC_HANDLE_CREATED,
    MONO_PROFILER_GC_HANDLE_DESTROYED
  );

  mono.metadata.MonoProfileGCRootType = public enum (
    MONO_PROFILE_GC_ROOT_PINNING,
    MONO_PROFILE_GC_ROOT_WEAKREF,
    MONO_PROFILE_GC_ROOT_INTERIOR,
    MONO_PROFILE_GC_ROOT_STACK,
    MONO_PROFILE_GC_ROOT_FINALIZER,
    MONO_PROFILE_GC_ROOT_HANDLE,
    MONO_PROFILE_GC_ROOT_OTHER,
    MONO_PROFILE_GC_ROOT_MISC,
    MONO_PROFILE_GC_ROOT_TYPEMASK
  );

  mono.metadata.MonoProfileFunc = public method (prof: ^MonoProfiler);

  mono.metadata.MonoProfileAppDomainFunc = public method (prof: ^MonoProfiler; domain: ^MonoDomain);

  mono.metadata.MonoProfileMethodFunc = public method (prof: ^MonoProfiler; &method: ^MonoMethod);

  mono.metadata.MonoProfileClassFunc = public method (prof: ^MonoProfiler; klass: ^MonoClass);

  mono.metadata.MonoProfileModuleFunc = public method (prof: ^MonoProfiler; &module: ^MonoImage);

  mono.metadata.MonoProfileAssemblyFunc = public method (prof: ^MonoProfiler; &assembly: ^MonoAssembly);

  mono.metadata.MonoProfileMonitorFunc = public method (prof: ^MonoProfiler; obj: ^mono.metadata.MonoObject; &event: mono.metadata.MonoProfilerMonitorEvent);

  mono.metadata.MonoProfileExceptionFunc = public method (prof: ^MonoProfiler; object: ^mono.metadata.MonoObject);

  mono.metadata.MonoProfileExceptionClauseFunc = public method (prof: ^MonoProfiler; &method: ^MonoMethod; clause_type: Int32; clause_num: Int32);

  mono.metadata.MonoProfileAppDomainResult = public method (prof: ^MonoProfiler; domain: ^MonoDomain; &result: Int32);

  mono.metadata.MonoProfileMethodResult = public method (prof: ^MonoProfiler; &method: ^MonoMethod; &result: Int32);

  mono.metadata.MonoProfileJitResult = public method (prof: ^MonoProfiler; &method: ^MonoMethod; jinfo: ^MonoJitInfo; &result: Int32);

  mono.metadata.MonoProfileClassResult = public method (prof: ^MonoProfiler; klass: ^MonoClass; &result: Int32);

  mono.metadata.MonoProfileModuleResult = public method (prof: ^MonoProfiler; &module: ^MonoImage; &result: Int32);

  mono.metadata.MonoProfileAssemblyResult = public method (prof: ^MonoProfiler; &assembly: ^MonoAssembly; &result: Int32);

  mono.metadata.MonoProfileMethodInline = public method (prof: ^MonoProfiler; parent: ^MonoMethod; child: ^MonoMethod; ok: ^Int32);

  mono.metadata.MonoProfileThreadFunc = public method (prof: ^MonoProfiler; tid: uintptr_t);

  mono.metadata.MonoProfileThreadNameFunc = public method (prof: ^MonoProfiler; tid: uintptr_t; name: ^AnsiChar);

  mono.metadata.MonoProfileAllocFunc = public method (prof: ^MonoProfiler; obj: ^mono.metadata.MonoObject; klass: ^MonoClass);

  mono.metadata.MonoProfileStatFunc = public method (prof: ^MonoProfiler; ip: ^mono_byte; context: ^Void);

  mono.metadata.MonoProfileStatCallChainFunc = public method (prof: ^MonoProfiler; call_chain_depth: Int32; ip: ^^mono_byte; context: ^Void);

  mono.metadata.MonoProfileGCFunc = public method (prof: ^MonoProfiler; &event: mono.metadata.MonoGCEvent; generation: Int32);

  mono.metadata.MonoProfileGCMoveFunc = public method (prof: ^MonoProfiler; objects: ^^Void; num: Int32);

  mono.metadata.MonoProfileGCResizeFunc = public method (prof: ^MonoProfiler; new_size: int64_t);

  mono.metadata.MonoProfileGCHandleFunc = public method (prof: ^MonoProfiler; op: Int32; &type: Int32; handle: uintptr_t; obj: ^mono.metadata.MonoObject);

  mono.metadata.MonoProfileGCRootFunc = public method (prof: ^MonoProfiler; num_roots: Int32; objects: ^^Void; root_types: ^Int32; extra_info: ^uintptr_t);

  mono.metadata.MonoProfileIomapFunc = public method (prof: ^MonoProfiler; report: ^AnsiChar; pathname: ^AnsiChar; new_pathname: ^AnsiChar);

  mono.metadata.MonoProfileCoverageFilterFunc = public method (prof: ^MonoProfiler; &method: ^MonoMethod): mono_bool;

  mono.metadata.MonoProfileCoverageFunc = public method (prof: ^MonoProfiler; entry: ^mono.metadata.MonoProfileCoverageEntry);

  mono.metadata.MonoProfilerCodeChunkNew = public method (prof: ^MonoProfiler; chunk: ^Void; size: Int32);

  mono.metadata.MonoProfilerCodeChunkDestroy = public method (prof: ^MonoProfiler; chunk: ^Void);

  mono.metadata.MonoProfilerCodeBufferNew = public method (prof: ^MonoProfiler; buffer: ^Void; size: Int32; &type: mono.metadata.MonoProfilerCodeBufferType; data: ^Void);

  mono.metadata.MonoProfileSamplingMode = public enum (
    MONO_PROFILER_STAT_MODE_PROCESS,
    MONO_PROFILER_STAT_MODE_REAL
  );

  mono.metadata.MonoThreadManageCallback = public method (thread: ^MonoThread): mono_bool;

  mono.metadata.MonoTokenType = public enum (
    MONO_TOKEN_MODULE,
    MONO_TOKEN_TYPE_REF,
    MONO_TOKEN_TYPE_DEF,
    MONO_TOKEN_FIELD_DEF,
    MONO_TOKEN_METHOD_DEF,
    MONO_TOKEN_PARAM_DEF,
    MONO_TOKEN_INTERFACE_IMPL,
    MONO_TOKEN_MEMBER_REF,
    MONO_TOKEN_CUSTOM_ATTRIBUTE,
    MONO_TOKEN_PERMISSION,
    MONO_TOKEN_SIGNATURE,
    MONO_TOKEN_EVENT,
    MONO_TOKEN_PROPERTY,
    MONO_TOKEN_MODULE_REF,
    MONO_TOKEN_TYPE_SPEC,
    MONO_TOKEN_ASSEMBLY,
    MONO_TOKEN_ASSEMBLY_REF,
    MONO_TOKEN_FILE,
    MONO_TOKEN_EXPORTED_TYPE,
    MONO_TOKEN_MANIFEST_RESOURCE,
    MONO_TOKEN_GENERIC_PARAM,
    MONO_TOKEN_METHOD_SPEC,
    MONO_TOKEN_STRING,
    MONO_TOKEN_NAME,
    MONO_TOKEN_BASE_TYPE
  );

  mono.jit.__Global = public class
  public
    class method mono_jit_init(file: ^AnsiChar): ^MonoDomain;
    class method mono_jit_init_version(root_domain_name: ^AnsiChar; runtime_version: ^AnsiChar): ^MonoDomain;
    class method mono_jit_exec(domain: ^MonoDomain; &assembly: ^MonoAssembly; argc: Int32; argv: ^^AnsiChar): Int32;
    class method mono_jit_cleanup(domain: ^MonoDomain);
    class method mono_jit_set_trace_options(options: ^AnsiChar): mono_bool;
    class method mono_set_signal_chaining(chain_signals: mono_bool);
    class method mono_set_crash_chaining(chain_signals: mono_bool);
    class method mono_jit_set_aot_only(aot_only: mono_bool);
    class method mono_jit_set_aot_mode(mode: mono.jit.MonoAotMode);
    class method mono_set_break_policy(policy_callback: mono.jit.MonoBreakPolicyFunc);
    class method mono_jit_parse_options(argc: Int32; argv: ^^AnsiChar);
    class method mono_get_runtime_build_info: ^AnsiChar;
    class method mono_get_jit_info_from_method(domain: ^MonoDomain; &method: ^MonoMethod): ^MonoJitInfo;
    class method mono_aot_get_method(domain: ^MonoDomain; &method: ^MonoMethod): ^Void;
  end;

  mono.jit.MonoAotMode = public enum (
    MONO_AOT_MODE_NONE,
    MONO_AOT_MODE_NORMAL,
    MONO_AOT_MODE_HYBRID,
    MONO_AOT_MODE_FULL
  );

  mono.jit.MonoBreakPolicy = public enum (
    MONO_BREAK_POLICY_ALWAYS,
    MONO_BREAK_POLICY_NEVER,
    MONO_BREAK_POLICY_ON_DBG
  );

  mono.jit.MonoBreakPolicyFunc = public method (&method: ^MonoMethod): mono.jit.MonoBreakPolicy;

implementation

end.
