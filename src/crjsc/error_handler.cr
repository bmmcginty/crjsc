require "./lib"
require "./js_string"

module Crjsc
  class ErrorHandler
    @error = Pointer(LibJavaScriptCore::Valueref).malloc
    @errorP = Pointer(UInt64).new(@error.address)

    def error
      @errorP[0] = 0_u64
      @error
    end

    def handle_error
      raise_js_error(@error.value) unless @error.value.address == 0
    end

    def raise_js_error(e : LibJavaScriptCore::Valueref)
      t = JSString.new LibJavaScriptCore.value_to_string_copy(ctx, e, nil)
      raise t.to_s
    end
  end
end
