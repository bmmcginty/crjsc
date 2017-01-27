module Crjsc
  describe "JSObject represents objects in javascript land" do
    it "provides global `object`" do
      ctx = Context.new
      g = ctx.global
      g.class.should eq JSObject
    end

    it "should assign value to existing object" do
      ctx = Context.new
      g = ctx.global
      g["test"] = "test"
      g["test"].should eq "test"
    end
  end # jsobject
end   # module
