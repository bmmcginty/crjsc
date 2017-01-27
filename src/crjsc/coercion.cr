require "./lib"

struct Bool
  def to_js(ctx)
    v = self == true ? 1_u8 : 0_u8
    Crjsc::LibJavaScriptCore.value_make_boolean(ctx, v.as(LibC::Boolean))
  end
end

class String
  def to_js(ctx)
    Crjsc::JSString.new(self).to_js(ctx)
  end
end

class Array
  def to_js(ctx)
    a = Array(Crjsc::LibJavaScriptCore::Valueref).new(self.size)
    self.each do |i|
      a << i.to_js(ctx)
    end
    ja = Crjsc::LibJavaScriptCore.object_make_array(ctx, a.size, a, ctx.error)
    ctx.handle_error
    ja.as(Crjsc::LibJavaScriptCore::Valueref)
  end
end

struct Nil
  def to_js(ctx)
    Crjsc::LibJavaScriptCore.value_make_null(ctx)
  end
end

struct Number
  def to_js(ctx)
    Crjsc::LibJavaScriptCore.value_make_number(ctx, self.to_f)
  end
end
