require "./lib"
require "./value_ref"
require "./error_handler"
require "./js_string"
require "./undefined"

module Crjsc
  class Context < ErrorHandler
    @ctx : LibJavaScriptCore::Contextref
    @undefined : JSUndefined?
    property :ctx

    def undefined
      @undefined.not_nil!
    end

    def to_unsafe
      @ctx
    end

    def initialize(obj : Nil = nil)
      @ctx = LibJavaScriptCore.global_context_create(obj)
      protect
      @undefined = JSUndefined.new(self)
    end

    def finalize
      unprotect
    end

    def protect
      LibJavaScriptCore.global_context_retain @ctx
    end

    def unprotect
      LibJavaScriptCore.global_context_release @ctx
    end

    def global
      JSObject.new(self, LibJavaScriptCore.context_get_global_object(@ctx))
    end

    def eval(script : String)
      jstr = JSString.new script
      f = jfunc(jstr)
      v = jcallfunc(f)
      ValueRef.new(self, v).to_cr
    end

    def jfunc(jstr)
      v = LibJavaScriptCore.object_make_function(ctx, nil, 0, nil, jstr, nil, 1, error)
      handle_error
      v
    end

    def jcallfunc(fn)
      v = LibJavaScriptCore.object_call_as_function(ctx, fn, nil, 0, nil, error)
      handle_error
      v
    end
  end
end
