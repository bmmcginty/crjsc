alias CT = Crjsc::ValueRef::CrystalTypes | Int32 | Array(CT)

def convert(ctx, g, cro)
  it "should convert #{cro.inspect} to same" do
    g["test"] = cro
    jro = ctx.eval("return test;")
    t = g["test"]
    ret = (t == cro == jro)
    unless ret
      puts "#{cro.inspect},#{jro.inspect}"
    end
    ret.should eq true
  end
end

def get_types(ctx)
  lst = [true, false, 1, 1.2, nil, "test", ctx.undefined]
  lst2 = Array(CT).new
  lst.each do |i|
    lst2 << i
    lst2 << [i]
  end
  lst2
end

module Crjsc
  num_of_contexts = 10
  runs_per_context = 10
  describe "converts between Crystal and JSValue" do
    num_of_contexts.times do |context_num|
      ctx = Context.new
      g = ctx.global
      types = get_types(ctx)
      runs_per_context.times do |run_num|
        types.each do |type|
          convert(ctx, g, type)
        end # type
      end   # run
    end     # context
  end       # describe

end # module
