class Handler
  def run(req)
    return "Hello world from the Ruby template"
  end
end

req = ARGF.read

handler = Handler.new
res = handler.run req

puts res
