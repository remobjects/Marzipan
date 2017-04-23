// Import of libmono-2 ()
// Frameworks: 
// Targets: x86_64
// Dep fx:rtl
// Dep libs:mono-2.0
// Platform: macOS
// 


namespace
{
	using mono_bool = int32_t;

	using mono_byte = uint8_t;

	using mono_unichar2 = uint16_t;

	using mono_unichar4 = uint32_t;

	delegate Void mono.utils.MonoFunc (Void* data, Void* user_data);

	delegate Void mono.utils.MonoHFunc (Void* key, Void* @value, Void* user_data);

	class mono.utils.__Global
	{
		public static Void mono_free(Void* Param0);
		public static mono_bool mono_set_allocator_vtable(mono.utils.MonoAllocatorVTable* vtable);
		public static const Int32 MONO_COUNTER_INT;
		public static const Int32 MONO_COUNTER_UINT;
		public static const Int32 MONO_COUNTER_WORD;
		public static const Int32 MONO_COUNTER_LONG;
		public static const Int32 MONO_COUNTER_ULONG;
		public static const Int32 MONO_COUNTER_DOUBLE;
		public static const Int32 MONO_COUNTER_STRING;
		public static const Int32 MONO_COUNTER_TIME_INTERVAL;
		public static const Int32 MONO_COUNTER_TYPE_MASK;
		public static const Int32 MONO_COUNTER_CALLBACK;
		public static const Int32 MONO_COUNTER_SECTION_MASK;
		public static const Int64 MONO_COUNTER_JIT;
		public static const Int64 MONO_COUNTER_GC;
		public static const Int64 MONO_COUNTER_METADATA;
		public static const Int64 MONO_COUNTER_GENERICS;
		public static const Int64 MONO_COUNTER_SECURITY;
		public static const Int64 MONO_COUNTER_RUNTIME;
		public static const Int64 MONO_COUNTER_SYSTEM;
		public static const Int64 MONO_COUNTER_PERFCOUNTERS;
		public static const Int64 MONO_COUNTER_PROFILER;
		public static const Int32 MONO_COUNTER_LAST_SECTION;
		public static const Int32 MONO_COUNTER_UNIT_SHIFT;
		public static const Int64 MONO_COUNTER_UNIT_MASK;
		public static const Int64 MONO_COUNTER_RAW;
		public static const Int64 MONO_COUNTER_BYTES;
		public static const Int64 MONO_COUNTER_TIME;
		public static const Int64 MONO_COUNTER_COUNT;
		public static const Int64 MONO_COUNTER_PERCENTAGE;
		public static const Int32 MONO_COUNTER_VARIANCE_SHIFT;
		public static const Int64 MONO_COUNTER_VARIANCE_MASK;
		public static const Int64 MONO_COUNTER_MONOTONIC;
		public static const Int64 MONO_COUNTER_CONSTANT;
		public static const Int64 MONO_COUNTER_VARIABLE;
		public static Void mono_counters_enable(Int32 section_mask);
		public static Void mono_counters_init();
		public static Void mono_counters_register(AnsiChar* descr, Int32 type, Void* addr);
		public static Void mono_counters_register_with_size(AnsiChar* name, Int32 type, Void* addr, Int32 size);
		public static Void mono_counters_on_register([FunctionPointer] delegate Void (MonoCounter* Param0) callback);
		public static Void mono_counters_dump(Int32 section_mask, FILE* outfile);
		public static Void mono_counters_cleanup();
		public static Void mono_counters_foreach([FunctionPointer] delegate mono_bool (MonoCounter* counter, Void* user_data) cb, Void* user_data);
		public static Int32 mono_counters_sample(MonoCounter* counter, Void* buffer, Int32 buffer_size);
		public static AnsiChar* mono_counter_get_name(MonoCounter* name);
		public static Int32 mono_counter_get_type(MonoCounter* counter);
		public static Int32 mono_counter_get_section(MonoCounter* counter);
		public static Int32 mono_counter_get_unit(MonoCounter* counter);
		public static Int32 mono_counter_get_variance(MonoCounter* counter);
		public static size_t mono_counter_get_size(MonoCounter* counter);
		public static Int32 mono_runtime_resource_limit(Int32 resource_type, uintptr_t soft_limit, uintptr_t hard_limit);
		public static Void mono_runtime_resource_set_callback([FunctionPointer] delegate Void (Int32 resource_type, uintptr_t @value, Int32 is_soft) callback);
		public static Void mono_runtime_resource_check_limit(Int32 resource_type, uintptr_t @value);
		public static const Int32 MONO_DL_EAGER;
		public static const Int32 MONO_DL_LAZY;
		public static const Int32 MONO_DL_LOCAL;
		public static const Int32 MONO_DL_MASK;
		public static MonoDlFallbackHandler* mono_dl_fallback_register([FunctionPointer] delegate Void* (AnsiChar* name, Int32 flags, AnsiChar** err, Void* user_data) load_func, [FunctionPointer] delegate Void* (Void* handle, AnsiChar* name, AnsiChar** err, Void* user_data) symbol_func, [FunctionPointer] delegate Void* (Void* handle, Void* user_data) close_func, Void* user_data);
		public static Void mono_dl_fallback_unregister(MonoDlFallbackHandler* handler);
		public static const Int32 MONO_ERROR_FREE_STRINGS;
		public static const Int32 MONO_ERROR_INCOMPLETE;
		public static const Int32 MONO_ERROR_NONE;
		public static const Int32 MONO_ERROR_MISSING_METHOD;
		public static const Int32 MONO_ERROR_MISSING_FIELD;
		public static const Int32 MONO_ERROR_TYPE_LOAD;
		public static const Int32 MONO_ERROR_FILE_NOT_FOUND;
		public static const Int32 MONO_ERROR_BAD_IMAGE;
		public static const Int32 MONO_ERROR_OUT_OF_MEMORY;
		public static const Int32 MONO_ERROR_ARGUMENT;
		public static const Int32 MONO_ERROR_ARGUMENT_NULL;
		public static const Int32 MONO_ERROR_NOT_VERIFIABLE;
		public static const Int32 MONO_ERROR_INVALID_PROGRAM;
		public static const Int32 MONO_ERROR_GENERIC;
		public static const Int32 MONO_ERROR_EXCEPTION_INSTANCE;
		public static const Int32 MONO_ERROR_CLEANUP_CALLED_SENTINEL;
		public static Void mono_error_init(mono.utils.MonoError* error);
		public static Void mono_error_init_flags(mono.utils.MonoError* error, UInt16 flags);
		public static Void mono_error_cleanup(mono.utils.MonoError* error);
		public static mono_bool mono_error_ok(mono.utils.MonoError* error);
		public static UInt16 mono_error_get_error_code(mono.utils.MonoError* error);
		public static AnsiChar* mono_error_get_message(mono.utils.MonoError* error);
		public static Void mono_trace_set_level_string(AnsiChar* @value);
		public static Void mono_trace_set_mask_string(AnsiChar* @value);
		public static Void mono_trace_set_log_handler([FunctionPointer] delegate Void (AnsiChar* log_domain, AnsiChar* log_level, AnsiChar* message, mono_bool fatal, Void* user_data) callback, Void* user_data);
		public static Void mono_trace_set_print_handler([FunctionPointer] delegate Void (AnsiChar* @string, mono_bool is_stdout) callback);
		public static Void mono_trace_set_printerr_handler([FunctionPointer] delegate Void (AnsiChar* @string, mono_bool is_stdout) callback);
		public static const Int32 MONO_ALLOCATOR_VTABLE_VERSION;
		public static const Int32 MONO_ZERO_LEN_ARRAY;
	}

	struct mono.utils.MonoAllocatorVTable
	{
		public Int32 version;
		public [FunctionPointer] delegate Void* (size_t size) malloc;
		public [FunctionPointer] delegate Void* (Void* mem, size_t count) realloc;
		public [FunctionPointer] delegate Void (Void* mem) free;
		public [FunctionPointer] delegate Void* (size_t count, size_t size) calloc;
	}

	using MonoCounter = Void;

	delegate Void mono.utils.MonoCounterRegisterCallback (MonoCounter* Param0);

	delegate mono_bool mono.utils.CountersEnumCallback (MonoCounter* counter, Void* user_data);

	enum mono.utils.MonoResourceType
	{
		MONO_RESOURCE_JIT_CODE = 0,
		MONO_RESOURCE_METADATA = 1,
		MONO_RESOURCE_GC_HEAP = 2,
		MONO_RESOURCE_COUNT = 3
	}

	delegate Void mono.utils.MonoResourceCallback (Int32 resource_type, uintptr_t @value, Int32 is_soft);

	using MonoDlFallbackHandler = Void;

	delegate Void* mono.utils.MonoDlFallbackLoad (AnsiChar* name, Int32 flags, AnsiChar** err, Void* user_data);

	delegate Void* mono.utils.MonoDlFallbackSymbol (Void* handle, AnsiChar* name, AnsiChar** err, Void* user_data);

	delegate Void* mono.utils.MonoDlFallbackClose (Void* handle, Void* user_data);

	struct mono.utils.MonoError
	{
		public UInt16 error_code;
		public UInt16 hidden_0;
		public Void*[] hidden_1;
	}

	struct mono.utils.MonoError
	{
		public UInt16 error_code;
		public UInt16 hidden_0;
		public Void*[] hidden_1;
	}

	delegate Void mono.utils.MonoPrintCallback (AnsiChar* @string, mono_bool is_stdout);

	delegate Void mono.utils.MonoLogCallback (AnsiChar* log_domain, AnsiChar* log_level, AnsiChar* message, mono_bool fatal, Void* user_data);

	enum mono.metadata.MonoTypeEnum
	{
		MONO_TYPE_END = 0,
		MONO_TYPE_VOID = 1,
		MONO_TYPE_BOOLEAN = 2,
		MONO_TYPE_CHAR = 3,
		MONO_TYPE_I1 = 4,
		MONO_TYPE_U1 = 5,
		MONO_TYPE_I2 = 6,
		MONO_TYPE_U2 = 7,
		MONO_TYPE_I4 = 33,
		MONO_TYPE_U4 = 35,
		MONO_TYPE_I8 = 36,
		MONO_TYPE_U8 = 32,
		MONO_TYPE_R4 = 34,
		MONO_TYPE_R8 = 38,
		MONO_TYPE_STRING = 39,
		MONO_TYPE_PTR = 8,
		MONO_TYPE_BYREF = 40,
		MONO_TYPE_VALUETYPE = 41,
		MONO_TYPE_CLASS = 42,
		MONO_TYPE_VAR = 43,
		MONO_TYPE_ARRAY = 44,
		MONO_TYPE_GENERICINST = 45,
		MONO_TYPE_TYPEDBYREF = 46,
		MONO_TYPE_I = 21,
		MONO_TYPE_U = 47,
		MONO_TYPE_FNPTR = 48,
		MONO_TYPE_OBJECT = 27,
		MONO_TYPE_SZARRAY = 49,
		MONO_TYPE_MVAR = 50,
		MONO_TYPE_CMOD_REQD = 51,
		MONO_TYPE_CMOD_OPT = 52,
		MONO_TYPE_INTERNAL = 53,
		MONO_TYPE_MODIFIER = 54,
		MONO_TYPE_SENTINEL = 55,
		MONO_TYPE_PINNED = 56,
		MONO_TYPE_ENUM = 57
	}

	enum mono.metadata.MonoMetaTableEnum
	{
		MONO_TABLE_MODULE = 0,
		MONO_TABLE_TYPEREF = 1,
		MONO_TABLE_TYPEDEF = 2,
		MONO_TABLE_FIELD_POINTER = 3,
		MONO_TABLE_FIELD = 4,
		MONO_TABLE_METHOD_POINTER = 5,
		MONO_TABLE_METHOD = 6,
		MONO_TABLE_PARAM_POINTER = 7,
		MONO_TABLE_PARAM = 33,
		MONO_TABLE_INTERFACEIMPL = 35,
		MONO_TABLE_MEMBERREF = 36,
		MONO_TABLE_CONSTANT = 32,
		MONO_TABLE_CUSTOMATTRIBUTE = 34,
		MONO_TABLE_FIELDMARSHAL = 38,
		MONO_TABLE_DECLSECURITY = 39,
		MONO_TABLE_CLASSLAYOUT = 8,
		MONO_TABLE_FIELDLAYOUT = 40,
		MONO_TABLE_STANDALONESIG = 41,
		MONO_TABLE_EVENTMAP = 42,
		MONO_TABLE_EVENT_POINTER = 43,
		MONO_TABLE_EVENT = 44,
		MONO_TABLE_PROPERTYMAP = 45,
		MONO_TABLE_PROPERTY_POINTER = 46,
		MONO_TABLE_PROPERTY = 58,
		MONO_TABLE_METHODSEMANTICS = 21,
		MONO_TABLE_METHODIMPL = 47,
		MONO_TABLE_MODULEREF = 59,
		MONO_TABLE_TYPESPEC = 48,
		MONO_TABLE_IMPLMAP = 27,
		MONO_TABLE_FIELDRVA = 49,
		MONO_TABLE_UNUSED6 = 50,
		MONO_TABLE_UNUSED7 = 51,
		MONO_TABLE_ASSEMBLY = 52,
		MONO_TABLE_ASSEMBLYPROCESSOR = 53,
		MONO_TABLE_ASSEMBLYOS = 60,
		MONO_TABLE_ASSEMBLYREF = 61,
		MONO_TABLE_ASSEMBLYREFPROCESSOR = 62,
		MONO_TABLE_ASSEMBLYREFOS = 63,
		MONO_TABLE_FILE = 64,
		MONO_TABLE_EXPORTEDTYPE = 65,
		MONO_TABLE_MANIFESTRESOURCE = 66,
		MONO_TABLE_NESTEDCLASS = 67,
		MONO_TABLE_GENERICPARAM = 68,
		MONO_TABLE_METHODSPEC = 69,
		MONO_TABLE_GENERICPARAMCONSTRAINT = 70,
		MONO_TABLE_UNUSED8 = 71,
		MONO_TABLE_UNUSED9 = 72,
		MONO_TABLE_UNUSED10 = 73,
		MONO_TABLE_DOCUMENT = 74,
		MONO_TABLE_METHODBODY = 75,
		MONO_TABLE_LOCALSCOPE = 76,
		MONO_TABLE_LOCALVARIABLE = 77,
		MONO_TABLE_LOCALCONSTANT = 78,
		MONO_TABLE_IMPORTSCOPE = 79,
		MONO_TABLE_ASYNCMETHOD = 80,
		MONO_TABLE_CUSTOMDEBUGINFORMATION = 81
	}

	class mono.metadata.__Global
	{
		public static const Int32 MONO_ASSEMBLY_HASH_ALG;
		public static const Int32 MONO_ASSEMBLY_MAJOR_VERSION;
		public static const Int32 MONO_ASSEMBLY_MINOR_VERSION;
		public static const Int32 MONO_ASSEMBLY_BUILD_NUMBER;
		public static const Int32 MONO_ASSEMBLY_REV_NUMBER;
		public static const Int32 MONO_ASSEMBLY_FLAGS;
		public static const Int32 MONO_ASSEMBLY_PUBLIC_KEY;
		public static const Int32 MONO_ASSEMBLY_NAME;
		public static const Int32 MONO_ASSEMBLY_CULTURE;
		public static const Int32 MONO_ASSEMBLY_SIZE;
		public static const Int32 MONO_ASSEMBLYOS_PLATFORM;
		public static const Int32 MONO_ASSEMBLYOS_MAJOR_VERSION;
		public static const Int32 MONO_ASSEMBLYOS_MINOR_VERSION;
		public static const Int32 MONO_ASSEMBLYOS_SIZE;
		public static const Int32 MONO_ASSEMBLY_PROCESSOR;
		public static const Int32 MONO_ASSEMBLY_PROCESSOR_SIZE;
		public static const Int32 MONO_ASSEMBLYREF_MAJOR_VERSION;
		public static const Int32 MONO_ASSEMBLYREF_MINOR_VERSION;
		public static const Int32 MONO_ASSEMBLYREF_BUILD_NUMBER;
		public static const Int32 MONO_ASSEMBLYREF_REV_NUMBER;
		public static const Int32 MONO_ASSEMBLYREF_FLAGS;
		public static const Int32 MONO_ASSEMBLYREF_PUBLIC_KEY;
		public static const Int32 MONO_ASSEMBLYREF_NAME;
		public static const Int32 MONO_ASSEMBLYREF_CULTURE;
		public static const Int32 MONO_ASSEMBLYREF_HASH_VALUE;
		public static const Int32 MONO_ASSEMBLYREF_SIZE;
		public static const Int32 MONO_ASSEMBLYREFOS_PLATFORM;
		public static const Int32 MONO_ASSEMBLYREFOS_MAJOR_VERSION;
		public static const Int32 MONO_ASSEMBLYREFOS_MINOR_VERSION;
		public static const Int32 MONO_ASSEMBLYREFOS_ASSEMBLYREF;
		public static const Int32 MONO_ASSEMBLYREFOS_SIZE;
		public static const Int32 MONO_ASSEMBLYREFPROC_PROCESSOR;
		public static const Int32 MONO_ASSEMBLYREFPROC_ASSEMBLYREF;
		public static const Int32 MONO_ASSEMBLYREFPROC_SIZE;
		public static const Int32 MONO_CLASS_LAYOUT_PACKING_SIZE;
		public static const Int32 MONO_CLASS_LAYOUT_CLASS_SIZE;
		public static const Int32 MONO_CLASS_LAYOUT_PARENT;
		public static const Int32 MONO_CLASS_LAYOUT_SIZE;
		public static const Int32 MONO_CONSTANT_TYPE;
		public static const Int32 MONO_CONSTANT_PADDING;
		public static const Int32 MONO_CONSTANT_PARENT;
		public static const Int32 MONO_CONSTANT_VALUE;
		public static const Int32 MONO_CONSTANT_SIZE;
		public static const Int32 MONO_CUSTOM_ATTR_PARENT;
		public static const Int32 MONO_CUSTOM_ATTR_TYPE;
		public static const Int32 MONO_CUSTOM_ATTR_VALUE;
		public static const Int32 MONO_CUSTOM_ATTR_SIZE;
		public static const Int32 MONO_DECL_SECURITY_ACTION;
		public static const Int32 MONO_DECL_SECURITY_PARENT;
		public static const Int32 MONO_DECL_SECURITY_PERMISSIONSET;
		public static const Int32 MONO_DECL_SECURITY_SIZE;
		public static const Int32 MONO_EVENT_MAP_PARENT;
		public static const Int32 MONO_EVENT_MAP_EVENTLIST;
		public static const Int32 MONO_EVENT_MAP_SIZE;
		public static const Int32 MONO_EVENT_FLAGS;
		public static const Int32 MONO_EVENT_NAME;
		public static const Int32 MONO_EVENT_TYPE;
		public static const Int32 MONO_EVENT_SIZE;
		public static const Int32 MONO_EVENT_POINTER_EVENT;
		public static const Int32 MONO_EVENT_POINTER_SIZE;
		public static const Int32 MONO_EXP_TYPE_FLAGS;
		public static const Int32 MONO_EXP_TYPE_TYPEDEF;
		public static const Int32 MONO_EXP_TYPE_NAME;
		public static const Int32 MONO_EXP_TYPE_NAMESPACE;
		public static const Int32 MONO_EXP_TYPE_IMPLEMENTATION;
		public static const Int32 MONO_EXP_TYPE_SIZE;
		public static const Int32 MONO_FIELD_FLAGS;
		public static const Int32 MONO_FIELD_NAME;
		public static const Int32 MONO_FIELD_SIGNATURE;
		public static const Int32 MONO_FIELD_SIZE;
		public static const Int32 MONO_FIELD_LAYOUT_OFFSET;
		public static const Int32 MONO_FIELD_LAYOUT_FIELD;
		public static const Int32 MONO_FIELD_LAYOUT_SIZE;
		public static const Int32 MONO_FIELD_MARSHAL_PARENT;
		public static const Int32 MONO_FIELD_MARSHAL_NATIVE_TYPE;
		public static const Int32 MONO_FIELD_MARSHAL_SIZE;
		public static const Int32 MONO_FIELD_POINTER_FIELD;
		public static const Int32 MONO_FIELD_POINTER_SIZE;
		public static const Int32 MONO_FIELD_RVA_RVA;
		public static const Int32 MONO_FIELD_RVA_FIELD;
		public static const Int32 MONO_FIELD_RVA_SIZE;
		public static const Int32 MONO_FILE_FLAGS;
		public static const Int32 MONO_FILE_NAME;
		public static const Int32 MONO_FILE_HASH_VALUE;
		public static const Int32 MONO_FILE_SIZE;
		public static const Int32 MONO_IMPLMAP_FLAGS;
		public static const Int32 MONO_IMPLMAP_MEMBER;
		public static const Int32 MONO_IMPLMAP_NAME;
		public static const Int32 MONO_IMPLMAP_SCOPE;
		public static const Int32 MONO_IMPLMAP_SIZE;
		public static const Int32 MONO_INTERFACEIMPL_CLASS;
		public static const Int32 MONO_INTERFACEIMPL_INTERFACE;
		public static const Int32 MONO_INTERFACEIMPL_SIZE;
		public static const Int32 MONO_MANIFEST_OFFSET;
		public static const Int32 MONO_MANIFEST_FLAGS;
		public static const Int32 MONO_MANIFEST_NAME;
		public static const Int32 MONO_MANIFEST_IMPLEMENTATION;
		public static const Int32 MONO_MANIFEST_SIZE;
		public static const Int32 MONO_MEMBERREF_CLASS;
		public static const Int32 MONO_MEMBERREF_NAME;
		public static const Int32 MONO_MEMBERREF_SIGNATURE;
		public static const Int32 MONO_MEMBERREF_SIZE;
		public static const Int32 MONO_METHOD_RVA;
		public static const Int32 MONO_METHOD_IMPLFLAGS;
		public static const Int32 MONO_METHOD_FLAGS;
		public static const Int32 MONO_METHOD_NAME;
		public static const Int32 MONO_METHOD_SIGNATURE;
		public static const Int32 MONO_METHOD_PARAMLIST;
		public static const Int32 MONO_METHOD_SIZE;
		public static const Int32 MONO_METHODIMPL_CLASS;
		public static const Int32 MONO_METHODIMPL_BODY;
		public static const Int32 MONO_METHODIMPL_DECLARATION;
		public static const Int32 MONO_METHODIMPL_SIZE;
		public static const Int32 MONO_METHOD_POINTER_METHOD;
		public static const Int32 MONO_METHOD_POINTER_SIZE;
		public static const Int32 MONO_METHOD_SEMA_SEMANTICS;
		public static const Int32 MONO_METHOD_SEMA_METHOD;
		public static const Int32 MONO_METHOD_SEMA_ASSOCIATION;
		public static const Int32 MONO_METHOD_SEMA_SIZE;
		public static const Int32 MONO_MODULE_GENERATION;
		public static const Int32 MONO_MODULE_NAME;
		public static const Int32 MONO_MODULE_MVID;
		public static const Int32 MONO_MODULE_ENC;
		public static const Int32 MONO_MODULE_ENCBASE;
		public static const Int32 MONO_MODULE_SIZE;
		public static const Int32 MONO_MODULEREF_NAME;
		public static const Int32 MONO_MODULEREF_SIZE;
		public static const Int32 MONO_NESTED_CLASS_NESTED;
		public static const Int32 MONO_NESTED_CLASS_ENCLOSING;
		public static const Int32 MONO_NESTED_CLASS_SIZE;
		public static const Int32 MONO_PARAM_FLAGS;
		public static const Int32 MONO_PARAM_SEQUENCE;
		public static const Int32 MONO_PARAM_NAME;
		public static const Int32 MONO_PARAM_SIZE;
		public static const Int32 MONO_PARAM_POINTER_PARAM;
		public static const Int32 MONO_PARAM_POINTER_SIZE;
		public static const Int32 MONO_PROPERTY_FLAGS;
		public static const Int32 MONO_PROPERTY_NAME;
		public static const Int32 MONO_PROPERTY_TYPE;
		public static const Int32 MONO_PROPERTY_SIZE;
		public static const Int32 MONO_PROPERTY_POINTER_PROPERTY;
		public static const Int32 MONO_PROPERTY_POINTER_SIZE;
		public static const Int32 MONO_PROPERTY_MAP_PARENT;
		public static const Int32 MONO_PROPERTY_MAP_PROPERTY_LIST;
		public static const Int32 MONO_PROPERTY_MAP_SIZE;
		public static const Int32 MONO_STAND_ALONE_SIGNATURE;
		public static const Int32 MONO_STAND_ALONE_SIGNATURE_SIZE;
		public static const Int32 MONO_TYPEDEF_FLAGS;
		public static const Int32 MONO_TYPEDEF_NAME;
		public static const Int32 MONO_TYPEDEF_NAMESPACE;
		public static const Int32 MONO_TYPEDEF_EXTENDS;
		public static const Int32 MONO_TYPEDEF_FIELD_LIST;
		public static const Int32 MONO_TYPEDEF_METHOD_LIST;
		public static const Int32 MONO_TYPEDEF_SIZE;
		public static const Int32 MONO_TYPEREF_SCOPE;
		public static const Int32 MONO_TYPEREF_NAME;
		public static const Int32 MONO_TYPEREF_NAMESPACE;
		public static const Int32 MONO_TYPEREF_SIZE;
		public static const Int32 MONO_TYPESPEC_SIGNATURE;
		public static const Int32 MONO_TYPESPEC_SIZE;
		public static const Int32 MONO_GENERICPARAM_NUMBER;
		public static const Int32 MONO_GENERICPARAM_FLAGS;
		public static const Int32 MONO_GENERICPARAM_OWNER;
		public static const Int32 MONO_GENERICPARAM_NAME;
		public static const Int32 MONO_GENERICPARAM_SIZE;
		public static const Int32 MONO_METHODSPEC_METHOD;
		public static const Int32 MONO_METHODSPEC_SIGNATURE;
		public static const Int32 MONO_METHODSPEC_SIZE;
		public static const Int32 MONO_GENPARCONSTRAINT_GENERICPAR;
		public static const Int32 MONO_GENPARCONSTRAINT_CONSTRAINT;
		public static const Int32 MONO_GENPARCONSTRAINT_SIZE;
		public static const Int32 MONO_DOCUMENT_NAME;
		public static const Int32 MONO_DOCUMENT_HASHALG;
		public static const Int32 MONO_DOCUMENT_HASH;
		public static const Int32 MONO_DOCUMENT_LANGUAGE;
		public static const Int32 MONO_DOCUMENT_SIZE;
		public static const Int32 MONO_METHODBODY_DOCUMENT;
		public static const Int32 MONO_METHODBODY_SEQ_POINTS;
		public static const Int32 MONO_METHODBODY_SIZE;
		public static const Int32 MONO_LOCALSCOPE_METHOD;
		public static const Int32 MONO_LOCALSCOPE_IMPORTSCOPE;
		public static const Int32 MONO_LOCALSCOPE_VARIABLELIST;
		public static const Int32 MONO_LOCALSCOPE_CONSTANTLIST;
		public static const Int32 MONO_LOCALSCOPE_STARTOFFSET;
		public static const Int32 MONO_LOCALSCOPE_LENGTH;
		public static const Int32 MONO_LOCALSCOPE_SIZE;
		public static const Int32 MONO_LOCALVARIABLE_ATTRIBUTES;
		public static const Int32 MONO_LOCALVARIABLE_INDEX;
		public static const Int32 MONO_LOCALVARIABLE_NAME;
		public static const Int32 MONO_LOCALVARIABLE_SIZE;
		public static const Int32 MONO_TYPEDEFORREF_TYPEDEF;
		public static const Int32 MONO_TYPEDEFORREF_TYPEREF;
		public static const Int32 MONO_TYPEDEFORREF_TYPESPEC;
		public static const Int32 MONO_TYPEDEFORREF_BITS;
		public static const Int32 MONO_TYPEDEFORREF_MASK;
		public static const Int32 MONO_HASCONSTANT_FIEDDEF;
		public static const Int32 MONO_HASCONSTANT_PARAM;
		public static const Int32 MONO_HASCONSTANT_PROPERTY;
		public static const Int32 MONO_HASCONSTANT_BITS;
		public static const Int32 MONO_HASCONSTANT_MASK;
		public static const Int32 MONO_CUSTOM_ATTR_METHODDEF;
		public static const Int32 MONO_CUSTOM_ATTR_FIELDDEF;
		public static const Int32 MONO_CUSTOM_ATTR_TYPEREF;
		public static const Int32 MONO_CUSTOM_ATTR_TYPEDEF;
		public static const Int32 MONO_CUSTOM_ATTR_PARAMDEF;
		public static const Int32 MONO_CUSTOM_ATTR_INTERFACE;
		public static const Int32 MONO_CUSTOM_ATTR_MEMBERREF;
		public static const Int32 MONO_CUSTOM_ATTR_MODULE;
		public static const Int32 MONO_CUSTOM_ATTR_PERMISSION;
		public static const Int32 MONO_CUSTOM_ATTR_PROPERTY;
		public static const Int32 MONO_CUSTOM_ATTR_EVENT;
		public static const Int32 MONO_CUSTOM_ATTR_SIGNATURE;
		public static const Int32 MONO_CUSTOM_ATTR_MODULEREF;
		public static const Int32 MONO_CUSTOM_ATTR_TYPESPEC;
		public static const Int32 MONO_CUSTOM_ATTR_ASSEMBLY;
		public static const Int32 MONO_CUSTOM_ATTR_ASSEMBLYREF;
		public static const Int32 MONO_CUSTOM_ATTR_FILE;
		public static const Int32 MONO_CUSTOM_ATTR_EXP_TYPE;
		public static const Int32 MONO_CUSTOM_ATTR_MANIFEST;
		public static const Int32 MONO_CUSTOM_ATTR_GENERICPAR;
		public static const Int32 MONO_CUSTOM_ATTR_BITS;
		public static const Int32 MONO_CUSTOM_ATTR_MASK;
		public static const Int32 MONO_HAS_FIELD_MARSHAL_FIELDSREF;
		public static const Int32 MONO_HAS_FIELD_MARSHAL_PARAMDEF;
		public static const Int32 MONO_HAS_FIELD_MARSHAL_BITS;
		public static const Int32 MONO_HAS_FIELD_MARSHAL_MASK;
		public static const Int32 MONO_HAS_DECL_SECURITY_TYPEDEF;
		public static const Int32 MONO_HAS_DECL_SECURITY_METHODDEF;
		public static const Int32 MONO_HAS_DECL_SECURITY_ASSEMBLY;
		public static const Int32 MONO_HAS_DECL_SECURITY_BITS;
		public static const Int32 MONO_HAS_DECL_SECURITY_MASK;
		public static const Int32 MONO_MEMBERREF_PARENT_TYPEDEF;
		public static const Int32 MONO_MEMBERREF_PARENT_TYPEREF;
		public static const Int32 MONO_MEMBERREF_PARENT_MODULEREF;
		public static const Int32 MONO_MEMBERREF_PARENT_METHODDEF;
		public static const Int32 MONO_MEMBERREF_PARENT_TYPESPEC;
		public static const Int32 MONO_MEMBERREF_PARENT_BITS;
		public static const Int32 MONO_MEMBERREF_PARENT_MASK;
		public static const Int32 MONO_HAS_SEMANTICS_EVENT;
		public static const Int32 MONO_HAS_SEMANTICS_PROPERTY;
		public static const Int32 MONO_HAS_SEMANTICS_BITS;
		public static const Int32 MONO_HAS_SEMANTICS_MASK;
		public static const Int32 MONO_METHODDEFORREF_METHODDEF;
		public static const Int32 MONO_METHODDEFORREF_METHODREF;
		public static const Int32 MONO_METHODDEFORREF_BITS;
		public static const Int32 MONO_METHODDEFORREF_MASK;
		public static const Int32 MONO_MEMBERFORWD_FIELDDEF;
		public static const Int32 MONO_MEMBERFORWD_METHODDEF;
		public static const Int32 MONO_MEMBERFORWD_BITS;
		public static const Int32 MONO_MEMBERFORWD_MASK;
		public static const Int32 MONO_IMPLEMENTATION_FILE;
		public static const Int32 MONO_IMPLEMENTATION_ASSEMBLYREF;
		public static const Int32 MONO_IMPLEMENTATION_EXP_TYPE;
		public static const Int32 MONO_IMPLEMENTATION_BITS;
		public static const Int32 MONO_IMPLEMENTATION_MASK;
		public static const Int32 MONO_CUSTOM_ATTR_TYPE_TYPEREF;
		public static const Int32 MONO_CUSTOM_ATTR_TYPE_TYPEDEF;
		public static const Int32 MONO_CUSTOM_ATTR_TYPE_METHODDEF;
		public static const Int32 MONO_CUSTOM_ATTR_TYPE_MEMBERREF;
		public static const Int32 MONO_CUSTOM_ATTR_TYPE_STRING;
		public static const Int32 MONO_CUSTOM_ATTR_TYPE_BITS;
		public static const Int32 MONO_CUSTOM_ATTR_TYPE_MASK;
		public static const Int32 MONO_RESOLUTION_SCOPE_MODULE;
		public static const Int32 MONO_RESOLUTION_SCOPE_MODULEREF;
		public static const Int32 MONO_RESOLUTION_SCOPE_ASSEMBLYREF;
		public static const Int32 MONO_RESOLUTION_SCOPE_TYPEREF;
		public static const Int32 MONO_RESOLUTION_SCOPE_BITS;
		public static const Int32 MONO_RESOLUTION_SCOPE_MASK;
		public static const Int32 MONO_RESOLTION_SCOPE_MODULE;
		public static const Int32 MONO_RESOLTION_SCOPE_MODULEREF;
		public static const Int32 MONO_RESOLTION_SCOPE_ASSEMBLYREF;
		public static const Int32 MONO_RESOLTION_SCOPE_TYPEREF;
		public static const Int32 MONO_RESOLTION_SCOPE_BITS;
		public static const Int32 MONO_RESOLTION_SCOPE_MASK;
		public static const Int32 MONO_TYPEORMETHOD_TYPE;
		public static const Int32 MONO_TYPEORMETHOD_METHOD;
		public static const Int32 MONO_TYPEORMETHOD_BITS;
		public static const Int32 MONO_TYPEORMETHOD_MASK;
		public static Void mono_images_init();
		public static Void mono_images_cleanup();
		public static MonoImage* mono_image_open(AnsiChar* fname, mono.metadata.MonoImageOpenStatus* status);
		public static MonoImage* mono_image_open_full(AnsiChar* fname, mono.metadata.MonoImageOpenStatus* status, mono_bool refonly);
		public static MonoImage* mono_pe_file_open(AnsiChar* fname, mono.metadata.MonoImageOpenStatus* status);
		public static MonoImage* mono_image_open_from_data(AnsiChar* data, uint32_t data_len, mono_bool need_copy, mono.metadata.MonoImageOpenStatus* status);
		public static MonoImage* mono_image_open_from_data_full(AnsiChar* data, uint32_t data_len, mono_bool need_copy, mono.metadata.MonoImageOpenStatus* status, mono_bool refonly);
		public static MonoImage* mono_image_open_from_data_with_name(AnsiChar* data, uint32_t data_len, mono_bool need_copy, mono.metadata.MonoImageOpenStatus* status, mono_bool refonly, AnsiChar* name);
		public static Void mono_image_fixup_vtable(MonoImage* image);
		public static MonoImage* mono_image_loaded(AnsiChar* name);
		public static MonoImage* mono_image_loaded_full(AnsiChar* name, mono_bool refonly);
		public static MonoImage* mono_image_loaded_by_guid(AnsiChar* guid);
		public static MonoImage* mono_image_loaded_by_guid_full(AnsiChar* guid, mono_bool refonly);
		public static Void mono_image_init(MonoImage* image);
		public static Void mono_image_close(MonoImage* image);
		public static Void mono_image_addref(MonoImage* image);
		public static AnsiChar* mono_image_strerror(mono.metadata.MonoImageOpenStatus status);
		public static Int32 mono_image_ensure_section(MonoImage* image, AnsiChar* section);
		public static Int32 mono_image_ensure_section_idx(MonoImage* image, Int32 section);
		public static uint32_t mono_image_get_entry_point(MonoImage* image);
		public static AnsiChar* mono_image_get_resource(MonoImage* image, uint32_t offset, uint32_t* size);
		public static MonoImage* mono_image_load_file_for_image(MonoImage* image, Int32 fileidx);
		public static MonoImage* mono_image_load_module(MonoImage* image, Int32 idx);
		public static AnsiChar* mono_image_get_name(MonoImage* image);
		public static AnsiChar* mono_image_get_filename(MonoImage* image);
		public static AnsiChar* mono_image_get_guid(MonoImage* image);
		public static MonoAssembly* mono_image_get_assembly(MonoImage* image);
		public static mono_bool mono_image_is_dynamic(MonoImage* image);
		public static AnsiChar* mono_image_rva_map(MonoImage* image, uint32_t rva);
		public static MonoTableInfo* mono_image_get_table_info(MonoImage* image, Int32 table_id);
		public static Int32 mono_image_get_table_rows(MonoImage* image, Int32 table_id);
		public static Int32 mono_table_info_get_rows(MonoTableInfo* table);
		public static Void* mono_image_lookup_resource(MonoImage* image, uint32_t res_id, uint32_t lang_id, mono_unichar2* name);
		public static AnsiChar* mono_image_get_public_key(MonoImage* image, uint32_t* size);
		public static AnsiChar* mono_image_get_strong_name(MonoImage* image, uint32_t* size);
		public static uint32_t mono_image_strong_name_position(MonoImage* image, uint32_t* size);
		public static Void mono_image_add_to_name_cache(MonoImage* image, AnsiChar* nspace, AnsiChar* name, uint32_t idx);
		public static mono_bool mono_image_has_authenticode_entry(MonoImage* image);
		public static Void mono_metadata_init();
		public static Void mono_metadata_decode_row(MonoTableInfo* t, Int32 idx, uint32_t* res, Int32 res_size);
		public static uint32_t mono_metadata_decode_row_col(MonoTableInfo* t, Int32 idx, UInt32 col);
		public static Int32 mono_metadata_compute_size(MonoImage* meta, Int32 tableindex, uint32_t* result_bitfield);
		public static AnsiChar* mono_metadata_locate(MonoImage* meta, Int32 table, Int32 idx);
		public static AnsiChar* mono_metadata_locate_token(MonoImage* meta, uint32_t token);
		public static AnsiChar* mono_metadata_string_heap(MonoImage* meta, uint32_t table_index);
		public static AnsiChar* mono_metadata_blob_heap(MonoImage* meta, uint32_t table_index);
		public static AnsiChar* mono_metadata_user_string(MonoImage* meta, uint32_t table_index);
		public static AnsiChar* mono_metadata_guid_heap(MonoImage* meta, uint32_t table_index);
		public static uint32_t mono_metadata_typedef_from_field(MonoImage* meta, uint32_t table_index);
		public static uint32_t mono_metadata_typedef_from_method(MonoImage* meta, uint32_t table_index);
		public static uint32_t mono_metadata_nested_in_typedef(MonoImage* meta, uint32_t table_index);
		public static uint32_t mono_metadata_nesting_typedef(MonoImage* meta, uint32_t table_index, uint32_t start_index);
		public static MonoClass** mono_metadata_interfaces_from_typedef(MonoImage* meta, uint32_t table_index, UInt32* count);
		public static uint32_t mono_metadata_events_from_typedef(MonoImage* meta, uint32_t table_index, UInt32* end_idx);
		public static uint32_t mono_metadata_methods_from_event(MonoImage* meta, uint32_t table_index, UInt32* end);
		public static uint32_t mono_metadata_properties_from_typedef(MonoImage* meta, uint32_t table_index, UInt32* end);
		public static uint32_t mono_metadata_methods_from_property(MonoImage* meta, uint32_t table_index, UInt32* end);
		public static uint32_t mono_metadata_packing_from_typedef(MonoImage* meta, uint32_t table_index, uint32_t* packing, uint32_t* size);
		public static AnsiChar* mono_metadata_get_marshal_info(MonoImage* meta, uint32_t idx, mono_bool is_field);
		public static uint32_t mono_metadata_custom_attrs_from_index(MonoImage* meta, uint32_t cattr_index);
		public static mono.metadata.MonoMarshalSpec* mono_metadata_parse_marshal_spec(MonoImage* image, AnsiChar* ptr);
		public static Void mono_metadata_free_marshal_spec(mono.metadata.MonoMarshalSpec* spec);
		public static uint32_t mono_metadata_implmap_from_method(MonoImage* meta, uint32_t method_idx);
		public static Void mono_metadata_field_info(MonoImage* meta, uint32_t table_index, uint32_t* offset, uint32_t* rva, mono.metadata.MonoMarshalSpec** marshal_spec);
		public static uint32_t mono_metadata_get_constant_index(MonoImage* meta, uint32_t token, uint32_t hint);
		public static uint32_t mono_metadata_decode_value(AnsiChar* ptr, AnsiChar** rptr);
		public static int32_t mono_metadata_decode_signed_value(AnsiChar* ptr, AnsiChar** rptr);
		public static uint32_t mono_metadata_decode_blob_size(AnsiChar* ptr, AnsiChar** rptr);
		public static Void mono_metadata_encode_value(uint32_t @value, AnsiChar* bug, AnsiChar** endbuf);
		public static mono_bool mono_type_is_byref(MonoType* type);
		public static Int32 mono_type_get_type(MonoType* type);
		public static MonoMethodSignature* mono_type_get_signature(MonoType* type);
		public static MonoClass* mono_type_get_class(MonoType* type);
		public static MonoArrayType* mono_type_get_array_type(MonoType* type);
		public static MonoType* mono_type_get_ptr_type(MonoType* type);
		public static MonoClass* mono_type_get_modifiers(MonoType* type, mono_bool* is_required, Void** iter);
		public static mono_bool mono_type_is_struct(MonoType* type);
		public static mono_bool mono_type_is_void(MonoType* type);
		public static mono_bool mono_type_is_pointer(MonoType* type);
		public static mono_bool mono_type_is_reference(MonoType* type);
		public static mono_bool mono_type_is_generic_parameter(MonoType* type);
		public static MonoType* mono_signature_get_return_type(MonoMethodSignature* sig);
		public static MonoType* mono_signature_get_params(MonoMethodSignature* sig, Void** iter);
		public static uint32_t mono_signature_get_param_count(MonoMethodSignature* sig);
		public static uint32_t mono_signature_get_call_conv(MonoMethodSignature* sig);
		public static Int32 mono_signature_vararg_start(MonoMethodSignature* sig);
		public static mono_bool mono_signature_is_instance(MonoMethodSignature* sig);
		public static mono_bool mono_signature_explicit_this(MonoMethodSignature* sig);
		public static mono_bool mono_signature_param_is_out(MonoMethodSignature* sig, Int32 param_num);
		public static uint32_t mono_metadata_parse_typedef_or_ref(MonoImage* m, AnsiChar* ptr, AnsiChar** rptr);
		public static Int32 mono_metadata_parse_custom_mod(MonoImage* m, mono.metadata.MonoCustomMod* dest, AnsiChar* ptr, AnsiChar** rptr);
		public static MonoArrayType* mono_metadata_parse_array(MonoImage* m, AnsiChar* ptr, AnsiChar** rptr);
		public static Void mono_metadata_free_array(MonoArrayType* array);
		public static MonoType* mono_metadata_parse_type(MonoImage* m, mono.metadata.MonoParseTypeMode mode, Int16 opt_attrs, AnsiChar* ptr, AnsiChar** rptr);
		public static MonoType* mono_metadata_parse_param(MonoImage* m, AnsiChar* ptr, AnsiChar** rptr);
		public static MonoType* mono_metadata_parse_ret_type(MonoImage* m, AnsiChar* ptr, AnsiChar** rptr);
		public static MonoType* mono_metadata_parse_field_type(MonoImage* m, Int16 field_flags, AnsiChar* ptr, AnsiChar** rptr);
		public static MonoType* mono_type_create_from_typespec(MonoImage* image, uint32_t type_spec);
		public static Void mono_metadata_free_type(MonoType* type);
		public static Int32 mono_type_size(MonoType* type, Int32* alignment);
		public static Int32 mono_type_stack_size(MonoType* type, Int32* alignment);
		public static mono_bool mono_type_generic_inst_is_valuetype(MonoType* type);
		public static mono_bool mono_metadata_generic_class_is_valuetype(MonoGenericClass* gclass);
		public static UInt32 mono_metadata_generic_class_hash(MonoGenericClass* gclass);
		public static mono_bool mono_metadata_generic_class_equal(MonoGenericClass* g1, MonoGenericClass* g2);
		public static UInt32 mono_metadata_type_hash(MonoType* t1);
		public static mono_bool mono_metadata_type_equal(MonoType* t1, MonoType* t2);
		public static MonoMethodSignature* mono_metadata_signature_alloc(MonoImage* image, uint32_t nparams);
		public static MonoMethodSignature* mono_metadata_signature_dup(MonoMethodSignature* sig);
		public static MonoMethodSignature* mono_metadata_parse_signature(MonoImage* image, uint32_t token);
		public static MonoMethodSignature* mono_metadata_parse_method_signature(MonoImage* m, Int32 def, AnsiChar* ptr, AnsiChar** rptr);
		public static Void mono_metadata_free_method_signature(MonoMethodSignature* method);
		public static mono_bool mono_metadata_signature_equal(MonoMethodSignature* sig1, MonoMethodSignature* sig2);
		public static UInt32 mono_signature_hash(MonoMethodSignature* sig);
		public static MonoMethodHeader* mono_metadata_parse_mh(MonoImage* m, AnsiChar* ptr);
		public static Void mono_metadata_free_mh(MonoMethodHeader* mh);
		public static Byte* mono_method_header_get_code(MonoMethodHeader* header, uint32_t* code_size, uint32_t* max_stack);
		public static MonoType** mono_method_header_get_locals(MonoMethodHeader* header, uint32_t* num_locals, mono_bool* init_locals);
		public static Int32 mono_method_header_get_num_clauses(MonoMethodHeader* header);
		public static Int32 mono_method_header_get_clauses(MonoMethodHeader* header, MonoMethod* method, Void** iter, mono.metadata.MonoExceptionClause* clause);
		public static uint32_t mono_type_to_unmanaged(MonoType* type, mono.metadata.MonoMarshalSpec* mspec, mono_bool as_field, mono_bool unicode, mono.metadata.MonoMarshalConv* conv);
		public static uint32_t mono_metadata_token_from_dor(uint32_t dor_index);
		public static AnsiChar* mono_guid_to_string(uint8_t* guid);
		public static AnsiChar* mono_guid_to_string_minimal(uint8_t* guid);
		public static uint32_t mono_metadata_declsec_from_index(MonoImage* meta, uint32_t idx);
		public static uint32_t mono_metadata_translate_token_index(MonoImage* image, Int32 table, uint32_t idx);
		public static Void mono_metadata_decode_table_row(MonoImage* image, Int32 table, Int32 idx, uint32_t* res, Int32 res_size);
		public static uint32_t mono_metadata_decode_table_row_col(MonoImage* image, Int32 table, Int32 idx, UInt32 col);
		public static MonoMethod* mono_get_method(MonoImage* image, uint32_t token, MonoClass* klass);
		public static MonoMethod* mono_get_method_full(MonoImage* image, uint32_t token, MonoClass* klass, MonoGenericContext* context);
		public static MonoMethod* mono_get_method_constrained(MonoImage* image, uint32_t token, MonoClass* constrained_class, MonoGenericContext* context, MonoMethod** cil_method);
		public static Void mono_free_method(MonoMethod* method);
		public static MonoMethodSignature* mono_method_get_signature_full(MonoMethod* method, MonoImage* image, uint32_t token, MonoGenericContext* context);
		public static MonoMethodSignature* mono_method_get_signature(MonoMethod* method, MonoImage* image, uint32_t token);
		public static MonoMethodSignature* mono_method_signature(MonoMethod* method);
		public static MonoMethodHeader* mono_method_get_header(MonoMethod* method);
		public static AnsiChar* mono_method_get_name(MonoMethod* method);
		public static MonoClass* mono_method_get_class(MonoMethod* method);
		public static uint32_t mono_method_get_token(MonoMethod* method);
		public static uint32_t mono_method_get_flags(MonoMethod* method, uint32_t* iflags);
		public static uint32_t mono_method_get_index(MonoMethod* method);
		public static MonoImage* mono_load_image(AnsiChar* fname, mono.metadata.MonoImageOpenStatus* status);
		public static Void mono_add_internal_call(AnsiChar* name, Void* method);
		public static Void* mono_lookup_internal_call(MonoMethod* method);
		public static Void* mono_lookup_internal_call_full(MonoMethod* method, mono_bool* uses_handles);
		public static AnsiChar* mono_lookup_icall_symbol(MonoMethod* m);
		public static Void mono_dllmap_insert(MonoImage* @assembly, AnsiChar* dll, AnsiChar* func, AnsiChar* tdll, AnsiChar* tfunc);
		public static Void* mono_lookup_pinvoke_call(MonoMethod* method, AnsiChar** exc_class, AnsiChar** exc_arg);
		public static Void mono_method_get_param_names(MonoMethod* method, AnsiChar** names);
		public static uint32_t mono_method_get_param_token(MonoMethod* method, Int32 idx);
		public static Void mono_method_get_marshal_info(MonoMethod* method, mono.metadata.MonoMarshalSpec** mspecs);
		public static mono_bool mono_method_has_marshal_info(MonoMethod* method);
		public static MonoMethod* mono_method_get_last_managed();
		public static Void mono_stack_walk([FunctionPointer] delegate mono_bool (MonoMethod* method, int32_t native_offset, int32_t il_offset, mono_bool managed, Void* data) func, Void* user_data);
		public static Void mono_stack_walk_no_il([FunctionPointer] delegate mono_bool (MonoMethod* method, int32_t native_offset, int32_t il_offset, mono_bool managed, Void* data) func, Void* user_data);
		public static Void mono_stack_walk_async_safe([FunctionPointer] delegate mono_bool (MonoMethod* method, MonoDomain* domain, Void* base_address, Int32 offset, Void* data) func, Void* initial_sig_context, Void* user_data);
		public static MonoMethodHeader* mono_method_get_header_checked(MonoMethod* method, mono.utils.MonoError* error);
		public static MonoClass* mono_class_get(MonoImage* image, uint32_t type_token);
		public static MonoClass* mono_class_get_full(MonoImage* image, uint32_t type_token, MonoGenericContext* context);
		public static mono_bool mono_class_init(MonoClass* klass);
		public static MonoVTable* mono_class_vtable(MonoDomain* domain, MonoClass* klass);
		public static MonoClass* mono_class_from_name(MonoImage* image, AnsiChar* name_space, AnsiChar* name);
		public static MonoClass* mono_class_from_name_case(MonoImage* image, AnsiChar* name_space, AnsiChar* name);
		public static MonoMethod* mono_class_get_method_from_name_flags(MonoClass* klass, AnsiChar* name, Int32 param_count, Int32 flags);
		public static MonoClass* mono_class_from_typeref(MonoImage* image, uint32_t type_token);
		public static MonoClass* mono_class_from_typeref_checked(MonoImage* image, uint32_t type_token, mono.utils.MonoError* error);
		public static MonoClass* mono_class_from_generic_parameter(MonoGenericParam* param, MonoImage* image, mono_bool is_mvar);
		public static MonoType* mono_class_inflate_generic_type(MonoType* type, MonoGenericContext* context);
		public static MonoMethod* mono_class_inflate_generic_method(MonoMethod* method, MonoGenericContext* context);
		public static MonoMethod* mono_get_inflated_method(MonoMethod* method);
		public static MonoClassField* mono_field_from_token(MonoImage* image, uint32_t token, MonoClass** retklass, MonoGenericContext* context);
		public static MonoClass* mono_bounded_array_class_get(MonoClass* element_class, uint32_t rank, mono_bool bounded);
		public static MonoClass* mono_array_class_get(MonoClass* element_class, uint32_t rank);
		public static MonoClass* mono_ptr_class_get(MonoType* type);
		public static MonoClassField* mono_class_get_field(MonoClass* klass, uint32_t field_token);
		public static MonoClassField* mono_class_get_field_from_name(MonoClass* klass, AnsiChar* name);
		public static uint32_t mono_class_get_field_token(MonoClassField* field);
		public static uint32_t mono_class_get_event_token(MonoEvent* @event);
		public static MonoProperty* mono_class_get_property_from_name(MonoClass* klass, AnsiChar* name);
		public static uint32_t mono_class_get_property_token(MonoProperty* prop);
		public static int32_t mono_array_element_size(MonoClass* ac);
		public static int32_t mono_class_instance_size(MonoClass* klass);
		public static int32_t mono_class_array_element_size(MonoClass* klass);
		public static int32_t mono_class_data_size(MonoClass* klass);
		public static int32_t mono_class_value_size(MonoClass* klass, uint32_t* align);
		public static int32_t mono_class_min_align(MonoClass* klass);
		public static MonoClass* mono_class_from_mono_type(MonoType* type);
		public static mono_bool mono_class_is_subclass_of(MonoClass* klass, MonoClass* klassc, mono_bool check_interfaces);
		public static mono_bool mono_class_is_assignable_from(MonoClass* klass, MonoClass* oklass);
		public static Void* mono_ldtoken(MonoImage* image, uint32_t token, MonoClass** retclass, MonoGenericContext* context);
		public static AnsiChar* mono_type_get_name(MonoType* type);
		public static MonoType* mono_type_get_underlying_type(MonoType* type);
		public static MonoImage* mono_class_get_image(MonoClass* klass);
		public static MonoClass* mono_class_get_element_class(MonoClass* klass);
		public static mono_bool mono_class_is_valuetype(MonoClass* klass);
		public static mono_bool mono_class_is_enum(MonoClass* klass);
		public static MonoType* mono_class_enum_basetype(MonoClass* klass);
		public static MonoClass* mono_class_get_parent(MonoClass* klass);
		public static MonoClass* mono_class_get_nesting_type(MonoClass* klass);
		public static Int32 mono_class_get_rank(MonoClass* klass);
		public static uint32_t mono_class_get_flags(MonoClass* klass);
		public static AnsiChar* mono_class_get_name(MonoClass* klass);
		public static AnsiChar* mono_class_get_namespace(MonoClass* klass);
		public static MonoType* mono_class_get_type(MonoClass* klass);
		public static uint32_t mono_class_get_type_token(MonoClass* klass);
		public static MonoType* mono_class_get_byref_type(MonoClass* klass);
		public static Int32 mono_class_num_fields(MonoClass* klass);
		public static Int32 mono_class_num_methods(MonoClass* klass);
		public static Int32 mono_class_num_properties(MonoClass* klass);
		public static Int32 mono_class_num_events(MonoClass* klass);
		public static MonoClassField* mono_class_get_fields(MonoClass* klass, Void** iter);
		public static MonoMethod* mono_class_get_methods(MonoClass* klass, Void** iter);
		public static MonoProperty* mono_class_get_properties(MonoClass* klass, Void** iter);
		public static MonoEvent* mono_class_get_events(MonoClass* klass, Void** iter);
		public static MonoClass* mono_class_get_interfaces(MonoClass* klass, Void** iter);
		public static MonoClass* mono_class_get_nested_types(MonoClass* klass, Void** iter);
		public static mono_bool mono_class_is_delegate(MonoClass* klass);
		public static mono_bool mono_class_implements_interface(MonoClass* klass, MonoClass* iface);
		public static AnsiChar* mono_field_get_name(MonoClassField* field);
		public static MonoType* mono_field_get_type(MonoClassField* field);
		public static MonoClass* mono_field_get_parent(MonoClassField* field);
		public static uint32_t mono_field_get_flags(MonoClassField* field);
		public static uint32_t mono_field_get_offset(MonoClassField* field);
		public static AnsiChar* mono_field_get_data(MonoClassField* field);
		public static AnsiChar* mono_property_get_name(MonoProperty* prop);
		public static MonoMethod* mono_property_get_set_method(MonoProperty* prop);
		public static MonoMethod* mono_property_get_get_method(MonoProperty* prop);
		public static MonoClass* mono_property_get_parent(MonoProperty* prop);
		public static uint32_t mono_property_get_flags(MonoProperty* prop);
		public static AnsiChar* mono_event_get_name(MonoEvent* @event);
		public static MonoMethod* mono_event_get_add_method(MonoEvent* @event);
		public static MonoMethod* mono_event_get_remove_method(MonoEvent* @event);
		public static MonoMethod* mono_event_get_raise_method(MonoEvent* @event);
		public static MonoClass* mono_event_get_parent(MonoEvent* @event);
		public static uint32_t mono_event_get_flags(MonoEvent* @event);
		public static MonoMethod* mono_class_get_method_from_name(MonoClass* klass, AnsiChar* name, Int32 param_count);
		public static AnsiChar* mono_class_name_from_token(MonoImage* image, uint32_t type_token);
		public static mono_bool mono_method_can_access_field(MonoMethod* method, MonoClassField* field);
		public static mono_bool mono_method_can_access_method(MonoMethod* method, MonoMethod* called);
		public static mono_unichar2* mono_string_chars(MonoString* s);
		public static Int32 mono_string_length(MonoString* s);
		public static mono.metadata.MonoObject* mono_object_new(MonoDomain* domain, MonoClass* klass);
		public static mono.metadata.MonoObject* mono_object_new_specific(MonoVTable* vtable);
		public static mono.metadata.MonoObject* mono_object_new_fast(MonoVTable* vtable);
		public static mono.metadata.MonoObject* mono_object_new_alloc_specific(MonoVTable* vtable);
		public static mono.metadata.MonoObject* mono_object_new_from_token(MonoDomain* domain, MonoImage* image, uint32_t token);
		public static MonoArray* mono_array_new(MonoDomain* domain, MonoClass* eclass, uintptr_t n);
		public static MonoArray* mono_array_new_full(MonoDomain* domain, MonoClass* array_class, uintptr_t* lengths, intptr_t* lower_bounds);
		public static MonoArray* mono_array_new_specific(MonoVTable* vtable, uintptr_t n);
		public static MonoArray* mono_array_clone(MonoArray* array);
		public static AnsiChar* mono_array_addr_with_size(MonoArray* array, Int32 size, uintptr_t idx);
		public static uintptr_t mono_array_length(MonoArray* array);
		public static MonoString* mono_string_new_utf16(MonoDomain* domain, mono_unichar2* text, int32_t len);
		public static MonoString* mono_string_new_size(MonoDomain* domain, int32_t len);
		public static MonoString* mono_ldstr(MonoDomain* domain, MonoImage* image, uint32_t str_index);
		public static MonoString* mono_string_is_interned(MonoString* str);
		public static MonoString* mono_string_intern(MonoString* str);
		public static MonoString* mono_string_new(MonoDomain* domain, AnsiChar* text);
		public static MonoString* mono_string_new_wrapper(AnsiChar* text);
		public static MonoString* mono_string_new_len(MonoDomain* domain, AnsiChar* text, UInt32 length);
		public static MonoString* mono_string_new_utf32(MonoDomain* domain, mono_unichar4* text, int32_t len);
		public static AnsiChar* mono_string_to_utf8(MonoString* string_obj);
		public static AnsiChar* mono_string_to_utf8_checked(MonoString* string_obj, mono.utils.MonoError* error);
		public static mono_unichar2* mono_string_to_utf16(MonoString* string_obj);
		public static mono_unichar4* mono_string_to_utf32(MonoString* string_obj);
		public static MonoString* mono_string_from_utf16(mono_unichar2* data);
		public static MonoString* mono_string_from_utf32(mono_unichar4* data);
		public static mono_bool mono_string_equal(MonoString* s1, MonoString* s2);
		public static UInt32 mono_string_hash(MonoString* s);
		public static Int32 mono_object_hash(mono.metadata.MonoObject* obj);
		public static MonoString* mono_object_to_string(mono.metadata.MonoObject* obj, mono.metadata.MonoObject** exc);
		public static mono.metadata.MonoObject* mono_value_box(MonoDomain* domain, MonoClass* klass, Void* val);
		public static Void mono_value_copy(Void* dest, Void* src, MonoClass* klass);
		public static Void mono_value_copy_array(MonoArray* dest, Int32 dest_idx, Void* src, Int32 count);
		public static MonoDomain* mono_object_get_domain(mono.metadata.MonoObject* obj);
		public static MonoClass* mono_object_get_class(mono.metadata.MonoObject* obj);
		public static Void* mono_object_unbox(mono.metadata.MonoObject* obj);
		public static mono.metadata.MonoObject* mono_object_clone(mono.metadata.MonoObject* obj);
		public static mono.metadata.MonoObject* mono_object_isinst(mono.metadata.MonoObject* obj, MonoClass* klass);
		public static mono.metadata.MonoObject* mono_object_isinst_mbyref(mono.metadata.MonoObject* obj, MonoClass* klass);
		public static mono.metadata.MonoObject* mono_object_castclass_mbyref(mono.metadata.MonoObject* obj, MonoClass* klass);
		public static mono_bool mono_monitor_try_enter(mono.metadata.MonoObject* obj, uint32_t ms);
		public static mono_bool mono_monitor_enter(mono.metadata.MonoObject* obj);
		public static Void mono_monitor_enter_v4(mono.metadata.MonoObject* obj, AnsiChar* lock_taken);
		public static UInt32 mono_object_get_size(mono.metadata.MonoObject* o);
		public static Void mono_monitor_exit(mono.metadata.MonoObject* obj);
		public static Void mono_raise_exception(MonoException* ex);
		public static Void mono_runtime_object_init(mono.metadata.MonoObject* this_obj);
		public static Void mono_runtime_class_init(MonoVTable* vtable);
		public static MonoMethod* mono_object_get_virtual_method(mono.metadata.MonoObject* obj, MonoMethod* method);
		public static mono.metadata.MonoObject* mono_runtime_invoke(MonoMethod* method, Void* obj, Void** @params, mono.metadata.MonoObject** exc);
		public static MonoMethod* mono_get_delegate_invoke(MonoClass* klass);
		public static MonoMethod* mono_get_delegate_begin_invoke(MonoClass* klass);
		public static MonoMethod* mono_get_delegate_end_invoke(MonoClass* klass);
		public static mono.metadata.MonoObject* mono_runtime_delegate_invoke(mono.metadata.MonoObject* @delegate, Void** @params, mono.metadata.MonoObject** exc);
		public static mono.metadata.MonoObject* mono_runtime_invoke_array(MonoMethod* method, Void* obj, MonoArray* @params, mono.metadata.MonoObject** exc);
		public static Void* mono_method_get_unmanaged_thunk(MonoMethod* method);
		public static MonoArray* mono_runtime_get_main_args();
		public static Void mono_runtime_exec_managed_code(MonoDomain* domain, [FunctionPointer] delegate Void (Void* user_data) main_func, Void* main_args);
		public static Int32 mono_runtime_run_main(MonoMethod* method, Int32 argc, AnsiChar** argv, mono.metadata.MonoObject** exc);
		public static Int32 mono_runtime_exec_main(MonoMethod* method, MonoArray* args, mono.metadata.MonoObject** exc);
		public static Int32 mono_runtime_set_main_args(Int32 argc, AnsiChar** argv);
		public static Void* mono_load_remote_field(mono.metadata.MonoObject* this_obj, MonoClass* klass, MonoClassField* field, Void** res);
		public static mono.metadata.MonoObject* mono_load_remote_field_new(mono.metadata.MonoObject* this_obj, MonoClass* klass, MonoClassField* field);
		public static Void mono_store_remote_field(mono.metadata.MonoObject* this_obj, MonoClass* klass, MonoClassField* field, Void* val);
		public static Void mono_store_remote_field_new(mono.metadata.MonoObject* this_obj, MonoClass* klass, MonoClassField* field, mono.metadata.MonoObject* arg);
		public static Void mono_unhandled_exception(mono.metadata.MonoObject* exc);
		public static Void mono_print_unhandled_exception(mono.metadata.MonoObject* exc);
		public static Void* mono_compile_method(MonoMethod* method);
		public static Void mono_field_set_value(mono.metadata.MonoObject* obj, MonoClassField* field, Void* @value);
		public static Void mono_field_static_set_value(MonoVTable* vt, MonoClassField* field, Void* @value);
		public static Void mono_field_get_value(mono.metadata.MonoObject* obj, MonoClassField* field, Void* @value);
		public static Void mono_field_static_get_value(MonoVTable* vt, MonoClassField* field, Void* @value);
		public static mono.metadata.MonoObject* mono_field_get_value_object(MonoDomain* domain, MonoClassField* field, mono.metadata.MonoObject* obj);
		public static Void mono_property_set_value(MonoProperty* prop, Void* obj, Void** @params, mono.metadata.MonoObject** exc);
		public static mono.metadata.MonoObject* mono_property_get_value(MonoProperty* prop, Void* obj, Void** @params, mono.metadata.MonoObject** exc);
		public static uint32_t mono_gchandle_new(mono.metadata.MonoObject* obj, mono_bool pinned);
		public static uint32_t mono_gchandle_new_weakref(mono.metadata.MonoObject* obj, mono_bool track_resurrection);
		public static mono.metadata.MonoObject* mono_gchandle_get_target(uint32_t gchandle);
		public static Void mono_gchandle_free(uint32_t gchandle);
		public static MonoReferenceQueue* mono_gc_reference_queue_new([FunctionPointer] delegate Void (Void* user_data) callback);
		public static Void mono_gc_reference_queue_free(MonoReferenceQueue* queue);
		public static mono_bool mono_gc_reference_queue_add(MonoReferenceQueue* queue, mono.metadata.MonoObject* obj, Void* user_data);
		public static Void mono_gc_wbarrier_set_field(mono.metadata.MonoObject* obj, Void* field_ptr, mono.metadata.MonoObject* @value);
		public static Void mono_gc_wbarrier_set_arrayref(MonoArray* arr, Void* slot_ptr, mono.metadata.MonoObject* @value);
		public static Void mono_gc_wbarrier_arrayref_copy(Void* dest_ptr, Void* src_ptr, Int32 count);
		public static Void mono_gc_wbarrier_generic_store(Void* ptr, mono.metadata.MonoObject* @value);
		public static Void mono_gc_wbarrier_generic_store_atomic(Void* ptr, mono.metadata.MonoObject* @value);
		public static Void mono_gc_wbarrier_generic_nostore(Void* ptr);
		public static Void mono_gc_wbarrier_value_copy(Void* dest, Void* src, Int32 count, MonoClass* klass);
		public static Void mono_gc_wbarrier_object_copy(mono.metadata.MonoObject* obj, mono.metadata.MonoObject* src);
		public static Int32 mono_reflection_parse_type(AnsiChar* name, MonoTypeNameParse* info);
		public static MonoType* mono_reflection_get_type(MonoImage* image, MonoTypeNameParse* info, mono_bool ignorecase, mono_bool* type_resolve);
		public static Void mono_reflection_free_type_info(MonoTypeNameParse* info);
		public static MonoType* mono_reflection_type_from_name(AnsiChar* name, MonoImage* image);
		public static uint32_t mono_reflection_get_token(mono.metadata.MonoObject* obj);
		public static MonoReflectionAssembly* mono_assembly_get_object(MonoDomain* domain, MonoAssembly* @assembly);
		public static MonoReflectionModule* mono_module_get_object(MonoDomain* domain, MonoImage* image);
		public static MonoReflectionModule* mono_module_file_get_object(MonoDomain* domain, MonoImage* image, Int32 table_index);
		public static MonoReflectionType* mono_type_get_object(MonoDomain* domain, MonoType* type);
		public static MonoReflectionMethod* mono_method_get_object(MonoDomain* domain, MonoMethod* method, MonoClass* refclass);
		public static MonoReflectionField* mono_field_get_object(MonoDomain* domain, MonoClass* klass, MonoClassField* field);
		public static MonoReflectionProperty* mono_property_get_object(MonoDomain* domain, MonoClass* klass, MonoProperty* property);
		public static MonoReflectionEvent* mono_event_get_object(MonoDomain* domain, MonoClass* klass, MonoEvent* @event);
		public static MonoArray* mono_param_get_objects(MonoDomain* domain, MonoMethod* method);
		public static MonoReflectionMethodBody* mono_method_body_get_object(MonoDomain* domain, MonoMethod* method);
		public static mono.metadata.MonoObject* mono_get_dbnull_object(MonoDomain* domain);
		public static MonoArray* mono_reflection_get_custom_attrs_by_type(mono.metadata.MonoObject* obj, MonoClass* attr_klass, mono.utils.MonoError* error);
		public static MonoArray* mono_reflection_get_custom_attrs(mono.metadata.MonoObject* obj);
		public static MonoArray* mono_reflection_get_custom_attrs_data(mono.metadata.MonoObject* obj);
		public static MonoArray* mono_reflection_get_custom_attrs_blob(MonoReflectionAssembly* @assembly, mono.metadata.MonoObject* ctor, MonoArray* ctorArgs, MonoArray* properties, MonoArray* porpValues, MonoArray* fields, MonoArray* fieldValues);
		public static mono.metadata.MonoCustomAttrInfo* mono_reflection_get_custom_attrs_info(mono.metadata.MonoObject* obj);
		public static MonoArray* mono_custom_attrs_construct(mono.metadata.MonoCustomAttrInfo* cinfo);
		public static mono.metadata.MonoCustomAttrInfo* mono_custom_attrs_from_index(MonoImage* image, uint32_t idx);
		public static mono.metadata.MonoCustomAttrInfo* mono_custom_attrs_from_method(MonoMethod* method);
		public static mono.metadata.MonoCustomAttrInfo* mono_custom_attrs_from_class(MonoClass* klass);
		public static mono.metadata.MonoCustomAttrInfo* mono_custom_attrs_from_assembly(MonoAssembly* @assembly);
		public static mono.metadata.MonoCustomAttrInfo* mono_custom_attrs_from_property(MonoClass* klass, MonoProperty* property);
		public static mono.metadata.MonoCustomAttrInfo* mono_custom_attrs_from_event(MonoClass* klass, MonoEvent* @event);
		public static mono.metadata.MonoCustomAttrInfo* mono_custom_attrs_from_field(MonoClass* klass, MonoClassField* field);
		public static mono.metadata.MonoCustomAttrInfo* mono_custom_attrs_from_param(MonoMethod* method, uint32_t param);
		public static mono_bool mono_custom_attrs_has_attr(mono.metadata.MonoCustomAttrInfo* ainfo, MonoClass* attr_klass);
		public static mono.metadata.MonoObject* mono_custom_attrs_get_attr(mono.metadata.MonoCustomAttrInfo* ainfo, MonoClass* attr_klass);
		public static Void mono_custom_attrs_free(mono.metadata.MonoCustomAttrInfo* ainfo);
		public static const Int32 MONO_DECLSEC_FLAG_REQUEST;
		public static const Int32 MONO_DECLSEC_FLAG_DEMAND;
		public static const Int32 MONO_DECLSEC_FLAG_ASSERT;
		public static const Int32 MONO_DECLSEC_FLAG_DENY;
		public static const Int32 MONO_DECLSEC_FLAG_PERMITONLY;
		public static const Int32 MONO_DECLSEC_FLAG_LINKDEMAND;
		public static const Int32 MONO_DECLSEC_FLAG_INHERITANCEDEMAND;
		public static const Int32 MONO_DECLSEC_FLAG_REQUEST_MINIMUM;
		public static const Int32 MONO_DECLSEC_FLAG_REQUEST_OPTIONAL;
		public static const Int32 MONO_DECLSEC_FLAG_REQUEST_REFUSE;
		public static const Int32 MONO_DECLSEC_FLAG_PREJIT_GRANT;
		public static const Int32 MONO_DECLSEC_FLAG_PREJIT_DENY;
		public static const Int32 MONO_DECLSEC_FLAG_NONCAS_DEMAND;
		public static const Int32 MONO_DECLSEC_FLAG_NONCAS_LINKDEMAND;
		public static const Int32 MONO_DECLSEC_FLAG_NONCAS_INHERITANCEDEMAND;
		public static const Int32 MONO_DECLSEC_FLAG_LINKDEMAND_CHOICE;
		public static const Int32 MONO_DECLSEC_FLAG_INHERITANCEDEMAND_CHOICE;
		public static const Int32 MONO_DECLSEC_FLAG_DEMAND_CHOICE;
		public static uint32_t mono_declsec_flags_from_method(MonoMethod* method);
		public static uint32_t mono_declsec_flags_from_class(MonoClass* klass);
		public static uint32_t mono_declsec_flags_from_assembly(MonoAssembly* @assembly);
		public static MonoBoolean mono_declsec_get_demands(MonoMethod* callee, mono.metadata.MonoDeclSecurityActions* demands);
		public static MonoBoolean mono_declsec_get_linkdemands(MonoMethod* callee, mono.metadata.MonoDeclSecurityActions* klass, mono.metadata.MonoDeclSecurityActions* cmethod);
		public static MonoBoolean mono_declsec_get_inheritdemands_class(MonoClass* klass, mono.metadata.MonoDeclSecurityActions* demands);
		public static MonoBoolean mono_declsec_get_inheritdemands_method(MonoMethod* callee, mono.metadata.MonoDeclSecurityActions* demands);
		public static MonoBoolean mono_declsec_get_method_action(MonoMethod* method, uint32_t action, mono.metadata.MonoDeclSecurityEntry* entry);
		public static MonoBoolean mono_declsec_get_class_action(MonoClass* klass, uint32_t action, mono.metadata.MonoDeclSecurityEntry* entry);
		public static MonoBoolean mono_declsec_get_assembly_action(MonoAssembly* @assembly, uint32_t action, mono.metadata.MonoDeclSecurityEntry* entry);
		public static MonoType* mono_reflection_type_get_type(MonoReflectionType* reftype);
		public static MonoAssembly* mono_reflection_assembly_get_assembly(MonoReflectionAssembly* refassembly);
		public static MonoDomain* mono_init(AnsiChar* filename);
		public static MonoDomain* mono_init_from_assembly(AnsiChar* domain_name, AnsiChar* filename);
		public static MonoDomain* mono_init_version(AnsiChar* domain_name, AnsiChar* version);
		public static MonoDomain* mono_get_root_domain();
		public static Void mono_runtime_init(MonoDomain* domain, [FunctionPointer] delegate Void (intptr_t tid, Void* stack_start, Void* func) start_cb, [FunctionPointer] delegate Void (intptr_t tid, Void* stack_start) attach_cb);
		public static Void mono_runtime_cleanup(MonoDomain* domain);
		public static Void mono_install_runtime_cleanup([FunctionPointer] delegate Void (MonoDomain* domain, Void* user_data) func);
		public static Void mono_runtime_quit();
		public static Void mono_runtime_set_shutting_down();
		public static mono_bool mono_runtime_is_shutting_down();
		public static AnsiChar* mono_check_corlib_version();
		public static MonoDomain* mono_domain_create();
		public static MonoDomain* mono_domain_create_appdomain(AnsiChar* friendly_name, AnsiChar* configuration_file);
		public static Void mono_domain_set_config(MonoDomain* domain, AnsiChar* base_dir, AnsiChar* config_file_name);
		public static MonoDomain* mono_domain_get();
		public static MonoDomain* mono_domain_get_by_id(int32_t domainid);
		public static int32_t mono_domain_get_id(MonoDomain* domain);
		public static AnsiChar* mono_domain_get_friendly_name(MonoDomain* domain);
		public static mono_bool mono_domain_set(MonoDomain* domain, mono_bool force);
		public static Void mono_domain_set_internal(MonoDomain* domain);
		public static Void mono_domain_unload(MonoDomain* domain);
		public static Void mono_domain_try_unload(MonoDomain* domain, mono.metadata.MonoObject** exc);
		public static mono_bool mono_domain_is_unloading(MonoDomain* domain);
		public static MonoDomain* mono_domain_from_appdomain(MonoAppDomain* appdomain);
		public static Void mono_domain_foreach([FunctionPointer] delegate Void (MonoDomain* domain, Void* user_data) func, Void* user_data);
		public static MonoAssembly* mono_domain_assembly_open(MonoDomain* domain, AnsiChar* name);
		public static mono_bool mono_domain_finalize(MonoDomain* domain, uint32_t timeout);
		public static Void mono_domain_free(MonoDomain* domain, mono_bool force);
		public static mono_bool mono_domain_has_type_resolve(MonoDomain* domain);
		public static MonoReflectionAssembly* mono_domain_try_type_resolve(MonoDomain* domain, AnsiChar* name, mono.metadata.MonoObject* tb);
		public static mono_bool mono_domain_owns_vtable_slot(MonoDomain* domain, Void* vtable_slot);
		public static Void mono_context_init(MonoDomain* domain);
		public static Void mono_context_set(MonoAppContext* new_context);
		public static MonoAppContext* mono_context_get();
		public static int32_t mono_context_get_id(MonoAppContext* context);
		public static int32_t mono_context_get_domain_id(MonoAppContext* context);
		public static MonoJitInfo* mono_jit_info_table_find(MonoDomain* domain, AnsiChar* addr);
		public static Void* mono_jit_info_get_code_start(MonoJitInfo* ji);
		public static Int32 mono_jit_info_get_code_size(MonoJitInfo* ji);
		public static MonoMethod* mono_jit_info_get_method(MonoJitInfo* ji);
		public static MonoImage* mono_get_corlib();
		public static MonoClass* mono_get_object_class();
		public static MonoClass* mono_get_byte_class();
		public static MonoClass* mono_get_void_class();
		public static MonoClass* mono_get_boolean_class();
		public static MonoClass* mono_get_sbyte_class();
		public static MonoClass* mono_get_int16_class();
		public static MonoClass* mono_get_uint16_class();
		public static MonoClass* mono_get_int32_class();
		public static MonoClass* mono_get_uint32_class();
		public static MonoClass* mono_get_intptr_class();
		public static MonoClass* mono_get_uintptr_class();
		public static MonoClass* mono_get_int64_class();
		public static MonoClass* mono_get_uint64_class();
		public static MonoClass* mono_get_single_class();
		public static MonoClass* mono_get_double_class();
		public static MonoClass* mono_get_char_class();
		public static MonoClass* mono_get_string_class();
		public static MonoClass* mono_get_enum_class();
		public static MonoClass* mono_get_array_class();
		public static MonoClass* mono_get_thread_class();
		public static MonoClass* mono_get_exception_class();
		public static Void mono_security_enable_core_clr();
		public static Void mono_security_set_core_clr_platform_callback([FunctionPointer] delegate mono_bool (AnsiChar* image_name) callback);
		public static Void mono_assemblies_init();
		public static Void mono_assemblies_cleanup();
		public static MonoAssembly* mono_assembly_open(AnsiChar* filename, mono.metadata.MonoImageOpenStatus* status);
		public static MonoAssembly* mono_assembly_open_full(AnsiChar* filename, mono.metadata.MonoImageOpenStatus* status, mono_bool refonly);
		public static MonoAssembly* mono_assembly_load(MonoAssemblyName* aname, AnsiChar* basedir, mono.metadata.MonoImageOpenStatus* status);
		public static MonoAssembly* mono_assembly_load_full(MonoAssemblyName* aname, AnsiChar* basedir, mono.metadata.MonoImageOpenStatus* status, mono_bool refonly);
		public static MonoAssembly* mono_assembly_load_from(MonoImage* image, AnsiChar* fname, mono.metadata.MonoImageOpenStatus* status);
		public static MonoAssembly* mono_assembly_load_from_full(MonoImage* image, AnsiChar* fname, mono.metadata.MonoImageOpenStatus* status, mono_bool refonly);
		public static MonoAssembly* mono_assembly_load_with_partial_name(AnsiChar* name, mono.metadata.MonoImageOpenStatus* status);
		public static MonoAssembly* mono_assembly_loaded(MonoAssemblyName* aname);
		public static MonoAssembly* mono_assembly_loaded_full(MonoAssemblyName* aname, mono_bool refonly);
		public static Void mono_assembly_get_assemblyref(MonoImage* image, Int32 index, MonoAssemblyName* aname);
		public static Void mono_assembly_load_reference(MonoImage* image, Int32 index);
		public static Void mono_assembly_load_references(MonoImage* image, mono.metadata.MonoImageOpenStatus* status);
		public static MonoImage* mono_assembly_load_module(MonoAssembly* @assembly, uint32_t idx);
		public static Void mono_assembly_close(MonoAssembly* @assembly);
		public static Void mono_assembly_setrootdir(AnsiChar* root_dir);
		public static AnsiChar* mono_assembly_getrootdir();
		public static AnsiChar* mono_native_getrootdir();
		public static Void mono_assembly_foreach([FunctionPointer] delegate Void (Void* data, Void* user_data) func, Void* user_data);
		public static Void mono_assembly_set_main(MonoAssembly* @assembly);
		public static MonoAssembly* mono_assembly_get_main();
		public static MonoImage* mono_assembly_get_image(MonoAssembly* @assembly);
		public static MonoAssemblyName* mono_assembly_get_name(MonoAssembly* @assembly);
		public static mono_bool mono_assembly_fill_assembly_name(MonoImage* image, MonoAssemblyName* aname);
		public static mono_bool mono_assembly_names_equal(MonoAssemblyName* l, MonoAssemblyName* r);
		public static AnsiChar* mono_stringify_assembly_name(MonoAssemblyName* aname);
		public static Void mono_install_assembly_load_hook([FunctionPointer] delegate Void (MonoAssembly* @assembly, Void* user_data) func, Void* user_data);
		public static Void mono_install_assembly_search_hook([FunctionPointer] delegate MonoAssembly* (MonoAssemblyName* aname, Void* user_data) func, Void* user_data);
		public static Void mono_install_assembly_refonly_search_hook([FunctionPointer] delegate MonoAssembly* (MonoAssemblyName* aname, Void* user_data) func, Void* user_data);
		public static MonoAssembly* mono_assembly_invoke_search_hook(MonoAssemblyName* aname);
		public static Void mono_install_assembly_postload_search_hook([FunctionPointer] delegate MonoAssembly* (MonoAssemblyName* aname, Void* user_data) func, Void* user_data);
		public static Void mono_install_assembly_postload_refonly_search_hook([FunctionPointer] delegate MonoAssembly* (MonoAssemblyName* aname, Void* user_data) func, Void* user_data);
		public static Void mono_install_assembly_preload_hook([FunctionPointer] delegate MonoAssembly* (MonoAssemblyName* aname, AnsiChar** assemblies_path, Void* user_data) func, Void* user_data);
		public static Void mono_install_assembly_refonly_preload_hook([FunctionPointer] delegate MonoAssembly* (MonoAssemblyName* aname, AnsiChar** assemblies_path, Void* user_data) func, Void* user_data);
		public static Void mono_assembly_invoke_load_hook(MonoAssembly* ass);
		public static MonoAssemblyName* mono_assembly_name_new(AnsiChar* name);
		public static AnsiChar* mono_assembly_name_get_name(MonoAssemblyName* aname);
		public static AnsiChar* mono_assembly_name_get_culture(MonoAssemblyName* aname);
		public static uint16_t mono_assembly_name_get_version(MonoAssemblyName* aname, uint16_t* minor, uint16_t* build, uint16_t* revision);
		public static mono_byte* mono_assembly_name_get_pubkeytoken(MonoAssemblyName* aname);
		public static Void mono_assembly_name_free(MonoAssemblyName* aname);
		public static Void mono_register_bundled_assemblies(mono.metadata.MonoBundledAssembly** assemblies);
		public static Void mono_register_config_for_assembly(AnsiChar* assembly_name, AnsiChar* config_xml);
		public static Void mono_register_symfile_for_assembly(AnsiChar* assembly_name, mono_byte* raw_contents, Int32 size);
		public static Void mono_register_machine_config(AnsiChar* config_xml);
		public static Void mono_set_rootdir();
		public static Void mono_set_dirs(AnsiChar* assembly_dir, AnsiChar* config_dir);
		public static Void mono_set_assemblies_path(AnsiChar* path);
		public static const Int32 MONO_ASSEMBLY_HASH_NONE;
		public static const Int32 MONO_ASSEMBLY_HASH_MD5;
		public static const Int32 MONO_ASSEMBLY_HASH_SHA1;
		public static const Int32 MONO_ASSEMBLYREF_FULL_PUBLIC_KEY;
		public static const Int32 MONO_ASSEMBLYREF_RETARGETABLE;
		public static const Int32 MONO_ASSEMBLYREF_JIT_TRACKING;
		public static const Int32 MONO_ASSEMBLYREF_NO_JIT_OPT;
		public static const Int32 MONO_EVENT_SPECIALNAME;
		public static const Int32 MONO_EVENT_RTSPECIALNAME;
		public static const Int32 MONO_FIELD_ATTR_FIELD_ACCESS_MASK;
		public static const Int32 MONO_FIELD_ATTR_COMPILER_CONTROLLED;
		public static const Int32 MONO_FIELD_ATTR_PRIVATE;
		public static const Int32 MONO_FIELD_ATTR_FAM_AND_ASSEM;
		public static const Int32 MONO_FIELD_ATTR_ASSEMBLY;
		public static const Int32 MONO_FIELD_ATTR_FAMILY;
		public static const Int32 MONO_FIELD_ATTR_FAM_OR_ASSEM;
		public static const Int32 MONO_FIELD_ATTR_PUBLIC;
		public static const Int32 MONO_FIELD_ATTR_STATIC;
		public static const Int32 MONO_FIELD_ATTR_INIT_ONLY;
		public static const Int32 MONO_FIELD_ATTR_LITERAL;
		public static const Int32 MONO_FIELD_ATTR_NOT_SERIALIZED;
		public static const Int32 MONO_FIELD_ATTR_SPECIAL_NAME;
		public static const Int32 MONO_FIELD_ATTR_PINVOKE_IMPL;
		public static const Int32 MONO_FIELD_ATTR_RESERVED_MASK;
		public static const Int32 MONO_FIELD_ATTR_RT_SPECIAL_NAME;
		public static const Int32 MONO_FIELD_ATTR_HAS_MARSHAL;
		public static const Int32 MONO_FIELD_ATTR_HAS_DEFAULT;
		public static const Int32 MONO_FIELD_ATTR_HAS_RVA;
		public static const Int32 MONO_FILE_HAS_METADATA;
		public static const Int32 MONO_FILE_HAS_NO_METADATA;
		public static const Int32 MONO_GEN_PARAM_VARIANCE_MASK;
		public static const Int32 MONO_GEN_PARAM_NON_VARIANT;
		public static const Int32 MONO_GEN_PARAM_VARIANT;
		public static const Int32 MONO_GEN_PARAM_COVARIANT;
		public static const Int32 MONO_GEN_PARAM_CONSTRAINT_MASK;
		public static const Int32 MONO_GEN_PARAM_CONSTRAINT_CLASS;
		public static const Int32 MONO_GEN_PARAM_CONSTRAINT_VTYPE;
		public static const Int32 MONO_GEN_PARAM_CONSTRAINT_DCTOR;
		public static const Int32 MONO_PINVOKE_NO_MANGLE;
		public static const Int32 MONO_PINVOKE_CHAR_SET_MASK;
		public static const Int32 MONO_PINVOKE_CHAR_SET_NOT_SPEC;
		public static const Int32 MONO_PINVOKE_CHAR_SET_ANSI;
		public static const Int32 MONO_PINVOKE_CHAR_SET_UNICODE;
		public static const Int32 MONO_PINVOKE_CHAR_SET_AUTO;
		public static const Int32 MONO_PINVOKE_BEST_FIT_ENABLED;
		public static const Int32 MONO_PINVOKE_BEST_FIT_DISABLED;
		public static const Int32 MONO_PINVOKE_BEST_FIT_MASK;
		public static const Int32 MONO_PINVOKE_SUPPORTS_LAST_ERROR;
		public static const Int32 MONO_PINVOKE_CALL_CONV_MASK;
		public static const Int32 MONO_PINVOKE_CALL_CONV_WINAPI;
		public static const Int32 MONO_PINVOKE_CALL_CONV_CDECL;
		public static const Int32 MONO_PINVOKE_CALL_CONV_STDCALL;
		public static const Int32 MONO_PINVOKE_CALL_CONV_THISCALL;
		public static const Int32 MONO_PINVOKE_CALL_CONV_FASTCALL;
		public static const Int32 MONO_PINVOKE_THROW_ON_UNMAPPABLE_ENABLED;
		public static const Int32 MONO_PINVOKE_THROW_ON_UNMAPPABLE_DISABLED;
		public static const Int32 MONO_PINVOKE_THROW_ON_UNMAPPABLE_MASK;
		public static const Int32 MONO_PINVOKE_CALL_CONV_GENERIC;
		public static const Int32 MONO_PINVOKE_CALL_CONV_GENERICINST;
		public static const Int32 MONO_MANIFEST_RESOURCE_VISIBILITY_MASK;
		public static const Int32 MONO_MANIFEST_RESOURCE_PUBLIC;
		public static const Int32 MONO_MANIFEST_RESOURCE_PRIVATE;
		public static const Int32 MONO_METHOD_ATTR_ACCESS_MASK;
		public static const Int32 MONO_METHOD_ATTR_COMPILER_CONTROLLED;
		public static const Int32 MONO_METHOD_ATTR_PRIVATE;
		public static const Int32 MONO_METHOD_ATTR_FAM_AND_ASSEM;
		public static const Int32 MONO_METHOD_ATTR_ASSEM;
		public static const Int32 MONO_METHOD_ATTR_FAMILY;
		public static const Int32 MONO_METHOD_ATTR_FAM_OR_ASSEM;
		public static const Int32 MONO_METHOD_ATTR_PUBLIC;
		public static const Int32 MONO_METHOD_ATTR_STATIC;
		public static const Int32 MONO_METHOD_ATTR_FINAL;
		public static const Int32 MONO_METHOD_ATTR_VIRTUAL;
		public static const Int32 MONO_METHOD_ATTR_HIDE_BY_SIG;
		public static const Int32 MONO_METHOD_ATTR_VTABLE_LAYOUT_MASK;
		public static const Int32 MONO_METHOD_ATTR_REUSE_SLOT;
		public static const Int32 MONO_METHOD_ATTR_NEW_SLOT;
		public static const Int32 MONO_METHOD_ATTR_STRICT;
		public static const Int32 MONO_METHOD_ATTR_ABSTRACT;
		public static const Int32 MONO_METHOD_ATTR_SPECIAL_NAME;
		public static const Int32 MONO_METHOD_ATTR_PINVOKE_IMPL;
		public static const Int32 MONO_METHOD_ATTR_UNMANAGED_EXPORT;
		public static const Int32 MONO_METHOD_ATTR_RESERVED_MASK;
		public static const Int32 MONO_METHOD_ATTR_RT_SPECIAL_NAME;
		public static const Int32 MONO_METHOD_ATTR_HAS_SECURITY;
		public static const Int32 MONO_METHOD_ATTR_REQUIRE_SEC_OBJECT;
		public static const Int32 MONO_METHOD_IMPL_ATTR_CODE_TYPE_MASK;
		public static const Int32 MONO_METHOD_IMPL_ATTR_IL;
		public static const Int32 MONO_METHOD_IMPL_ATTR_NATIVE;
		public static const Int32 MONO_METHOD_IMPL_ATTR_OPTIL;
		public static const Int32 MONO_METHOD_IMPL_ATTR_RUNTIME;
		public static const Int32 MONO_METHOD_IMPL_ATTR_MANAGED_MASK;
		public static const Int32 MONO_METHOD_IMPL_ATTR_UNMANAGED;
		public static const Int32 MONO_METHOD_IMPL_ATTR_MANAGED;
		public static const Int32 MONO_METHOD_IMPL_ATTR_FORWARD_REF;
		public static const Int32 MONO_METHOD_IMPL_ATTR_PRESERVE_SIG;
		public static const Int32 MONO_METHOD_IMPL_ATTR_INTERNAL_CALL;
		public static const Int32 MONO_METHOD_IMPL_ATTR_SYNCHRONIZED;
		public static const Int32 MONO_METHOD_IMPL_ATTR_NOINLINING;
		public static const Int32 MONO_METHOD_IMPL_ATTR_NOOPTIMIZATION;
		public static const Int32 MONO_METHOD_IMPL_ATTR_MAX_METHOD_IMPL_VAL;
		public static const Int32 MONO_METHOD_SEMANTIC_SETTER;
		public static const Int32 MONO_METHOD_SEMANTIC_GETTER;
		public static const Int32 MONO_METHOD_SEMANTIC_OTHER;
		public static const Int32 MONO_METHOD_SEMANTIC_ADD_ON;
		public static const Int32 MONO_METHOD_SEMANTIC_REMOVE_ON;
		public static const Int32 MONO_METHOD_SEMANTIC_FIRE;
		public static const Int32 MONO_PARAM_ATTR_IN;
		public static const Int32 MONO_PARAM_ATTR_OUT;
		public static const Int32 MONO_PARAM_ATTR_OPTIONAL;
		public static const Int32 MONO_PARAM_ATTR_RESERVED_MASK;
		public static const Int32 MONO_PARAM_ATTR_HAS_DEFAULT;
		public static const Int32 MONO_PARAM_ATTR_HAS_MARSHAL;
		public static const Int32 MONO_PARAM_ATTR_UNUSED;
		public static const Int32 MONO_PROPERTY_ATTR_SPECIAL_NAME;
		public static const Int32 MONO_PROPERTY_ATTR_RESERVED_MASK;
		public static const Int32 MONO_PROPERTY_ATTR_RT_SPECIAL_NAME;
		public static const Int32 MONO_PROPERTY_ATTR_HAS_DEFAULT;
		public static const Int32 MONO_PROPERTY_ATTR_UNUSED;
		public static const Int32 MONO_TYPE_ATTR_VISIBILITY_MASK;
		public static const Int32 MONO_TYPE_ATTR_NOT_PUBLIC;
		public static const Int32 MONO_TYPE_ATTR_PUBLIC;
		public static const Int32 MONO_TYPE_ATTR_NESTED_PUBLIC;
		public static const Int32 MONO_TYPE_ATTR_NESTED_PRIVATE;
		public static const Int32 MONO_TYPE_ATTR_NESTED_FAMILY;
		public static const Int32 MONO_TYPE_ATTR_NESTED_ASSEMBLY;
		public static const Int32 MONO_TYPE_ATTR_NESTED_FAM_AND_ASSEM;
		public static const Int32 MONO_TYPE_ATTR_NESTED_FAM_OR_ASSEM;
		public static const Int32 MONO_TYPE_ATTR_LAYOUT_MASK;
		public static const Int32 MONO_TYPE_ATTR_AUTO_LAYOUT;
		public static const Int32 MONO_TYPE_ATTR_SEQUENTIAL_LAYOUT;
		public static const Int32 MONO_TYPE_ATTR_EXPLICIT_LAYOUT;
		public static const Int32 MONO_TYPE_ATTR_CLASS_SEMANTIC_MASK;
		public static const Int32 MONO_TYPE_ATTR_CLASS;
		public static const Int32 MONO_TYPE_ATTR_INTERFACE;
		public static const Int32 MONO_TYPE_ATTR_ABSTRACT;
		public static const Int32 MONO_TYPE_ATTR_SEALED;
		public static const Int32 MONO_TYPE_ATTR_SPECIAL_NAME;
		public static const Int32 MONO_TYPE_ATTR_IMPORT;
		public static const Int32 MONO_TYPE_ATTR_SERIALIZABLE;
		public static const Int32 MONO_TYPE_ATTR_STRING_FORMAT_MASK;
		public static const Int32 MONO_TYPE_ATTR_ANSI_CLASS;
		public static const Int32 MONO_TYPE_ATTR_UNICODE_CLASS;
		public static const Int32 MONO_TYPE_ATTR_AUTO_CLASS;
		public static const Int32 MONO_TYPE_ATTR_CUSTOM_CLASS;
		public static const Int32 MONO_TYPE_ATTR_CUSTOM_MASK;
		public static const Int32 MONO_TYPE_ATTR_BEFORE_FIELD_INIT;
		public static const Int32 MONO_TYPE_ATTR_FORWARDER;
		public static const Int32 MONO_TYPE_ATTR_RESERVED_MASK;
		public static const Int32 MONO_TYPE_ATTR_RT_SPECIAL_NAME;
		public static const Int32 MONO_TYPE_ATTR_HAS_SECURITY;
		public static AnsiChar* mono_disasm_code_one(MonoDisHelper* dh, MonoMethod* method, mono_byte* ip, mono_byte** endp);
		public static AnsiChar* mono_disasm_code(MonoDisHelper* dh, MonoMethod* method, mono_byte* ip, mono_byte* end);
		public static AnsiChar* mono_type_full_name(MonoType* type);
		public static AnsiChar* mono_signature_get_desc(MonoMethodSignature* sig, mono_bool include_namespace);
		public static AnsiChar* mono_context_get_desc(MonoGenericContext* context);
		public static MonoMethodDesc* mono_method_desc_new(AnsiChar* name, mono_bool include_namespace);
		public static MonoMethodDesc* mono_method_desc_from_method(MonoMethod* method);
		public static Void mono_method_desc_free(MonoMethodDesc* desc);
		public static mono_bool mono_method_desc_match(MonoMethodDesc* desc, MonoMethod* method);
		public static mono_bool mono_method_desc_full_match(MonoMethodDesc* desc, MonoMethod* method);
		public static MonoMethod* mono_method_desc_search_in_class(MonoMethodDesc* desc, MonoClass* klass);
		public static MonoMethod* mono_method_desc_search_in_image(MonoMethodDesc* desc, MonoImage* image);
		public static AnsiChar* mono_method_full_name(MonoMethod* method, mono_bool signature);
		public static AnsiChar* mono_field_full_name(MonoClassField* field);
		public static int32_t mono_environment_exitcode_get();
		public static Void mono_environment_exitcode_set(int32_t @value);
		public static AnsiChar* mono_config_get_os();
		public static AnsiChar* mono_config_get_cpu();
		public static AnsiChar* mono_config_get_wordsize();
		public static AnsiChar* mono_get_config_dir();
		public static Void mono_set_config_dir(AnsiChar* dir);
		public static AnsiChar* mono_get_machine_config();
		public static Void mono_config_cleanup();
		public static Void mono_config_parse(AnsiChar* filename);
		public static Void mono_config_for_assembly(MonoImage* @assembly);
		public static Void mono_config_parse_memory(AnsiChar* buffer);
		public static AnsiChar* mono_config_string_for_assembly_file(AnsiChar* filename);
		public static Void mono_config_set_server_mode(mono_bool server_mode);
		public static mono_bool mono_config_is_server_mode();
		public static mono_bool mono_debug_enabled();
		public static Void mono_debug_init(mono.metadata.MonoDebugFormat format);
		public static Void mono_debug_open_image_from_memory(MonoImage* image, mono_byte* raw_contents, Int32 size);
		public static Void mono_debug_cleanup();
		public static Void mono_debug_close_image(MonoImage* image);
		public static Void mono_debug_domain_unload(MonoDomain* domain);
		public static Void mono_debug_domain_create(MonoDomain* domain);
		public static MonoDebugMethodAddress* mono_debug_add_method(MonoMethod* method, MonoDebugMethodJitInfo* jit, MonoDomain* domain);
		public static Void mono_debug_remove_method(MonoMethod* method, MonoDomain* domain);
		public static MonoDebugMethodInfo* mono_debug_lookup_method(MonoMethod* method);
		public static MonoDebugMethodAddressList* mono_debug_lookup_method_addresses(MonoMethod* method);
		public static MonoDebugMethodJitInfo* mono_debug_find_method(MonoMethod* method, MonoDomain* domain);
		public static Void mono_debug_free_method_jit_info(MonoDebugMethodJitInfo* jit);
		public static Void mono_debug_add_delegate_trampoline(Void* code, Int32 size);
		public static MonoDebugLocalsInfo* mono_debug_lookup_locals(MonoMethod* method);
		public static MonoDebugSourceLocation* mono_debug_method_lookup_location(MonoDebugMethodInfo* minfo, Int32 il_offset);
		public static MonoDebugSourceLocation* mono_debug_lookup_source_location(MonoMethod* method, uint32_t address, MonoDomain* domain);
		public static int32_t mono_debug_il_offset_from_address(MonoMethod* method, MonoDomain* domain, uint32_t native_offset);
		public static Void mono_debug_free_source_location(MonoDebugSourceLocation* location);
		public static AnsiChar* mono_debug_print_stack_frame(MonoMethod* method, uint32_t native_offset, MonoDomain* domain);
		public static Int32 mono_debugger_method_has_breakpoint(MonoMethod* method);
		public static Int32 mono_debugger_insert_breakpoint(AnsiChar* method_name, mono_bool include_namespace);
		public static Void mono_set_is_debugger_attached(mono_bool attached);
		public static mono_bool mono_is_debugger_attached();
		public static Void mono_gc_collect(Int32 generation);
		public static Int32 mono_gc_max_generation();
		public static Int32 mono_gc_get_generation(mono.metadata.MonoObject* @object);
		public static Int32 mono_gc_collection_count(Int32 generation);
		public static int64_t mono_gc_get_used_size();
		public static int64_t mono_gc_get_heap_size();
		public static MonoBoolean mono_gc_pending_finalizers();
		public static Void mono_gc_finalize_notify();
		public static Int32 mono_gc_invoke_finalizers();
		public static Int32 mono_gc_walk_heap(Int32 flags, [FunctionPointer] delegate Int32 (mono.metadata.MonoObject* obj, MonoClass* klass, uintptr_t size, uintptr_t num, mono.metadata.MonoObject** refs, uintptr_t* offsets, Void* data) callback, Void* data);
		public static const Int32 MONO_FLOW_NEXT;
		public static const Int32 MONO_FLOW_BRANCH;
		public static const Int32 MONO_FLOW_COND_BRANCH;
		public static const Int32 MONO_FLOW_ERROR;
		public static const Int32 MONO_FLOW_CALL;
		public static const Int32 MONO_FLOW_RETURN;
		public static const Int32 MONO_FLOW_META;
		public static const Int32 MonoInlineNone;
		public static const Int32 MonoInlineType;
		public static const Int32 MonoInlineField;
		public static const Int32 MonoInlineMethod;
		public static const Int32 MonoInlineTok;
		public static const Int32 MonoInlineString;
		public static const Int32 MonoInlineSig;
		public static const Int32 MonoInlineVar;
		public static const Int32 MonoShortInlineVar;
		public static const Int32 MonoInlineBrTarget;
		public static const Int32 MonoShortInlineBrTarget;
		public static const Int32 MonoInlineSwitch;
		public static const Int32 MonoInlineR;
		public static const Int32 MonoShortInlineR;
		public static const Int32 MonoInlineI;
		public static const Int32 MonoShortInlineI;
		public static const Int32 MonoInlineI8;
		public static mono.metadata.MonoOpcode* mono_opcodes;
		public static AnsiChar* mono_opcode_name(Int32 opcode);
		public static mono.metadata.MonoOpcodeEnum mono_opcode_value(mono_byte** ip, mono_byte* end);
		public static Void mono_profiler_install(MonoProfiler* prof, [FunctionPointer] delegate Void (MonoProfiler* prof) shutdown_callback);
		public static Void mono_profiler_set_events(mono.metadata.MonoProfileFlags events);
		public static mono.metadata.MonoProfileFlags mono_profiler_get_events();
		public static Void mono_profiler_install_appdomain([FunctionPointer] delegate Void (MonoProfiler* prof, MonoDomain* domain) start_load, [FunctionPointer] delegate Void (MonoProfiler* prof, MonoDomain* domain, Int32 result) end_load, [FunctionPointer] delegate Void (MonoProfiler* prof, MonoDomain* domain) start_unload, [FunctionPointer] delegate Void (MonoProfiler* prof, MonoDomain* domain) end_unload);
		public static Void mono_profiler_install_appdomain_name([FunctionPointer] delegate Void (MonoProfiler* prof, MonoDomain* domain, AnsiChar* name) domain_name_cb);
		public static Void mono_profiler_install_context([FunctionPointer] delegate Void (MonoProfiler* prof, MonoAppContext* context) load, [FunctionPointer] delegate Void (MonoProfiler* prof, MonoAppContext* context) unload);
		public static Void mono_profiler_install_assembly([FunctionPointer] delegate Void (MonoProfiler* prof, MonoAssembly* @assembly) start_load, [FunctionPointer] delegate Void (MonoProfiler* prof, MonoAssembly* @assembly, Int32 result) end_load, [FunctionPointer] delegate Void (MonoProfiler* prof, MonoAssembly* @assembly) start_unload, [FunctionPointer] delegate Void (MonoProfiler* prof, MonoAssembly* @assembly) end_unload);
		public static Void mono_profiler_install_module([FunctionPointer] delegate Void (MonoProfiler* prof, MonoImage* @module) start_load, [FunctionPointer] delegate Void (MonoProfiler* prof, MonoImage* @module, Int32 result) end_load, [FunctionPointer] delegate Void (MonoProfiler* prof, MonoImage* @module) start_unload, [FunctionPointer] delegate Void (MonoProfiler* prof, MonoImage* @module) end_unload);
		public static Void mono_profiler_install_class([FunctionPointer] delegate Void (MonoProfiler* prof, MonoClass* klass) start_load, [FunctionPointer] delegate Void (MonoProfiler* prof, MonoClass* klass, Int32 result) end_load, [FunctionPointer] delegate Void (MonoProfiler* prof, MonoClass* klass) start_unload, [FunctionPointer] delegate Void (MonoProfiler* prof, MonoClass* klass) end_unload);
		public static Void mono_profiler_install_jit_compile([FunctionPointer] delegate Void (MonoProfiler* prof, MonoMethod* method) start, [FunctionPointer] delegate Void (MonoProfiler* prof, MonoMethod* method, Int32 result) end);
		public static Void mono_profiler_install_jit_end([FunctionPointer] delegate Void (MonoProfiler* prof, MonoMethod* method, MonoJitInfo* jinfo, Int32 result) end);
		public static Void mono_profiler_install_method_free([FunctionPointer] delegate Void (MonoProfiler* prof, MonoMethod* method) callback);
		public static Void mono_profiler_install_method_invoke([FunctionPointer] delegate Void (MonoProfiler* prof, MonoMethod* method) start, [FunctionPointer] delegate Void (MonoProfiler* prof, MonoMethod* method) end);
		public static Void mono_profiler_install_enter_leave([FunctionPointer] delegate Void (MonoProfiler* prof, MonoMethod* method) enter, [FunctionPointer] delegate Void (MonoProfiler* prof, MonoMethod* method) fleave);
		public static Void mono_profiler_install_thread([FunctionPointer] delegate Void (MonoProfiler* prof, uintptr_t tid) start, [FunctionPointer] delegate Void (MonoProfiler* prof, uintptr_t tid) end);
		public static Void mono_profiler_install_thread_name([FunctionPointer] delegate Void (MonoProfiler* prof, uintptr_t tid, AnsiChar* name) thread_name_cb);
		public static Void mono_profiler_install_transition([FunctionPointer] delegate Void (MonoProfiler* prof, MonoMethod* method, Int32 result) callback);
		public static Void mono_profiler_install_allocation([FunctionPointer] delegate Void (MonoProfiler* prof, mono.metadata.MonoObject* obj, MonoClass* klass) callback);
		public static Void mono_profiler_install_monitor([FunctionPointer] delegate Void (MonoProfiler* prof, mono.metadata.MonoObject* obj, mono.metadata.MonoProfilerMonitorEvent @event) callback);
		public static Void mono_profiler_install_statistical([FunctionPointer] delegate Void (MonoProfiler* prof, mono_byte* ip, Void* context) callback);
		public static Void mono_profiler_install_statistical_call_chain([FunctionPointer] delegate Void (MonoProfiler* prof, Int32 call_chain_depth, mono_byte** ip, Void* context) callback, Int32 call_chain_depth, mono.metadata.MonoProfilerCallChainStrategy call_chain_strategy);
		public static Void mono_profiler_install_exception([FunctionPointer] delegate Void (MonoProfiler* prof, mono.metadata.MonoObject* @object) throw_callback, [FunctionPointer] delegate Void (MonoProfiler* prof, MonoMethod* method) exc_method_leave, [FunctionPointer] delegate Void (MonoProfiler* prof, MonoMethod* method, Int32 clause_type, Int32 clause_num) clause_callback);
		public static Void mono_profiler_install_coverage_filter([FunctionPointer] delegate mono_bool (MonoProfiler* prof, MonoMethod* method) callback);
		public static Void mono_profiler_coverage_get(MonoProfiler* prof, MonoMethod* method, [FunctionPointer] delegate Void (MonoProfiler* prof, mono.metadata.MonoProfileCoverageEntry* entry) func);
		public static Void mono_profiler_install_gc([FunctionPointer] delegate Void (MonoProfiler* prof, mono.metadata.MonoGCEvent @event, Int32 generation) callback, [FunctionPointer] delegate Void (MonoProfiler* prof, int64_t new_size) heap_resize_callback);
		public static Void mono_profiler_install_gc_moves([FunctionPointer] delegate Void (MonoProfiler* prof, Void** objects, Int32 num) callback);
		public static Void mono_profiler_install_gc_roots([FunctionPointer] delegate Void (MonoProfiler* prof, Int32 op, Int32 type, uintptr_t handle, mono.metadata.MonoObject* obj) handle_callback, [FunctionPointer] delegate Void (MonoProfiler* prof, Int32 num_roots, Void** objects, Int32* root_types, uintptr_t* extra_info) roots_callback);
		public static Void mono_profiler_install_gc_finalize([FunctionPointer] delegate Void (MonoProfiler* prof) begin, [FunctionPointer] delegate Void (MonoProfiler* prof, mono.metadata.MonoObject* obj) begin_obj, [FunctionPointer] delegate Void (MonoProfiler* prof, mono.metadata.MonoObject* obj) end_obj, [FunctionPointer] delegate Void (MonoProfiler* prof) end);
		public static Void mono_profiler_install_runtime_initialized([FunctionPointer] delegate Void (MonoProfiler* prof) runtime_initialized_callback);
		public static Void mono_profiler_install_code_chunk_new([FunctionPointer] delegate Void (MonoProfiler* prof, Void* chunk, Int32 size) callback);
		public static Void mono_profiler_install_code_chunk_destroy([FunctionPointer] delegate Void (MonoProfiler* prof, Void* chunk) callback);
		public static Void mono_profiler_install_code_buffer_new([FunctionPointer] delegate Void (MonoProfiler* prof, Void* buffer, Int32 size, mono.metadata.MonoProfilerCodeBufferType type, Void* data) callback);
		public static Void mono_profiler_install_iomap([FunctionPointer] delegate Void (MonoProfiler* prof, AnsiChar* report, AnsiChar* pathname, AnsiChar* new_pathname) callback);
		public static Void mono_profiler_load(AnsiChar* desc);
		public static Void mono_profiler_set_statistical_mode(mono.metadata.MonoProfileSamplingMode mode, int64_t sampling_frequency_hz);
		public static Void mono_thread_init([FunctionPointer] delegate Void (intptr_t tid, Void* stack_start, Void* func) start_cb, [FunctionPointer] delegate Void (intptr_t tid, Void* stack_start) attach_cb);
		public static Void mono_thread_cleanup();
		public static Void mono_thread_manage();
		public static MonoThread* mono_thread_current();
		public static Void mono_thread_set_main(MonoThread* thread);
		public static MonoThread* mono_thread_get_main();
		public static Void mono_thread_stop(MonoThread* thread);
		public static Void mono_thread_new_init(intptr_t tid, Void* stack_start, Void* func);
		public static Void mono_thread_create(MonoDomain* domain, Void* func, Void* arg);
		public static MonoThread* mono_thread_attach(MonoDomain* domain);
		public static Void mono_thread_detach(MonoThread* thread);
		public static Void mono_thread_exit();
		public static AnsiChar* mono_thread_get_name_utf8(MonoThread* thread);
		public static int32_t mono_thread_get_managed_id(MonoThread* thread);
		public static Void mono_thread_set_manage_callback(MonoThread* thread, [FunctionPointer] delegate mono_bool (MonoThread* thread) func);
		public static Void mono_threads_set_default_stacksize(uint32_t stacksize);
		public static uint32_t mono_threads_get_default_stacksize();
		public static Void mono_threads_request_thread_dump();
		public static mono_bool mono_thread_is_foreign(MonoThread* thread);
		public static mono_bool mono_thread_detach_if_exiting();
		public static const Int32 MONO_TABLE_LAST;
		public static const Int32 MONO_TABLE_NUM;
		public static mono.metadata.MonoMarshalConv MONO_MARSHAL_CONV_INVALID();
		public static const Int32 _MONO_METADATA_LOADER_H_;
		public static const Int32 MONO_DECLSEC_ACTION_MIN;
		public static const Int32 MONO_DECLSEC_ACTION_MAX;
		public static const Int32 MONO_DEBUG_VAR_ADDRESS_MODE_FLAGS;
		public static const Int32 MONO_DEBUG_VAR_ADDRESS_MODE_REGISTER;
		public static const Int32 MONO_DEBUG_VAR_ADDRESS_MODE_REGOFFSET;
		public static const Int32 MONO_DEBUG_VAR_ADDRESS_MODE_TWO_REGISTERS;
		public static const Int32 MONO_DEBUG_VAR_ADDRESS_MODE_DEAD;
		public static const Int32 MONO_DEBUG_VAR_ADDRESS_MODE_REGOFFSET_INDIR;
		public static const Int32 MONO_DEBUG_VAR_ADDRESS_MODE_GSHAREDVT_LOCAL;
		public static const Int32 MONO_DEBUG_VAR_ADDRESS_MODE_VTADDR;
		public static const Int32 MONO_DEBUGGER_MAJOR_VERSION;
		public static const Int32 MONO_DEBUGGER_MINOR_VERSION;
		public static const UInt64 MONO_DEBUGGER_MAGIC;
		public static const Int32 MONO_CUSTOM_PREFIX;
		public static const Int32 MONO_PROFILER_MAX_STAT_CALL_CHAIN_DEPTH;
	}

	using MonoImage = Void;

	using MonoAssembly = Void;

	using MonoAssemblyName = Void;

	using MonoTableInfo = Void;

	enum mono.metadata.MonoImageOpenStatus
	{
		MONO_IMAGE_OK = 0,
		MONO_IMAGE_ERROR_ERRNO = 1,
		MONO_IMAGE_MISSING_ASSEMBLYREF = 2,
		MONO_IMAGE_IMAGE_INVALID = 3
	}

	using MonoClass = Void;

	using MonoDomain = Void;

	using MonoMethod = Void;

	enum mono.metadata.MonoExceptionEnum
	{
		MONO_EXCEPTION_CLAUSE_NONE = 0,
		MONO_EXCEPTION_CLAUSE_FILTER = 1,
		MONO_EXCEPTION_CLAUSE_FINALLY = 2,
		MONO_EXCEPTION_CLAUSE_FAULT = 4
	}

	enum mono.metadata.MonoCallConvention
	{
		MONO_CALL_DEFAULT = 0,
		MONO_CALL_C = 1,
		MONO_CALL_STDCALL = 2,
		MONO_CALL_THISCALL = 3,
		MONO_CALL_FASTCALL = 4,
		MONO_CALL_VARARG = 5
	}

	enum mono.metadata.MonoMarshalNative
	{
		MONO_NATIVE_BOOLEAN = 2,
		MONO_NATIVE_I1 = 3,
		MONO_NATIVE_U1 = 4,
		MONO_NATIVE_I2 = 5,
		MONO_NATIVE_U2 = 6,
		MONO_NATIVE_I4 = 7,
		MONO_NATIVE_U4 = 33,
		MONO_NATIVE_I8 = 35,
		MONO_NATIVE_U8 = 36,
		MONO_NATIVE_R4 = 32,
		MONO_NATIVE_R8 = 34,
		MONO_NATIVE_CURRENCY = 8,
		MONO_NATIVE_BSTR = 43,
		MONO_NATIVE_LPSTR = 44,
		MONO_NATIVE_LPWSTR = 45,
		MONO_NATIVE_LPTSTR = 46,
		MONO_NATIVE_BYVALTSTR = 58,
		MONO_NATIVE_IUNKNOWN = 47,
		MONO_NATIVE_IDISPATCH = 59,
		MONO_NATIVE_STRUCT = 48,
		MONO_NATIVE_INTERFACE = 27,
		MONO_NATIVE_SAFEARRAY = 49,
		MONO_NATIVE_BYVALARRAY = 50,
		MONO_NATIVE_INT = 51,
		MONO_NATIVE_UINT = 52,
		MONO_NATIVE_VBBYREFSTR = 60,
		MONO_NATIVE_ANSIBSTR = 61,
		MONO_NATIVE_TBSTR = 62,
		MONO_NATIVE_VARIANTBOOL = 63,
		MONO_NATIVE_FUNC = 64,
		MONO_NATIVE_ASANY = 66,
		MONO_NATIVE_LPARRAY = 68,
		MONO_NATIVE_LPSTRUCT = 69,
		MONO_NATIVE_CUSTOM = 70,
		MONO_NATIVE_ERROR = 71,
		MONO_NATIVE_MAX = 82
	}

	enum mono.metadata.MonoMarshalVariant
	{
		MONO_VARIANT_EMPTY = 0,
		MONO_VARIANT_NULL = 1,
		MONO_VARIANT_I2 = 2,
		MONO_VARIANT_I4 = 3,
		MONO_VARIANT_R4 = 4,
		MONO_VARIANT_R8 = 5,
		MONO_VARIANT_CY = 6,
		MONO_VARIANT_DATE = 7,
		MONO_VARIANT_BSTR = 33,
		MONO_VARIANT_DISPATCH = 35,
		MONO_VARIANT_ERROR = 36,
		MONO_VARIANT_BOOL = 32,
		MONO_VARIANT_VARIANT = 34,
		MONO_VARIANT_UNKNOWN = 38,
		MONO_VARIANT_DECIMAL = 39,
		MONO_VARIANT_I1 = 40,
		MONO_VARIANT_UI1 = 41,
		MONO_VARIANT_UI2 = 42,
		MONO_VARIANT_UI4 = 43,
		MONO_VARIANT_I8 = 44,
		MONO_VARIANT_UI8 = 45,
		MONO_VARIANT_INT = 46,
		MONO_VARIANT_UINT = 58,
		MONO_VARIANT_VOID = 21,
		MONO_VARIANT_HRESULT = 47,
		MONO_VARIANT_PTR = 59,
		MONO_VARIANT_SAFEARRAY = 48,
		MONO_VARIANT_CARRAY = 27,
		MONO_VARIANT_USERDEFINED = 49,
		MONO_VARIANT_LPSTR = 50,
		MONO_VARIANT_LPWSTR = 51,
		MONO_VARIANT_RECORD = 62,
		MONO_VARIANT_FILETIME = 54,
		MONO_VARIANT_BLOB = 55,
		MONO_VARIANT_STREAM = 83,
		MONO_VARIANT_STORAGE = 84,
		MONO_VARIANT_STREAMED_OBJECT = 85,
		MONO_VARIANT_STORED_OBJECT = 56,
		MONO_VARIANT_BLOB_OBJECT = 86,
		MONO_VARIANT_CF = 87,
		MONO_VARIANT_CLSID = 88,
		MONO_VARIANT_VECTOR = 15,
		MONO_VARIANT_ARRAY = 16,
		MONO_VARIANT_BYREF = 17
	}

	enum mono.metadata.MonoMarshalConv
	{
		MONO_MARSHAL_CONV_NONE = 0,
		MONO_MARSHAL_CONV_BOOL_VARIANTBOOL = 1,
		MONO_MARSHAL_CONV_BOOL_I4 = 2,
		MONO_MARSHAL_CONV_STR_BSTR = 3,
		MONO_MARSHAL_CONV_STR_LPSTR = 4,
		MONO_MARSHAL_CONV_LPSTR_STR = 5,
		MONO_MARSHAL_CONV_LPTSTR_STR = 6,
		MONO_MARSHAL_CONV_STR_LPWSTR = 7,
		MONO_MARSHAL_CONV_LPWSTR_STR = 33,
		MONO_MARSHAL_CONV_STR_LPTSTR = 35,
		MONO_MARSHAL_CONV_STR_ANSIBSTR = 36,
		MONO_MARSHAL_CONV_STR_TBSTR = 32,
		MONO_MARSHAL_CONV_STR_BYVALSTR = 34,
		MONO_MARSHAL_CONV_STR_BYVALWSTR = 38,
		MONO_MARSHAL_CONV_SB_LPSTR = 39,
		MONO_MARSHAL_CONV_SB_LPTSTR = 8,
		MONO_MARSHAL_CONV_SB_LPWSTR = 40,
		MONO_MARSHAL_CONV_LPSTR_SB = 41,
		MONO_MARSHAL_CONV_LPTSTR_SB = 42,
		MONO_MARSHAL_CONV_LPWSTR_SB = 43,
		MONO_MARSHAL_CONV_ARRAY_BYVALARRAY = 44,
		MONO_MARSHAL_CONV_ARRAY_BYVALCHARARRAY = 45,
		MONO_MARSHAL_CONV_ARRAY_SAVEARRAY = 46,
		MONO_MARSHAL_CONV_ARRAY_LPARRAY = 58,
		MONO_MARSHAL_FREE_LPARRAY = 21,
		MONO_MARSHAL_CONV_OBJECT_INTERFACE = 47,
		MONO_MARSHAL_CONV_OBJECT_IDISPATCH = 59,
		MONO_MARSHAL_CONV_OBJECT_IUNKNOWN = 48,
		MONO_MARSHAL_CONV_OBJECT_STRUCT = 27,
		MONO_MARSHAL_CONV_DEL_FTN = 49,
		MONO_MARSHAL_CONV_FTN_DEL = 50,
		MONO_MARSHAL_FREE_ARRAY = 51,
		MONO_MARSHAL_CONV_BSTR_STR = 52,
		MONO_MARSHAL_CONV_SAFEHANDLE = 53,
		MONO_MARSHAL_CONV_HANDLEREF = 60
	}

	struct mono.metadata.MonoMarshalSpec
	{
		public mono.metadata.MonoMarshalNative native;
		// Union
		public struct __AnonymousType1
		{
			public struct __AnonymousType1
			{
				public mono.metadata.MonoMarshalNative elem_type;
				public int32_t num_elem;
				public int16_t param_num;
				public int16_t elem_mult;
			}
			public __AnonymousType1 array_data;
			public struct __AnonymousType2
			{
				public AnsiChar* custom_name;
				public AnsiChar* cookie;
				public MonoImage* image;
			}
			public __AnonymousType2 custom_data;
			public struct __AnonymousType3
			{
				public mono.metadata.MonoMarshalVariant elem_type;
				public int32_t num_elem;
			}
			public __AnonymousType3 safearray_data;
		}
		public __AnonymousType1 data;
	}

	struct mono.metadata.MonoExceptionClause
	{
		public uint32_t flags;
		public uint32_t try_offset;
		public uint32_t try_len;
		public uint32_t handler_offset;
		public uint32_t handler_len;
		// Union
		public struct __AnonymousType5
		{
			public uint32_t filter_offset;
			public MonoClass* catch_class;
		}
		public __AnonymousType5 data;
	}

	using MonoType = Void;

	using MonoGenericInst = Void;

	using MonoGenericClass = Void;

	using MonoGenericContext = Void;

	using MonoGenericContainer = Void;

	using MonoGenericParam = Void;

	using MonoArrayType = mono.metadata.__struct__MonoArrayType;

	using MonoMethodSignature = Void;

	using MonoGenericMethod = Void;

	struct mono.metadata.MonoCustomMod
	{
		public UInt32 required;
		public UInt32 token;
	}

	struct mono.metadata.__struct__MonoArrayType
	{
		public MonoClass* eklass;
		public uint8_t rank;
		public uint8_t numsizes;
		public uint8_t numlobounds;
		public Int32* sizes;
		public Int32* lobounds;
	}

	using MonoMethodHeader = Void;

	enum mono.metadata.MonoParseTypeMode
	{
		MONO_PARSE_TYPE = 0,
		MONO_PARSE_MOD_TYPE = 1,
		MONO_PARSE_LOCAL = 2,
		MONO_PARSE_PARAM = 3,
		MONO_PARSE_RET = 4,
		MONO_PARSE_FIELD = 5
	}

	delegate mono_bool mono.metadata.MonoStackWalk (MonoMethod* method, int32_t native_offset, int32_t il_offset, mono_bool managed, Void* data);

	delegate mono_bool mono.metadata.MonoStackWalkAsyncSafe (MonoMethod* method, MonoDomain* domain, Void* base_address, Int32 offset, Void* data);

	using MonoVTable = Void;

	using MonoClassField = Void;

	using MonoProperty = Void;

	using MonoEvent = Void;

	using MonoBoolean = mono_byte;

	using MonoString = Void;

	using MonoArray = Void;

	using MonoReflectionMethod = Void;

	using MonoReflectionAssembly = Void;

	using MonoReflectionModule = Void;

	using MonoReflectionField = Void;

	using MonoReflectionProperty = Void;

	using MonoReflectionEvent = Void;

	using MonoReflectionType = Void;

	using MonoDelegate = Void;

	using MonoException = Void;

	using MonoThreadsSync = Void;

	using MonoThread = Void;

	using MonoDynamicAssembly = Void;

	using MonoDynamicImage = Void;

	using MonoReflectionMethodBody = Void;

	using MonoAppContext = Void;

	struct mono.metadata.MonoObject
	{
		public MonoVTable* vtable;
		public MonoThreadsSync* synchronisation;
	}

	struct mono.metadata.MonoObject
	{
		public MonoVTable* vtable;
		public MonoThreadsSync* synchronisation;
	}

	delegate mono.metadata.MonoObject* mono.metadata.MonoInvokeFunc (MonoMethod* method, Void* obj, Void** @params, mono.metadata.MonoObject** exc, mono.utils.MonoError* error);

	delegate Void* mono.metadata.MonoCompileFunc (MonoMethod* method);

	delegate Void mono.metadata.MonoMainThreadFunc (Void* user_data);

	delegate Void mono.metadata.MonoMainThreadFunc (Void* user_data);

	using MonoReferenceQueue = Void;

	using MonoTypeNameParse = Void;

	struct mono.metadata.MonoCustomAttrEntry
	{
		public MonoMethod* ctor;
		public uint32_t data_size;
		public mono_byte* data;
	}

	struct mono.metadata.MonoCustomAttrInfo
	{
		public Int32 num_attrs;
		public Int32 cached;
		public MonoImage* image;
		public mono.metadata.MonoCustomAttrEntry[] attrs;
	}

	struct mono.metadata.MonoReflectionMethodAux
	{
		public AnsiChar** param_names;
		public mono.metadata.MonoMarshalSpec** param_marshall;
		public mono.metadata.MonoCustomAttrInfo** param_cattr;
		public uint8_t** param_defaults;
		public uint32_t* param_default_types;
		public AnsiChar* dllentry;
		public AnsiChar* dll;
	}

	enum mono.metadata.MonoResolveTokenError
	{
		ResolveTokenError_OutOfRange = 0,
		ResolveTokenError_BadTable = 1,
		ResolveTokenError_Other = 2
	}

	struct mono.metadata.MonoDeclSecurityEntry
	{
		public AnsiChar* blob;
		public uint32_t size;
		public uint32_t index;
	}

	struct mono.metadata.MonoDeclSecurityActions
	{
		public mono.metadata.MonoDeclSecurityEntry demand;
		public mono.metadata.MonoDeclSecurityEntry noncasdemand;
		public mono.metadata.MonoDeclSecurityEntry demandchoice;
	}

	delegate Void mono.metadata.MonoThreadStartCB (intptr_t tid, Void* stack_start, Void* func);

	delegate Void mono.metadata.MonoThreadAttachCB (intptr_t tid, Void* stack_start);

	using MonoAppDomain = Void;

	using MonoJitInfo = Void;

	delegate Void mono.metadata.MonoDomainFunc (MonoDomain* domain, Void* user_data);

	delegate mono_bool mono.metadata.MonoCoreClrPlatformCB (AnsiChar* image_name);

	delegate Void mono.metadata.MonoAssemblyLoadFunc (MonoAssembly* @assembly, Void* user_data);

	delegate MonoAssembly* mono.metadata.MonoAssemblySearchFunc (MonoAssemblyName* aname, Void* user_data);

	delegate MonoAssembly* mono.metadata.MonoAssemblyPreLoadFunc (MonoAssemblyName* aname, AnsiChar** assemblies_path, Void* user_data);

	struct mono.metadata.MonoBundledAssembly
	{
		public AnsiChar* name;
		public Byte* data;
		public UInt32 size;
	}

	using MonoDisHelper = mono.metadata.__struct_MonoDisHelper;

	delegate AnsiChar* mono.metadata.MonoDisIndenter (MonoDisHelper* dh, MonoMethod* method, uint32_t ip_offset);

	delegate AnsiChar* mono.metadata.MonoDisTokener (MonoDisHelper* dh, MonoMethod* method, uint32_t token);

	struct mono.metadata.__struct_MonoDisHelper
	{
		public AnsiChar* newline;
		public AnsiChar* label_format;
		public AnsiChar* label_target;
		public [FunctionPointer] delegate AnsiChar* (MonoDisHelper* dh, MonoMethod* method, uint32_t ip_offset) indenter;
		public [FunctionPointer] delegate AnsiChar* (MonoDisHelper* dh, MonoMethod* method, uint32_t token) tokener;
		public Void* user_data;
	}

	using MonoMethodDesc = Void;

	using MonoSymbolTable = mono.metadata.__struct__MonoSymbolTable;

	using MonoDebugDataTable = Void;

	using MonoSymbolFile = Void;

	using MonoPPDBFile = Void;

	using MonoDebugHandle = mono.metadata.__struct__MonoDebugHandle;

	using MonoDebugLineNumberEntry = Void;

	using MonoDebugVarInfo = mono.metadata.__struct__MonoDebugVarInfo;

	using MonoDebugMethodJitInfo = mono.metadata.__struct__MonoDebugMethodJitInfo;

	using MonoDebugMethodAddress = Void;

	using MonoDebugMethodAddressList = mono.metadata.__struct__MonoDebugMethodAddressList;

	using MonoDebugClassEntry = Void;

	using MonoDebugMethodInfo = Void;

	using MonoDebugLocalsInfo = Void;

	using MonoDebugSourceLocation = mono.metadata.__struct__MonoDebugSourceLocation;

	using MonoDebugList = mono.metadata.__struct__MonoDebugList;

	enum mono.metadata.MonoDebugFormat
	{
		MONO_DEBUG_FORMAT_NONE = 0,
		MONO_DEBUG_FORMAT_MONO = 1,
		MONO_DEBUG_FORMAT_DEBUGGER = 2
	}

	struct mono.metadata.__struct__MonoDebugList
	{
		public MonoDebugList* next;
		public Void* data;
	}

	struct mono.metadata.__struct__MonoSymbolTable
	{
		public uint64_t magic;
		public uint32_t version;
		public uint32_t total_size;
		public MonoDebugHandle* corlib;
		public MonoDebugDataTable* global_data_table;
		public MonoDebugList* data_tables;
		public MonoDebugList* symbol_files;
	}

	struct mono.metadata.__struct__MonoDebugHandle
	{
		public uint32_t index;
		public AnsiChar* image_file;
		public MonoImage* image;
		public MonoDebugDataTable* type_table;
		public MonoSymbolFile* symfile;
		public MonoPPDBFile* ppdb;
	}

	struct mono.metadata.__struct__MonoDebugMethodJitInfo
	{
		public mono_byte* code_start;
		public uint32_t code_size;
		public uint32_t prologue_end;
		public uint32_t epilogue_begin;
		public mono_byte* wrapper_addr;
		public uint32_t num_line_numbers;
		public MonoDebugLineNumberEntry* line_numbers;
		public uint32_t has_var_info;
		public uint32_t num_params;
		public MonoDebugVarInfo* this_var;
		public MonoDebugVarInfo* @params;
		public uint32_t num_locals;
		public MonoDebugVarInfo* locals;
		public MonoDebugVarInfo* gsharedvt_info_var;
		public MonoDebugVarInfo* gsharedvt_locals_var;
	}

	struct mono.metadata.__struct__MonoDebugMethodAddressList
	{
		public uint32_t size;
		public uint32_t count;
		public mono_byte[] data;
	}

	struct mono.metadata.__struct__MonoDebugSourceLocation
	{
		public AnsiChar* source_file;
		public uint32_t row;
		public uint32_t column;
		public uint32_t il_offset;
	}

	struct mono.metadata.__struct__MonoDebugVarInfo
	{
		public uint32_t index;
		public uint32_t offset;
		public uint32_t size;
		public uint32_t begin_scope;
		public uint32_t end_scope;
		public MonoType* type;
	}

	delegate Int32 mono.metadata.MonoGCReferences (mono.metadata.MonoObject* obj, MonoClass* klass, uintptr_t size, uintptr_t num, mono.metadata.MonoObject** refs, uintptr_t* offsets, Void* data);

	enum mono.metadata.MonoGCRootSource
	{
		MONO_ROOT_SOURCE_EXTERNAL = 0,
		MONO_ROOT_SOURCE_STACK = 1,
		MONO_ROOT_SOURCE_FINALIZER_QUEUE = 2,
		MONO_ROOT_SOURCE_STATIC = 3,
		MONO_ROOT_SOURCE_THREAD_STATIC = 4,
		MONO_ROOT_SOURCE_CONTEXT_STATIC = 5,
		MONO_ROOT_SOURCE_GC_HANDLE = 6,
		MONO_ROOT_SOURCE_JIT = 7,
		MONO_ROOT_SOURCE_THREADING = 33,
		MONO_ROOT_SOURCE_DOMAIN = 35,
		MONO_ROOT_SOURCE_REFLECTION = 36,
		MONO_ROOT_SOURCE_MARSHAL = 32,
		MONO_ROOT_SOURCE_THREAD_POOL = 34,
		MONO_ROOT_SOURCE_DEBUGGER = 38,
		MONO_ROOT_SOURCE_HANDLE = 39
	}

	enum mono.metadata.MonoOpcodeEnum
	{
		MONO_CEE_NOP = 0,
		MONO_CEE_BREAK = 1,
		MONO_CEE_LDARG_0 = 2,
		MONO_CEE_LDARG_1 = 3,
		MONO_CEE_LDARG_2 = 4,
		MONO_CEE_LDARG_3 = 5,
		MONO_CEE_LDLOC_0 = 6,
		MONO_CEE_LDLOC_1 = 7,
		MONO_CEE_LDLOC_2 = 33,
		MONO_CEE_LDLOC_3 = 35,
		MONO_CEE_STLOC_0 = 36,
		MONO_CEE_STLOC_1 = 32,
		MONO_CEE_STLOC_2 = 34,
		MONO_CEE_STLOC_3 = 38,
		MONO_CEE_LDARG_S = 39,
		MONO_CEE_LDARGA_S = 8,
		MONO_CEE_STARG_S = 40,
		MONO_CEE_LDLOC_S = 41,
		MONO_CEE_LDLOCA_S = 42,
		MONO_CEE_STLOC_S = 43,
		MONO_CEE_LDNULL = 44,
		MONO_CEE_LDC_I4_M1 = 45,
		MONO_CEE_LDC_I4_0 = 46,
		MONO_CEE_LDC_I4_1 = 58,
		MONO_CEE_LDC_I4_2 = 21,
		MONO_CEE_LDC_I4_3 = 47,
		MONO_CEE_LDC_I4_4 = 59,
		MONO_CEE_LDC_I4_5 = 48,
		MONO_CEE_LDC_I4_6 = 27,
		MONO_CEE_LDC_I4_7 = 49,
		MONO_CEE_LDC_I4_8 = 50,
		MONO_CEE_LDC_I4_S = 51,
		MONO_CEE_LDC_I4 = 52,
		MONO_CEE_LDC_I8 = 53,
		MONO_CEE_LDC_R4 = 60,
		MONO_CEE_LDC_R8 = 61,
		MONO_CEE_UNUSED99 = 62,
		MONO_CEE_DUP = 63,
		MONO_CEE_POP = 64,
		MONO_CEE_JMP = 65,
		MONO_CEE_CALL = 66,
		MONO_CEE_CALLI = 67,
		MONO_CEE_RET = 68,
		MONO_CEE_BR_S = 69,
		MONO_CEE_BRFALSE_S = 70,
		MONO_CEE_BRTRUE_S = 71,
		MONO_CEE_BEQ_S = 72,
		MONO_CEE_BGE_S = 73,
		MONO_CEE_BGT_S = 74,
		MONO_CEE_BLE_S = 75,
		MONO_CEE_BLT_S = 76,
		MONO_CEE_BNE_UN_S = 77,
		MONO_CEE_BGE_UN_S = 78,
		MONO_CEE_BGT_UN_S = 79,
		MONO_CEE_BLE_UN_S = 80,
		MONO_CEE_BLT_UN_S = 81,
		MONO_CEE_BR = 108,
		MONO_CEE_BRFALSE = 109,
		MONO_CEE_BRTRUE = 110,
		MONO_CEE_BEQ = 111,
		MONO_CEE_BGE = 112,
		MONO_CEE_BGT = 113,
		MONO_CEE_BLE = 114,
		MONO_CEE_BLT = 115,
		MONO_CEE_BNE_UN = 54,
		MONO_CEE_BGE_UN = 55,
		MONO_CEE_BGT_UN = 83,
		MONO_CEE_BLE_UN = 84,
		MONO_CEE_BLT_UN = 85,
		MONO_CEE_SWITCH = 56,
		MONO_CEE_LDIND_I1 = 86,
		MONO_CEE_LDIND_U1 = 87,
		MONO_CEE_LDIND_I2 = 88,
		MONO_CEE_LDIND_U2 = 116,
		MONO_CEE_LDIND_I4 = 117,
		MONO_CEE_LDIND_U4 = 118,
		MONO_CEE_LDIND_I8 = 119,
		MONO_CEE_LDIND_I = 120,
		MONO_CEE_LDIND_R4 = 121,
		MONO_CEE_LDIND_R8 = 122,
		MONO_CEE_LDIND_REF = 82,
		MONO_CEE_STIND_REF = 123,
		MONO_CEE_STIND_I1 = 124,
		MONO_CEE_STIND_I2 = 125,
		MONO_CEE_STIND_I4 = 126,
		MONO_CEE_STIND_I8 = 57,
		MONO_CEE_STIND_R4 = 127,
		MONO_CEE_STIND_R8 = 128,
		MONO_CEE_ADD = 129,
		MONO_CEE_SUB = 130,
		MONO_CEE_MUL = 131,
		MONO_CEE_DIV = 132,
		MONO_CEE_DIV_UN = 133,
		MONO_CEE_REM = 134,
		MONO_CEE_REM_UN = 135,
		MONO_CEE_AND = 136,
		MONO_CEE_OR = 137,
		MONO_CEE_XOR = 138,
		MONO_CEE_SHL = 139,
		MONO_CEE_SHR = 140,
		MONO_CEE_SHR_UN = 141,
		MONO_CEE_NEG = 142,
		MONO_CEE_NOT = 143,
		MONO_CEE_CONV_I1 = 144,
		MONO_CEE_CONV_I2 = 145,
		MONO_CEE_CONV_I4 = 146,
		MONO_CEE_CONV_I8 = 147,
		MONO_CEE_CONV_R4 = 148,
		MONO_CEE_CONV_R8 = 149,
		MONO_CEE_CONV_U4 = 150,
		MONO_CEE_CONV_U8 = 151,
		MONO_CEE_CALLVIRT = 152,
		MONO_CEE_CPOBJ = 153,
		MONO_CEE_LDOBJ = 154,
		MONO_CEE_LDSTR = 155,
		MONO_CEE_NEWOBJ = 156,
		MONO_CEE_CASTCLASS = 157,
		MONO_CEE_ISINST = 158,
		MONO_CEE_CONV_R_UN = 159,
		MONO_CEE_UNUSED58 = 160,
		MONO_CEE_UNUSED1 = 161,
		MONO_CEE_UNBOX = 162,
		MONO_CEE_THROW = 163,
		MONO_CEE_LDFLD = 164,
		MONO_CEE_LDFLDA = 165,
		MONO_CEE_STFLD = 166,
		MONO_CEE_LDSFLD = 167,
		MONO_CEE_LDSFLDA = 168,
		MONO_CEE_STSFLD = 9,
		MONO_CEE_STOBJ = 169,
		MONO_CEE_CONV_OVF_I1_UN = 170,
		MONO_CEE_CONV_OVF_I2_UN = 171,
		MONO_CEE_CONV_OVF_I4_UN = 172,
		MONO_CEE_CONV_OVF_I8_UN = 173,
		MONO_CEE_CONV_OVF_U1_UN = 174,
		MONO_CEE_CONV_OVF_U2_UN = 175,
		MONO_CEE_CONV_OVF_U4_UN = 176,
		MONO_CEE_CONV_OVF_U8_UN = 177,
		MONO_CEE_CONV_OVF_I_UN = 178,
		MONO_CEE_CONV_OVF_U_UN = 179,
		MONO_CEE_BOX = 180,
		MONO_CEE_NEWARR = 181,
		MONO_CEE_LDLEN = 182,
		MONO_CEE_LDELEMA = 183,
		MONO_CEE_LDELEM_I1 = 184,
		MONO_CEE_LDELEM_U1 = 185,
		MONO_CEE_LDELEM_I2 = 186,
		MONO_CEE_LDELEM_U2 = 187,
		MONO_CEE_LDELEM_I4 = 188,
		MONO_CEE_LDELEM_U4 = 189,
		MONO_CEE_LDELEM_I8 = 190,
		MONO_CEE_LDELEM_I = 191,
		MONO_CEE_LDELEM_R4 = 192,
		MONO_CEE_LDELEM_R8 = 193,
		MONO_CEE_LDELEM_REF = 194,
		MONO_CEE_STELEM_I = 195,
		MONO_CEE_STELEM_I1 = 196,
		MONO_CEE_STELEM_I2 = 197,
		MONO_CEE_STELEM_I4 = 198,
		MONO_CEE_STELEM_I8 = 199,
		MONO_CEE_STELEM_R4 = 200,
		MONO_CEE_STELEM_R8 = 201,
		MONO_CEE_STELEM_REF = 202,
		MONO_CEE_LDELEM = 203,
		MONO_CEE_STELEM = 204,
		MONO_CEE_UNBOX_ANY = 205,
		MONO_CEE_UNUSED5 = 206,
		MONO_CEE_UNUSED6 = 207,
		MONO_CEE_UNUSED7 = 208,
		MONO_CEE_UNUSED8 = 209,
		MONO_CEE_UNUSED9 = 210,
		MONO_CEE_UNUSED10 = 211,
		MONO_CEE_UNUSED11 = 212,
		MONO_CEE_UNUSED12 = 213,
		MONO_CEE_UNUSED13 = 214,
		MONO_CEE_UNUSED14 = 215,
		MONO_CEE_UNUSED15 = 216,
		MONO_CEE_UNUSED16 = 217,
		MONO_CEE_UNUSED17 = 218,
		MONO_CEE_CONV_OVF_I1 = 219,
		MONO_CEE_CONV_OVF_U1 = 220,
		MONO_CEE_CONV_OVF_I2 = 221,
		MONO_CEE_CONV_OVF_U2 = 222,
		MONO_CEE_CONV_OVF_I4 = 223,
		MONO_CEE_CONV_OVF_U4 = 224,
		MONO_CEE_CONV_OVF_I8 = 225,
		MONO_CEE_CONV_OVF_U8 = 226,
		MONO_CEE_UNUSED50 = 227,
		MONO_CEE_UNUSED18 = 228,
		MONO_CEE_UNUSED19 = 229,
		MONO_CEE_UNUSED20 = 230,
		MONO_CEE_UNUSED21 = 231,
		MONO_CEE_UNUSED22 = 232,
		MONO_CEE_UNUSED23 = 233,
		MONO_CEE_REFANYVAL = 234,
		MONO_CEE_CKFINITE = 235,
		MONO_CEE_UNUSED24 = 236,
		MONO_CEE_UNUSED25 = 237,
		MONO_CEE_MKREFANY = 238,
		MONO_CEE_UNUSED59 = 239,
		MONO_CEE_UNUSED60 = 240,
		MONO_CEE_UNUSED61 = 241,
		MONO_CEE_UNUSED62 = 242,
		MONO_CEE_UNUSED63 = 243,
		MONO_CEE_UNUSED64 = 244,
		MONO_CEE_UNUSED65 = 245,
		MONO_CEE_UNUSED66 = 246,
		MONO_CEE_UNUSED67 = 247,
		MONO_CEE_LDTOKEN = 248,
		MONO_CEE_CONV_U2 = 249,
		MONO_CEE_CONV_U1 = 250,
		MONO_CEE_CONV_I = 251,
		MONO_CEE_CONV_OVF_I = 252,
		MONO_CEE_CONV_OVF_U = 253,
		MONO_CEE_ADD_OVF = 254,
		MONO_CEE_ADD_OVF_UN = 255,
		MONO_CEE_MUL_OVF = 256,
		MONO_CEE_MUL_OVF_UN = 257,
		MONO_CEE_SUB_OVF = 258,
		MONO_CEE_SUB_OVF_UN = 259,
		MONO_CEE_ENDFINALLY = 260,
		MONO_CEE_LEAVE = 261,
		MONO_CEE_LEAVE_S = 262,
		MONO_CEE_STIND_I = 263,
		MONO_CEE_CONV_U = 264,
		MONO_CEE_UNUSED26 = 265,
		MONO_CEE_UNUSED27 = 266,
		MONO_CEE_UNUSED28 = 267,
		MONO_CEE_UNUSED29 = 268,
		MONO_CEE_UNUSED30 = 269,
		MONO_CEE_UNUSED31 = 270,
		MONO_CEE_UNUSED32 = 271,
		MONO_CEE_UNUSED33 = 272,
		MONO_CEE_UNUSED34 = 273,
		MONO_CEE_UNUSED35 = 274,
		MONO_CEE_UNUSED36 = 275,
		MONO_CEE_UNUSED37 = 276,
		MONO_CEE_UNUSED38 = 277,
		MONO_CEE_UNUSED39 = 278,
		MONO_CEE_UNUSED40 = 279,
		MONO_CEE_UNUSED41 = 280,
		MONO_CEE_UNUSED42 = 281,
		MONO_CEE_UNUSED43 = 282,
		MONO_CEE_UNUSED44 = 283,
		MONO_CEE_UNUSED45 = 284,
		MONO_CEE_UNUSED46 = 285,
		MONO_CEE_UNUSED47 = 286,
		MONO_CEE_UNUSED48 = 287,
		MONO_CEE_PREFIX7 = 288,
		MONO_CEE_PREFIX6 = 289,
		MONO_CEE_PREFIX5 = 290,
		MONO_CEE_PREFIX4 = 291,
		MONO_CEE_PREFIX3 = 292,
		MONO_CEE_PREFIX2 = 293,
		MONO_CEE_PREFIX1 = 294,
		MONO_CEE_PREFIXREF = 295,
		MONO_CEE_ARGLIST = 11,
		MONO_CEE_CEQ = 296,
		MONO_CEE_CGT = 297,
		MONO_CEE_CGT_UN = 298,
		MONO_CEE_CLT = 299,
		MONO_CEE_CLT_UN = 300,
		MONO_CEE_LDFTN = 301,
		MONO_CEE_LDVIRTFTN = 302,
		MONO_CEE_UNUSED56 = 303,
		MONO_CEE_LDARG = 304,
		MONO_CEE_LDARGA = 305,
		MONO_CEE_STARG = 306,
		MONO_CEE_LDLOC = 307,
		MONO_CEE_LDLOCA = 308,
		MONO_CEE_STLOC = 309,
		MONO_CEE_LOCALLOC = 310,
		MONO_CEE_UNUSED57 = 311,
		MONO_CEE_ENDFILTER = 312,
		MONO_CEE_UNALIGNED_ = 313,
		MONO_CEE_VOLATILE_ = 314,
		MONO_CEE_TAIL_ = 315,
		MONO_CEE_INITOBJ = 316,
		MONO_CEE_CONSTRAINED_ = 317,
		MONO_CEE_CPBLK = 318,
		MONO_CEE_INITBLK = 319,
		MONO_CEE_NO_ = 320,
		MONO_CEE_RETHROW = 321,
		MONO_CEE_UNUSED = 322,
		MONO_CEE_SIZEOF = 323,
		MONO_CEE_REFANYTYPE = 324,
		MONO_CEE_READONLY_ = 325,
		MONO_CEE_UNUSED53 = 326,
		MONO_CEE_UNUSED54 = 327,
		MONO_CEE_UNUSED55 = 328,
		MONO_CEE_UNUSED70 = 329,
		MONO_CEE_ILLEGAL = 330,
		MONO_CEE_ENDMAC = 331,
		MONO_CEE_MONO_ICALL = 332,
		MONO_CEE_MONO_OBJADDR = 333,
		MONO_CEE_MONO_LDPTR = 334,
		MONO_CEE_MONO_VTADDR = 335,
		MONO_CEE_MONO_NEWOBJ = 336,
		MONO_CEE_MONO_RETOBJ = 337,
		MONO_CEE_MONO_LDNATIVEOBJ = 338,
		MONO_CEE_MONO_CISINST = 339,
		MONO_CEE_MONO_CCASTCLASS = 340,
		MONO_CEE_MONO_SAVE_LMF = 341,
		MONO_CEE_MONO_RESTORE_LMF = 342,
		MONO_CEE_MONO_CLASSCONST = 343,
		MONO_CEE_MONO_NOT_TAKEN = 344,
		MONO_CEE_MONO_TLS = 345,
		MONO_CEE_MONO_ICALL_ADDR = 346,
		MONO_CEE_MONO_DYN_CALL = 347,
		MONO_CEE_MONO_MEMORY_BARRIER = 348,
		MONO_CEE_MONO_JIT_ATTACH = 349,
		MONO_CEE_MONO_JIT_DETACH = 350,
		MONO_CEE_MONO_JIT_ICALL_ADDR = 351,
		MONO_CEE_MONO_LDPTR_INT_REQ_FLAG = 352,
		MONO_CEE_MONO_LDPTR_CARD_TABLE = 353,
		MONO_CEE_MONO_LDPTR_NURSERY_START = 354,
		MONO_CEE_MONO_LDPTR_NURSERY_BITS = 355,
		MONO_CEE_MONO_CALLI_EXTRA_ARG = 356,
		MONO_CEE_MONO_LDDOMAIN = 357,
		MONO_CEE_MONO_ATOMIC_STORE_I4 = 358,
		MONO_CEE_MONO_GET_LAST_ERROR = 359,
		MONO_CEE_LAST = 360
	}

	struct mono.metadata.MonoOpcode
	{
		public Byte argument;
		public Byte flow_type;
		public UInt16 opval;
	}

	enum mono.metadata.MonoProfileFlags
	{
		MONO_PROFILE_NONE = 0,
		MONO_PROFILE_APPDOMAIN_EVENTS = 1,
		MONO_PROFILE_ASSEMBLY_EVENTS = 2,
		MONO_PROFILE_MODULE_EVENTS = 4,
		MONO_PROFILE_CLASS_EVENTS = 33,
		MONO_PROFILE_JIT_COMPILATION = 40,
		MONO_PROFILE_INLINING = 52,
		MONO_PROFILE_EXCEPTIONS = 54,
		MONO_PROFILE_ALLOCATIONS = 9,
		MONO_PROFILE_GC = 11,
		MONO_PROFILE_THREADS = 12,
		MONO_PROFILE_REMOTING = 13,
		MONO_PROFILE_TRANSITIONS = 14,
		MONO_PROFILE_ENTER_LEAVE = 15,
		MONO_PROFILE_COVERAGE = 16,
		MONO_PROFILE_INS_COVERAGE = 17,
		MONO_PROFILE_STATISTICAL = 18,
		MONO_PROFILE_METHOD_EVENTS = 19,
		MONO_PROFILE_MONITOR_EVENTS = 89,
		MONO_PROFILE_IOMAP_EVENTS = 107,
		MONO_PROFILE_GC_MOVES = 361,
		MONO_PROFILE_GC_ROOTS = 104,
		MONO_PROFILE_CONTEXT_EVENTS = 105,
		MONO_PROFILE_GC_FINALIZATION = 362
	}

	enum mono.metadata.MonoProfileResult
	{
		MONO_PROFILE_OK = 0,
		MONO_PROFILE_FAILED = 1
	}

	enum mono.metadata.MonoGCEvent
	{
		MONO_GC_EVENT_START = 0,
		MONO_GC_EVENT_MARK_START = 1,
		MONO_GC_EVENT_MARK_END = 2,
		MONO_GC_EVENT_RECLAIM_START = 3,
		MONO_GC_EVENT_RECLAIM_END = 4,
		MONO_GC_EVENT_END = 5,
		MONO_GC_EVENT_PRE_STOP_WORLD = 6,
		MONO_GC_EVENT_POST_STOP_WORLD = 7,
		MONO_GC_EVENT_PRE_START_WORLD = 33,
		MONO_GC_EVENT_POST_START_WORLD = 35,
		MONO_GC_EVENT_PRE_STOP_WORLD_LOCKED = 36,
		MONO_GC_EVENT_POST_START_WORLD_UNLOCKED = 32
	}

	struct mono.metadata.MonoProfileCoverageEntry
	{
		public MonoMethod* method;
		public Int32 iloffset;
		public Int32 counter;
		public AnsiChar* filename;
		public Int32 line;
		public Int32 col;
	}

	enum mono.metadata.MonoProfilerCodeBufferType
	{
		MONO_PROFILER_CODE_BUFFER_UNKNOWN = 0,
		MONO_PROFILER_CODE_BUFFER_METHOD = 1,
		MONO_PROFILER_CODE_BUFFER_METHOD_TRAMPOLINE = 2,
		MONO_PROFILER_CODE_BUFFER_UNBOX_TRAMPOLINE = 3,
		MONO_PROFILER_CODE_BUFFER_IMT_TRAMPOLINE = 4,
		MONO_PROFILER_CODE_BUFFER_GENERICS_TRAMPOLINE = 5,
		MONO_PROFILER_CODE_BUFFER_SPECIFIC_TRAMPOLINE = 6,
		MONO_PROFILER_CODE_BUFFER_HELPER = 7,
		MONO_PROFILER_CODE_BUFFER_MONITOR = 33,
		MONO_PROFILER_CODE_BUFFER_DELEGATE_INVOKE = 35,
		MONO_PROFILER_CODE_BUFFER_EXCEPTION_HANDLING = 36,
		MONO_PROFILER_CODE_BUFFER_LAST = 32
	}

	using MonoProfiler = Void;

	enum mono.metadata.MonoProfilerMonitorEvent
	{
		MONO_PROFILER_MONITOR_CONTENTION = 1,
		MONO_PROFILER_MONITOR_DONE = 2,
		MONO_PROFILER_MONITOR_FAIL = 3
	}

	enum mono.metadata.MonoProfilerCallChainStrategy
	{
		MONO_PROFILER_CALL_CHAIN_NONE = 0,
		MONO_PROFILER_CALL_CHAIN_NATIVE = 1,
		MONO_PROFILER_CALL_CHAIN_GLIBC = 2,
		MONO_PROFILER_CALL_CHAIN_MANAGED = 3,
		MONO_PROFILER_CALL_CHAIN_INVALID = 4
	}

	enum mono.metadata.MonoProfileGCHandleEvent
	{
		MONO_PROFILER_GC_HANDLE_CREATED = 0,
		MONO_PROFILER_GC_HANDLE_DESTROYED = 1
	}

	enum mono.metadata.MonoProfileGCRootType
	{
		MONO_PROFILE_GC_ROOT_PINNING = 11,
		MONO_PROFILE_GC_ROOT_WEAKREF = 12,
		MONO_PROFILE_GC_ROOT_INTERIOR = 13,
		MONO_PROFILE_GC_ROOT_STACK = 0,
		MONO_PROFILE_GC_ROOT_FINALIZER = 1,
		MONO_PROFILE_GC_ROOT_HANDLE = 2,
		MONO_PROFILE_GC_ROOT_OTHER = 3,
		MONO_PROFILE_GC_ROOT_MISC = 4,
		MONO_PROFILE_GC_ROOT_TYPEMASK = 295
	}

	delegate Void mono.metadata.MonoProfileFunc (MonoProfiler* prof);

	delegate Void mono.metadata.MonoProfileAppDomainFunc (MonoProfiler* prof, MonoDomain* domain);

	delegate Void mono.metadata.MonoProfileContextFunc (MonoProfiler* prof, MonoAppContext* context);

	delegate Void mono.metadata.MonoProfileMethodFunc (MonoProfiler* prof, MonoMethod* method);

	delegate Void mono.metadata.MonoProfileClassFunc (MonoProfiler* prof, MonoClass* klass);

	delegate Void mono.metadata.MonoProfileModuleFunc (MonoProfiler* prof, MonoImage* @module);

	delegate Void mono.metadata.MonoProfileAssemblyFunc (MonoProfiler* prof, MonoAssembly* @assembly);

	delegate Void mono.metadata.MonoProfileMonitorFunc (MonoProfiler* prof, mono.metadata.MonoObject* obj, mono.metadata.MonoProfilerMonitorEvent @event);

	delegate Void mono.metadata.MonoProfileExceptionFunc (MonoProfiler* prof, mono.metadata.MonoObject* @object);

	delegate Void mono.metadata.MonoProfileExceptionClauseFunc (MonoProfiler* prof, MonoMethod* method, Int32 clause_type, Int32 clause_num);

	delegate Void mono.metadata.MonoProfileAppDomainResult (MonoProfiler* prof, MonoDomain* domain, Int32 result);

	delegate Void mono.metadata.MonoProfileAppDomainFriendlyNameFunc (MonoProfiler* prof, MonoDomain* domain, AnsiChar* name);

	delegate Void mono.metadata.MonoProfileMethodResult (MonoProfiler* prof, MonoMethod* method, Int32 result);

	delegate Void mono.metadata.MonoProfileJitResult (MonoProfiler* prof, MonoMethod* method, MonoJitInfo* jinfo, Int32 result);

	delegate Void mono.metadata.MonoProfileClassResult (MonoProfiler* prof, MonoClass* klass, Int32 result);

	delegate Void mono.metadata.MonoProfileModuleResult (MonoProfiler* prof, MonoImage* @module, Int32 result);

	delegate Void mono.metadata.MonoProfileAssemblyResult (MonoProfiler* prof, MonoAssembly* @assembly, Int32 result);

	delegate Void mono.metadata.MonoProfileMethodInline (MonoProfiler* prof, MonoMethod* parent, MonoMethod* child, Int32* ok);

	delegate Void mono.metadata.MonoProfileThreadFunc (MonoProfiler* prof, uintptr_t tid);

	delegate Void mono.metadata.MonoProfileThreadNameFunc (MonoProfiler* prof, uintptr_t tid, AnsiChar* name);

	delegate Void mono.metadata.MonoProfileAllocFunc (MonoProfiler* prof, mono.metadata.MonoObject* obj, MonoClass* klass);

	delegate Void mono.metadata.MonoProfileStatFunc (MonoProfiler* prof, mono_byte* ip, Void* context);

	delegate Void mono.metadata.MonoProfileStatCallChainFunc (MonoProfiler* prof, Int32 call_chain_depth, mono_byte** ip, Void* context);

	delegate Void mono.metadata.MonoProfileGCFunc (MonoProfiler* prof, mono.metadata.MonoGCEvent @event, Int32 generation);

	delegate Void mono.metadata.MonoProfileGCMoveFunc (MonoProfiler* prof, Void** objects, Int32 num);

	delegate Void mono.metadata.MonoProfileGCResizeFunc (MonoProfiler* prof, int64_t new_size);

	delegate Void mono.metadata.MonoProfileGCHandleFunc (MonoProfiler* prof, Int32 op, Int32 type, uintptr_t handle, mono.metadata.MonoObject* obj);

	delegate Void mono.metadata.MonoProfileGCRootFunc (MonoProfiler* prof, Int32 num_roots, Void** objects, Int32* root_types, uintptr_t* extra_info);

	delegate Void mono.metadata.MonoProfileFunc (MonoProfiler* prof);

	delegate Void mono.metadata.MonoProfileGCFinalizeObjectFunc (MonoProfiler* prof, mono.metadata.MonoObject* obj);

	delegate Void mono.metadata.MonoProfileIomapFunc (MonoProfiler* prof, AnsiChar* report, AnsiChar* pathname, AnsiChar* new_pathname);

	delegate mono_bool mono.metadata.MonoProfileCoverageFilterFunc (MonoProfiler* prof, MonoMethod* method);

	delegate Void mono.metadata.MonoProfileCoverageFunc (MonoProfiler* prof, mono.metadata.MonoProfileCoverageEntry* entry);

	delegate Void mono.metadata.MonoProfilerCodeChunkNew (MonoProfiler* prof, Void* chunk, Int32 size);

	delegate Void mono.metadata.MonoProfilerCodeChunkDestroy (MonoProfiler* prof, Void* chunk);

	delegate Void mono.metadata.MonoProfilerCodeBufferNew (MonoProfiler* prof, Void* buffer, Int32 size, mono.metadata.MonoProfilerCodeBufferType type, Void* data);

	enum mono.metadata.MonoProfileSamplingMode
	{
		MONO_PROFILER_STAT_MODE_PROCESS = 0,
		MONO_PROFILER_STAT_MODE_REAL = 1
	}

	delegate mono_bool mono.metadata.MonoThreadManageCallback (MonoThread* thread);

	enum mono.metadata.MonoTokenType
	{
		MONO_TOKEN_MODULE = 0,
		MONO_TOKEN_TYPE_REF = 23,
		MONO_TOKEN_TYPE_DEF = 24,
		MONO_TOKEN_FIELD_DEF = 26,
		MONO_TOKEN_METHOD_DEF = 363,
		MONO_TOKEN_PARAM_DEF = 364,
		MONO_TOKEN_INTERFACE_IMPL = 365,
		MONO_TOKEN_MEMBER_REF = 366,
		MONO_TOKEN_CUSTOM_ATTRIBUTE = 367,
		MONO_TOKEN_PERMISSION = 368,
		MONO_TOKEN_SIGNATURE = 369,
		MONO_TOKEN_EVENT = 370,
		MONO_TOKEN_PROPERTY = 371,
		MONO_TOKEN_MODULE_REF = 372,
		MONO_TOKEN_TYPE_SPEC = 373,
		MONO_TOKEN_ASSEMBLY = 30,
		MONO_TOKEN_ASSEMBLY_REF = 374,
		MONO_TOKEN_FILE = 375,
		MONO_TOKEN_EXPORTED_TYPE = 376,
		MONO_TOKEN_MANIFEST_RESOURCE = 377,
		MONO_TOKEN_GENERIC_PARAM = 378,
		MONO_TOKEN_METHOD_SPEC = 379,
		MONO_TOKEN_STRING = 380,
		MONO_TOKEN_NAME = 381,
		MONO_TOKEN_BASE_TYPE = 382
	}

	class mono.jit.__Global
	{
		public static MonoDomain* mono_jit_init(AnsiChar* file);
		public static MonoDomain* mono_jit_init_version(AnsiChar* root_domain_name, AnsiChar* runtime_version);
		public static Int32 mono_jit_exec(MonoDomain* domain, MonoAssembly* @assembly, Int32 argc, AnsiChar** argv);
		public static Void mono_jit_cleanup(MonoDomain* domain);
		public static mono_bool mono_jit_set_trace_options(AnsiChar* options);
		public static Void mono_set_signal_chaining(mono_bool chain_signals);
		public static Void mono_set_crash_chaining(mono_bool chain_signals);
		public static Void mono_jit_set_aot_only(mono_bool aot_only);
		public static Void mono_jit_set_aot_mode(mono.jit.MonoAotMode mode);
		public static Void mono_set_break_policy([FunctionPointer] delegate mono.jit.MonoBreakPolicy (MonoMethod* method) policy_callback);
		public static Void mono_jit_parse_options(Int32 argc, AnsiChar** argv);
		public static AnsiChar* mono_get_runtime_build_info();
		public static MonoJitInfo* mono_get_jit_info_from_method(MonoDomain* domain, MonoMethod* method);
		public static Void* mono_aot_get_method(MonoDomain* domain, MonoMethod* method);
	}

	enum mono.jit.MonoAotMode
	{
		MONO_AOT_MODE_NONE = 0,
		MONO_AOT_MODE_NORMAL = 1,
		MONO_AOT_MODE_HYBRID = 2,
		MONO_AOT_MODE_FULL = 3,
		MONO_AOT_MODE_LLVMONLY = 4
	}

	enum mono.jit.MonoBreakPolicy
	{
		MONO_BREAK_POLICY_ALWAYS = 0,
		MONO_BREAK_POLICY_NEVER = 1,
		MONO_BREAK_POLICY_ON_DBG = 2
	}

	delegate mono.jit.MonoBreakPolicy mono.jit.MonoBreakPolicyFunc (MonoMethod* method);

}
