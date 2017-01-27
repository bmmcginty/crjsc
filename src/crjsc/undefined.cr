require "./lib"

module Crjsc
  struct JSUndefined
    @jctx : Context
    @undefined : LibJavaScriptCore::Valueref

    def initialize(@jctx)
      @undefined = LibJavaScriptCore.value_make_undefined(@jctx)
    end

    def to_js(jsc)
      @undefined
    end

    def ==(other : Nil | JSUndefined)
      true
    end

    def ==(other)
      false
    end
  end
end
