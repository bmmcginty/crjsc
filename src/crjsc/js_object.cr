require "./context"
require "./lib"

module Crjsc
  class JSObject
    @jctx : Context
    @j : LibJavaScriptCore::Objectref

    def to_unsafe
      @j
    end

    def to_js(ctx)
      to_value
    end

    def initialize(@jctx, o : ValueRef)
      t = o.to_object
      @j = t
    end

    def initialize(@jctx, @j)
    end

    def to_value
      @j.as(LibJavaScriptCore::Valueref)
    end

    def [](name : Number | Float)
      self.[](name.to_s)
    end

    def [](name)
      ts = JSString.new(name)
      value = LibJavaScriptCore.object_get_property(@jctx, @j, ts, @jctx.error)
      @jctx.handle_error
      ValueRef.new(@jctx, value).to_cr
    end

    def []=(name, value)
      self.[]=(name, value.to_js(@jctx))
    end

    def []=(name, value : LibJavaScriptCore::Valueref)
      ts = JSString.new(name)
      tv = value
      LibJavaScriptCore.object_set_property(@jctx, @j, ts, tv, 0, @jctx.error)
      @jctx.handle_error
      value
    end
  end
end
