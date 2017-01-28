require "./lib"
require "./undefined"
require "./value_ref"

module Crjsc
  module JSClassMacros
    macro jsproperty(*names)
{% for name in names %}
def {{name.id}}
if @JSClassvars.has_key?({{name.id.stringify}})
@JSClassvars[{{name.id.stringify}}]
else
jctx.undefined
end
end

def {{name.id}}=(value)
@JSClassvars[{{name.id.stringify}}]=value
end

f=::Crjsc::LibJavaScriptCore::Staticvalue.new
f.name={{name.id.stringify}}

f.get_property=::Crjsc::LibJavaScriptCore::Objectgetpropertycallback.new do |ctx,this,name,error|
v={{@type.id}}.get_this(this)
v.{{name.id}}().to_js(v.jctx)
end

f.set_property=::Crjsc::LibJavaScriptCore::Objectsetpropertycallback.new do |ctx,this,name,value,error|
v={{@type.id}}.get_this(this)
vr=::Crjsc::ValueRef.new(v.jctx,value)
v.{{name.id}}=(vr.to_cr)
1_u8
end
@@jsprops << f
{% end %}
end

    macro jsdef(call)
{{call}}
f=::Crjsc::LibJavaScriptCore::Staticfunction.new
f.name={{call.name.stringify}}
f.call_as_function=::Crjsc::LibJavaScriptCore::Objectcallasfunctioncallback.new do |ctx,func,this,count,args,error|
v={{@type.id}}.get_this(this)
crargs={{@type.id}}.js_args_to_cr(v.jctx,args,count)
begin
ret=v.{{call.name}}(crargs)
ret.to_js(v.jctx)
rescue e
jea=Array(::Crjsc::LibJavaScriptCore::Valueref).new
jea << ::Crjsc::JSString.new(e.to_s).to_js(v.jctx)
ret=::Crjsc::ValueRef.new(v.jctx,::Crjsc::LibJavaScriptCore.object_make_error(v.jctx,1,jea,nil))
ret_v=ret.to_js(v.jctx)
error.value=ret_v
ret_v
end
end
@@jsmethods << f
end
  end

  class JSClass
    macro inherited
include ::Crjsc::JSClassMacros
end

    @@boxes = Hash(Void*, JSClass).new
    @@jctx : Context? = nil
    @@classref : LibJavaScriptCore::Classref? = nil
    @@classdef : LibJavaScriptCore::Classdefinition? = nil
    @@has_setup = false
    @@jsmethods = Array(LibJavaScriptCore::Staticfunction).new
    @@jsprops = Array(LibJavaScriptCore::Staticvalue).new
    @j : LibJavaScriptCore::Objectref? = nil
    @JSClassvars = Hash(String, ValueRef::CrystalTypes).new

    def self.boxes
      @@boxes
    end

    def initialize(@@jctx)
      setup
    end

    def classdef
      @@classdef
    end

    def jctx
      @@jctx.as(Context)
    end

    def to_jsobject
      @j.not_nil!
    end

    def to_js(jsc)
      @j.not_nil!.as(LibJavaScriptCore::Valueref)
    end

    def self.js_args_to_cr(jsc, args, count)
      crargs = Array(ValueRef::CrystalTypes).new
      count.times do |i|
        crargs << ValueRef.new(jsc, args[i]).to_cr
      end
      return crargs
    end

    macro get_this(bxval)
Box({{@type.id}}).unbox(::Crjsc::LibJavaScriptCore.object_get_private({{bxval}}))
end

    macro setup
unless @@has_setup
classdef=::Crjsc::LibJavaScriptCore::Classdefinition.new
classdef.class_name=self.class.name
classdef.static_functions=@@jsmethods
classdef.static_values=@@jsprops
{% if @type.methods.map { |i| i.name.id.stringify }.includes?("jsinitialize") %}
classdef.initialize=::Crjsc::LibJavaScriptCore::Objectinitializecallback.new do |ctx,this|
v={{@type.id}}.get_this(this)
v.jsinitialize()
end
{% end %}
{% if @type.methods.map { |i| i.name.id.stringify }.includes?("jsfinalize") %}
classdef.finalize=::Crjsc::LibJavaScriptCore::Objectinitializecallback.new do |this|
v={{@type.id}}.get_this(this)
v.jsfinalize()
end
{% end %}
{% if @type.methods.map { |i| i.name.id.stringify }.includes?("jsnew") %}
classdef.call_as_constructor=::Crjsc::LibJavaScriptCore::Objectcallasconstructorcallback.new do |ctx,this,count,args,error|
v={{@type.id}}.get_this(this)
crargs={{@type.id}}.js_args_to_cr(v.jctx,args,count)
v.jsnew(crargs).to_jsobject
end
{% end %}
{% if @type.methods.map { |i| i.name.id.stringify }.includes?("jscall") %}
classdef.call_as_function=::Crjsc::LibJavaScriptCore::Objectcallasfunctioncallback.new do |ctx,func,this,count,args,error|
v={{@type.id}}.get_this(func)
crargs={{@type.id}}.js_args_to_cr(v.jctx,args,count)
v.jscall(crargs).to_js(v.jctx)
end
{% end %}
classref=::Crjsc::LibJavaScriptCore.class_create(pointerof(classdef))
@@classdef=classdef
@@classref=classref
@@has_setup=true
end
bx=Box({{@type.id}}).box(self)
#store all boxed items in JSClass for easy retrieval
::Crjsc::JSClass.boxes[bx]=self.as(::Crjsc::JSClass)
j=::Crjsc::LibJavaScriptCore.object_make(jctx.not_nil!,@@classref.not_nil!,bx)
@j=j
@j
end
  end
end
