module Crjsc
  class ValueRef
    @j : LibJavaScriptCore::Valueref
    @jctx : Context

    alias CrystalTypes = (JSUndefined | Nil | Bool | Float64 | String | JSObject | Array(CrystalTypes))

    def cr_type
      case LibJavaScriptCore.value_get_type(@jctx, self)
      when .kjstypeundefined?
        JSUndefined
      when .kjstypenull?
        Nil
      when .kjstypeboolean?
        Bool
      when .kjstypenumber?
        Float64
      when .kjstypestring?
        String
      when .kjstypeobject?
        if LibJavaScriptCore.value_is_array(@jctx, self) == 1
          Array
        else
          JSObject
        end
      else
        raise "Invalid type"
      end
    end

    def to_cr
      case LibJavaScriptCore.value_get_type(@jctx, self)
      when .kjstypeundefined?
        @jctx.undefined
      when .kjstypenull?
        nil
      when .kjstypeboolean?
        to_bool
      when .kjstypenumber?
        to_i
      when .kjstypestring?
        to_s
      when .kjstypeobject?
        if LibJavaScriptCore.value_is_array(@jctx, self) == 1
          to_array
        else
          to_object
        end
      else
        raise "Invalid type"
      end
    end

    def to_unsafe
      @j
    end

    def to_array
      obj = to_object
      # return obj if obj["length"].is_a?(JSUndefined)
      length = obj["length"].as(Float64).to_i
      arr = Array(CrystalTypes).new(length)
      length.times do |i|
        arr << obj[i]
      end
      arr
    end

    def to_object
      v = LibJavaScriptCore.value_to_object(@jctx, @j, @jctx.error)
      @jctx.handle_error
      JSObject.new(@jctx, v)
    end

    def to_i
      v = LibJavaScriptCore.value_to_number(@jctx, @j, @jctx.error)
      @jctx.handle_error
      v
    end

    def to_bool
      v = LibJavaScriptCore.value_to_boolean(@jctx, @j)
      v == 1 ? true : false
    end

    def to_s(io : IO)
      io << to_s
    end

    def to_s
      v = LibJavaScriptCore.value_to_string_copy(@jctx, @j, @jctx.error)
      @jctx.handle_error
      JSString.new(v).to_s
    end

    def to_js(jsc)
      @j
    end

    def initialize(@jctx, v : LibJavaScriptCore::Objectref)
      @j = v.as(LibJavaScriptCore::Valueref)
    end

    def initialize(@jctx, @j)
    end
  end
end
