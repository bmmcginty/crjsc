@[Link(ldflags: "-Xlinker -rpath -Xlinker #{__DIR__}/../ext -L#{__DIR__}/../ext -lJavaScriptCore")]

lib LibC
  alias Boolean = UInt8
end

module Crjsc
  lib LibJavaScriptCore
    C_OBJC_API_ENABLED = 0
    fun evaluate_script = JSEvaluateScript(ctx : Contextref, script : Stringref, this_object : Objectref, source_url : Stringref, starting_line_number : LibC::Int, exception : Valueref*) : Valueref
    type Contextref = Void*
    type Stringref = Void*
    type Objectref = Void*
    type Valueref = Void*
    fun check_script_syntax = JSCheckScriptSyntax(ctx : Contextref, script : Stringref, source_url : Stringref, starting_line_number : LibC::Int, exception : Valueref*) : LibC::Boolean
    fun garbage_collect = JSGarbageCollect(ctx : Contextref)
    fun value_get_type = JSValueGetType(ctx : Contextref, value : Valueref) : Type
    enum Type
      Kjstypeundefined = 0
      Kjstypenull      = 1
      Kjstypeboolean   = 2
      Kjstypenumber    = 3
      Kjstypestring    = 4
      Kjstypeobject    = 5
    end
    fun value_is_undefined = JSValueIsUndefined(ctx : Contextref, value : Valueref) : LibC::Boolean
    fun value_is_null = JSValueIsNull(ctx : Contextref, value : Valueref) : LibC::Boolean
    fun value_is_boolean = JSValueIsBoolean(ctx : Contextref, value : Valueref) : LibC::Boolean
    fun value_is_number = JSValueIsNumber(ctx : Contextref, value : Valueref) : LibC::Boolean
    fun value_is_string = JSValueIsString(ctx : Contextref, value : Valueref) : LibC::Boolean
    fun value_is_object = JSValueIsObject(ctx : Contextref, value : Valueref) : LibC::Boolean
    fun value_is_object_of_class = JSValueIsObjectOfClass(ctx : Contextref, value : Valueref, js_class : Classref) : LibC::Boolean
    type Classref = Void*
    fun value_is_array = JSValueIsArray(ctx : Contextref, value : Valueref) : LibC::Boolean
    fun value_is_date = JSValueIsDate(ctx : Contextref, value : Valueref) : LibC::Boolean
    fun value_get_typed_array_type = JSValueGetTypedArrayType(ctx : Contextref, value : Valueref, exception : Valueref*) : Typedarraytype
    enum Typedarraytype
      Kjstypedarraytypeint8array         =  0
      Kjstypedarraytypeint16array        =  1
      Kjstypedarraytypeint32array        =  2
      Kjstypedarraytypeuint8array        =  3
      Kjstypedarraytypeuint8clampedarray =  4
      Kjstypedarraytypeuint16array       =  5
      Kjstypedarraytypeuint32array       =  6
      Kjstypedarraytypefloat32array      =  7
      Kjstypedarraytypefloat64array      =  8
      Kjstypedarraytypearraybuffer       =  9
      Kjstypedarraytypenone              = 10
    end
    fun value_is_equal = JSValueIsEqual(ctx : Contextref, a : Valueref, b : Valueref, exception : Valueref*) : LibC::Boolean
    fun value_is_strict_equal = JSValueIsStrictEqual(ctx : Contextref, a : Valueref, b : Valueref) : LibC::Boolean
    fun value_is_instance_of_constructor = JSValueIsInstanceOfConstructor(ctx : Contextref, value : Valueref, constructor : Objectref, exception : Valueref*) : LibC::Boolean
    fun value_make_undefined = JSValueMakeUndefined(ctx : Contextref) : Valueref
    fun value_make_null = JSValueMakeNull(ctx : Contextref) : Valueref
    fun value_make_boolean = JSValueMakeBoolean(ctx : Contextref, boolean : LibC::Boolean) : Valueref
    fun value_make_number = JSValueMakeNumber(ctx : Contextref, number : LibC::Double) : Valueref
    fun value_make_string = JSValueMakeString(ctx : Contextref, string : Stringref) : Valueref
    fun value_make_from_json_string = JSValueMakeFromJSONString(ctx : Contextref, string : Stringref) : Valueref
    fun value_create_json_string = JSValueCreateJSONString(ctx : Contextref, value : Valueref, indent : LibC::UInt, exception : Valueref*) : Stringref
    fun value_to_boolean = JSValueToBoolean(ctx : Contextref, value : Valueref) : LibC::Boolean
    fun value_to_number = JSValueToNumber(ctx : Contextref, value : Valueref, exception : Valueref*) : LibC::Double
    fun value_to_string_copy = JSValueToStringCopy(ctx : Contextref, value : Valueref, exception : Valueref*) : Stringref
    fun value_to_object = JSValueToObject(ctx : Contextref, value : Valueref, exception : Valueref*) : Objectref
    fun value_protect = JSValueProtect(ctx : Contextref, value : Valueref)
    fun value_unprotect = JSValueUnprotect(ctx : Contextref, value : Valueref)
    fun class_create = JSClassCreate(definition : Classdefinition*) : Classref

    struct Classdefinition
      version : LibC::Int
      attributes : Classattributes
      class_name : LibC::Char*
      parent_class : Classref
      static_values : Staticvalue*
      static_functions : Staticfunction*
      initialize : Objectinitializecallback
      finalize : Objectfinalizecallback
      has_property : Objecthaspropertycallback
      get_property : Objectgetpropertycallback
      set_property : Objectsetpropertycallback
      delete_property : Objectdeletepropertycallback
      get_property_names : Objectgetpropertynamescallback
      call_as_function : Objectcallasfunctioncallback
      call_as_constructor : Objectcallasconstructorcallback
      has_instance : Objecthasinstancecallback
      convert_to_type : Objectconverttotypecallback
    end

    alias Classattributes = LibC::UInt

    struct Staticvalue
      name : LibC::Char*
      get_property : Objectgetpropertycallback
      set_property : Objectsetpropertycallback
      attributes : Propertyattributes
    end

    alias Objectgetpropertycallback = (Contextref, Objectref, Stringref, Valueref* -> Valueref)
    alias Objectsetpropertycallback = (Contextref, Objectref, Stringref, Valueref, Valueref* -> LibC::Boolean)
    alias Propertyattributes = LibC::UInt

    struct Staticfunction
      name : LibC::Char*
      call_as_function : Objectcallasfunctioncallback
      attributes : Propertyattributes
    end

    alias Objectcallasfunctioncallback = (Contextref, Objectref, Objectref, LibC::SizeT, Valueref*, Valueref* -> Valueref)
    alias Objectinitializecallback = (Contextref, Objectref -> Void)
    alias Objectfinalizecallback = (Objectref -> Void)
    alias Objecthaspropertycallback = (Contextref, Objectref, Stringref -> LibC::Boolean)
    alias Objectdeletepropertycallback = (Contextref, Objectref, Stringref, Valueref* -> LibC::Boolean)
    type Propertynameaccumulatorref = Void*
    alias Objectgetpropertynamescallback = (Contextref, Objectref, Propertynameaccumulatorref -> Void)
    alias Objectcallasconstructorcallback = (Contextref, Objectref, LibC::SizeT, Valueref*, Valueref* -> Objectref)
    alias Objecthasinstancecallback = (Contextref, Objectref, Valueref, Valueref* -> LibC::Boolean)
    alias Objectconverttotypecallback = (Contextref, Objectref, Type, Valueref* -> Valueref)
    fun class_retain = JSClassRetain(js_class : Classref) : Classref
    fun class_release = JSClassRelease(js_class : Classref)
    fun object_make = JSObjectMake(ctx : Contextref, js_class : Classref, data : Void*) : Objectref
    fun object_make_function_with_callback = JSObjectMakeFunctionWithCallback(ctx : Contextref, name : Stringref, call_as_function : Objectcallasfunctioncallback) : Objectref
    fun object_make_constructor = JSObjectMakeConstructor(ctx : Contextref, js_class : Classref, call_as_constructor : Objectcallasconstructorcallback) : Objectref
    fun object_make_array = JSObjectMakeArray(ctx : Contextref, argument_count : LibC::SizeT, arguments : Valueref*, exception : Valueref*) : Objectref
    fun object_make_date = JSObjectMakeDate(ctx : Contextref, argument_count : LibC::SizeT, arguments : Valueref*, exception : Valueref*) : Objectref
    fun object_make_error = JSObjectMakeError(ctx : Contextref, argument_count : LibC::SizeT, arguments : Valueref*, exception : Valueref*) : Objectref
    fun object_make_reg_exp = JSObjectMakeRegExp(ctx : Contextref, argument_count : LibC::SizeT, arguments : Valueref*, exception : Valueref*) : Objectref
    fun object_make_function = JSObjectMakeFunction(ctx : Contextref, name : Stringref, parameter_count : LibC::UInt, parameter_names : Stringref*, body : Stringref, source_url : Stringref, starting_line_number : LibC::Int, exception : Valueref*) : Objectref
    fun object_get_prototype = JSObjectGetPrototype(ctx : Contextref, object : Objectref) : Valueref
    fun object_set_prototype = JSObjectSetPrototype(ctx : Contextref, object : Objectref, value : Valueref)
    fun object_has_property = JSObjectHasProperty(ctx : Contextref, object : Objectref, property_name : Stringref) : LibC::Boolean
    fun object_get_property = JSObjectGetProperty(ctx : Contextref, object : Objectref, property_name : Stringref, exception : Valueref*) : Valueref
    fun object_set_property = JSObjectSetProperty(ctx : Contextref, object : Objectref, property_name : Stringref, value : Valueref, attributes : Propertyattributes, exception : Valueref*)
    fun object_delete_property = JSObjectDeleteProperty(ctx : Contextref, object : Objectref, property_name : Stringref, exception : Valueref*) : LibC::Boolean
    fun object_get_property_at_index = JSObjectGetPropertyAtIndex(ctx : Contextref, object : Objectref, property_index : LibC::UInt, exception : Valueref*) : Valueref
    fun object_set_property_at_index = JSObjectSetPropertyAtIndex(ctx : Contextref, object : Objectref, property_index : LibC::UInt, value : Valueref, exception : Valueref*)
    fun object_get_private = JSObjectGetPrivate(object : Objectref) : Void*
    fun object_set_private = JSObjectSetPrivate(object : Objectref, data : Void*) : LibC::Boolean
    fun object_is_function = JSObjectIsFunction(ctx : Contextref, object : Objectref) : LibC::Boolean
    fun object_call_as_function = JSObjectCallAsFunction(ctx : Contextref, object : Objectref, this_object : Objectref, argument_count : LibC::SizeT, arguments : Valueref*, exception : Valueref*) : Valueref
    fun object_is_constructor = JSObjectIsConstructor(ctx : Contextref, object : Objectref) : LibC::Boolean
    fun object_call_as_constructor = JSObjectCallAsConstructor(ctx : Contextref, object : Objectref, argument_count : LibC::SizeT, arguments : Valueref*, exception : Valueref*) : Objectref
    fun object_copy_property_names = JSObjectCopyPropertyNames(ctx : Contextref, object : Objectref) : Propertynamearrayref
    type Propertynamearrayref = Void*
    fun property_name_array_retain = JSPropertyNameArrayRetain(array : Propertynamearrayref) : Propertynamearrayref
    fun property_name_array_release = JSPropertyNameArrayRelease(array : Propertynamearrayref)
    fun property_name_array_get_count = JSPropertyNameArrayGetCount(array : Propertynamearrayref) : LibC::SizeT
    fun property_name_array_get_name_at_index = JSPropertyNameArrayGetNameAtIndex(array : Propertynamearrayref, index : LibC::SizeT) : Stringref
    fun property_name_accumulator_add_name = JSPropertyNameAccumulatorAddName(accumulator : Propertynameaccumulatorref, property_name : Stringref)
    fun context_group_create = JSContextGroupCreate : Contextgroupref
    type Contextgroupref = Void*
    fun context_group_retain = JSContextGroupRetain(group : Contextgroupref) : Contextgroupref
    fun context_group_release = JSContextGroupRelease(group : Contextgroupref)
    fun global_context_create = JSGlobalContextCreate(global_object_class : Classref) : Globalcontextref
    alias Globalcontextref = Contextref
    #  type Globalcontextref = Void*
    fun global_context_create_in_group = JSGlobalContextCreateInGroup(group : Contextgroupref, global_object_class : Classref) : Globalcontextref
    fun global_context_retain = JSGlobalContextRetain(ctx : Globalcontextref) : Globalcontextref
    fun global_context_release = JSGlobalContextRelease(ctx : Globalcontextref)
    fun context_get_global_object = JSContextGetGlobalObject(ctx : Contextref) : Objectref
    fun context_get_group = JSContextGetGroup(ctx : Contextref) : Contextgroupref
    fun context_get_global_context = JSContextGetGlobalContext(ctx : Contextref) : Globalcontextref
    fun global_context_copy_name = JSGlobalContextCopyName(ctx : Globalcontextref) : Stringref
    fun global_context_set_name = JSGlobalContextSetName(ctx : Globalcontextref, name : Stringref)
    fun string_create_with_characters = JSStringCreateWithCharacters(chars : Char*, num_chars : LibC::SizeT) : Stringref
    alias Char = LibC::UShort
    fun string_create_with_ut_f8c_string = JSStringCreateWithUTF8CString(string : LibC::Char*) : Stringref
    fun string_retain = JSStringRetain(string : Stringref) : Stringref
    fun string_release = JSStringRelease(string : Stringref)
    fun string_get_length = JSStringGetLength(string : Stringref) : LibC::SizeT
    fun string_get_characters_ptr = JSStringGetCharactersPtr(string : Stringref) : Char*
    fun string_get_maximum_ut_f8c_string_size = JSStringGetMaximumUTF8CStringSize(string : Stringref) : LibC::SizeT
    fun string_get_ut_f8c_string = JSStringGetUTF8CString(string : Stringref, buffer : LibC::Char*, buffer_size : LibC::SizeT) : LibC::SizeT
    fun string_is_equal = JSStringIsEqual(a : Stringref, b : Stringref) : LibC::Boolean
    fun string_is_equal_to_ut_f8c_string = JSStringIsEqualToUTF8CString(a : Stringref, b : LibC::Char*) : LibC::Boolean
    fun object_make_typed_array = JSObjectMakeTypedArray(ctx : Contextref, array_type : Typedarraytype, length : LibC::SizeT, exception : Valueref*) : Objectref
    fun object_make_typed_array_with_bytes_no_copy = JSObjectMakeTypedArrayWithBytesNoCopy(ctx : Contextref, array_type : Typedarraytype, bytes : Void*, byte_length : LibC::SizeT, bytes_deallocator : Typedarraybytesdeallocator, deallocator_context : Void*, exception : Valueref*) : Objectref
    alias Typedarraybytesdeallocator = (Void*, Void* -> Void)
    fun object_make_typed_array_with_array_buffer = JSObjectMakeTypedArrayWithArrayBuffer(ctx : Contextref, array_type : Typedarraytype, buffer : Objectref, exception : Valueref*) : Objectref
    fun object_make_typed_array_with_array_buffer_and_offset = JSObjectMakeTypedArrayWithArrayBufferAndOffset(ctx : Contextref, array_type : Typedarraytype, buffer : Objectref, byte_offset : LibC::SizeT, length : LibC::SizeT, exception : Valueref*) : Objectref
    fun object_get_typed_array_bytes_ptr = JSObjectGetTypedArrayBytesPtr(ctx : Contextref, object : Objectref, exception : Valueref*) : Void*
    fun object_get_typed_array_length = JSObjectGetTypedArrayLength(ctx : Contextref, object : Objectref, exception : Valueref*) : LibC::SizeT
    fun object_get_typed_array_byte_length = JSObjectGetTypedArrayByteLength(ctx : Contextref, object : Objectref, exception : Valueref*) : LibC::SizeT
    fun object_get_typed_array_byte_offset = JSObjectGetTypedArrayByteOffset(ctx : Contextref, object : Objectref, exception : Valueref*) : LibC::SizeT
    fun object_get_typed_array_buffer = JSObjectGetTypedArrayBuffer(ctx : Contextref, object : Objectref, exception : Valueref*) : Objectref
    fun object_make_array_buffer_with_bytes_no_copy = JSObjectMakeArrayBufferWithBytesNoCopy(ctx : Contextref, bytes : Void*, byte_length : LibC::SizeT, bytes_deallocator : Typedarraybytesdeallocator, deallocator_context : Void*, exception : Valueref*) : Objectref
    fun object_get_array_buffer_bytes_ptr = JSObjectGetArrayBufferBytesPtr(ctx : Contextref, object : Objectref, exception : Valueref*) : Void*
    fun object_get_array_buffer_byte_length = JSObjectGetArrayBufferByteLength(ctx : Contextref, object : Objectref, exception : Valueref*) : LibC::SizeT
  end
end
