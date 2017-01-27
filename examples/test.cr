require "../src/crjsc"

class JSFile < Crjsc::JSClass
#these are private to crystal
@fh : IO?
property :fh

def jsnew(args)
mode="rb"
fn=args[0].to_s
if args.size>0
mode=args[1].to_s
end
jsobj=self.class.new(jctx)
jsobj.fh=File.open(fn,mode)
jsobj
end

jsdef def write(args)
s=args[0].to_s
fh.not_nil! << s
args[0]
end

jsdef def read(args)
size=args[0].as(Float64).to_i
slice=Bytes.new(size)
fh.not_nil!.read slice
String.new slice
end
end

ctx=Crjsc.new
g=ctx.global
g["File"]=JSFile.new(ctx)
fc=ctx.eval("var f,fc; f=new File(\"./examples/test.txt\",\"wrb\"); fc=f.read(10); f.write(\"klmnopqrst\"); return fc;")
puts "contents:#{fc}"
