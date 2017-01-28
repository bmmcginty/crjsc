require "../src/crjsc"

class JSFile < Crjsc::JSClass
  # these are private to crystal
  @fh : IO::FileDescriptor?
  property :fh

  # In order for Javascript to see this class as supporting the new keyword,
  # you must have a method called jsnew.
  # This method gets called when this class is called using the new keyword (so `new FileObject` for example).
  def jsnew(args)
    mode = "rb"
    fn = args[0].to_s
    if args.size > 0
      mode = args[1].to_s
    end
    self.class.new(jctx, File.open(fn, mode))
  end

  # this is called from your jsnew method above.
  def initialize(@@jctx, @fh)
    initialize(@@jctx)
  end

  # You must call setup in your initialize chain.
  def initialize(@@jctx)
    setup
  end

  # We return nil here because IO doesn't have a Javascript equivalent.
  # Feel free to make one, though.
  jsdef def close(args)
    @fh.not_nil!.close
    nil
  end

  jsdef def seek(args)
    type = IO::Seek::Set
    offset = args[0].as(Float64).to_i
    if args.size > 1
      # This is the conversion I'd love to get rid of.
      type = IO::Seek.from_value(args[1].as(Float64).to_i)
    end
    @fh.not_nil!.seek(offset, type)
    puts @fh.not_nil!.tell
    @fh.not_nil!.tell
  end

  jsdef def write(args)
    s = args[0].to_s
    fh.not_nil! << s
    args[0]
  end

  jsdef def read(args)
    size = args[0].as(Float64).to_i
    slice = Bytes.new(size)
    fh.not_nil!.read slice
    String.new slice
  end

  jsdef def tell(args)
    @fh.not_nil!.tell
  end
end

ctx = Crjsc.new
g = ctx.global
g["File"] = JSFile.new(ctx)
script = <<-EOS
var fc,fh;
fh=new File("./examples/test.txt","rb")
fc=fh.read(10)
fh.close()
fh=new File("./examples/test.txt","r+")
fh.seek(0)
fh.write(fc)
fh.close()
fh=new File("./examples/test.txt","rb")
fc=fh.read(10)
fh.close()
return fc;
EOS
fc = ctx.eval(script)
puts "contents:#{fc}"
