require "./lib"

module Crjsc
  class JSString
    @j : LibJavaScriptCore::Stringref

    def to_unsafe
      @j
    end

    def to_value
      @j.as(LibJavaScriptCore::Valueref)
    end

    def to_js(ctx)
      Crjsc::LibJavaScriptCore.value_make_string(ctx, @j)
    end

    def initialize(s : String)
      @j = LibJavaScriptCore.string_create_with_ut_f8c_string(s)
    end

    def initialize(@j)
    end

    def to_s(io : IO)
      io << to_s
    end

    def to_s
      mx = LibJavaScriptCore.string_get_maximum_ut_f8c_string_size(@j)
      s = Slice(UInt8).new(mx)
      ol = LibJavaScriptCore.string_get_ut_f8c_string(@j,
        s,
        mx)
      # ol includes terminating zero character which we don't want
      s = s[0, ol - 1]
      String.new(s)
    end

    def finalize
      LibJavaScriptCore.string_release(@j)
    end
  end
end
