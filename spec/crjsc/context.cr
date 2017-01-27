require "spec"

module Crjsc
  describe "context" do
    it "initializes context" do
      ctx = Context.new
      ctx.to_unsafe.should be_truthy
      ctx.finalize
    end

    it "should give global object" do
      ctx = Context.new
      g = ctx.global
      g.should be_truthy
    end

    it "should run function" do
      ctx = Context.new
      ret = ctx.eval("return 123;")
      ret.should eq 123
    end
  end
end
