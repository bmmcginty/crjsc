module Crjsc
  alias CT = ValueRef::CrystalTypes | Int32 | Array(CT)

  describe "converts between Crystal and JSValue" do
    lst = [true, false, 1, 1.2, nil, "test"]
    lst2 = Array(CT).new
    lst.each do |i|
      lst2 << i
      lst2 << [i]
    end

    lst2.each do |cro|
      it "should convert #{cro.inspect} to same" do
        ctx = Context.new
        g = ctx.global
        g["test"] = cro
        jro = ctx.eval("return test;")
        ret = (cro == jro)
        unless ret
          puts "#{cro.inspect},#{jro.inspect}"
        end
        ret.should eq true
      end
    end

    it "should convert undefined from crystal to js and back" do
      ctx = Context.new
      g = ctx.global
      cro = ctx.undefined
      g["test"] = cro
      jro = ctx.eval("return test;")
      (cro == jro).should eq true
      cro = [ctx.undefined]
      g["test"] = cro
      jro = ctx.eval("return test;")
      (cro == jro).should eq true
    end # undefined

  end # conversion

end # module
