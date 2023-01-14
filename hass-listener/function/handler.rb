require 'sinatra'

class Handler
  def run(request)
    [200, {}, request.env.to_s]
  end
end

handler = Handler.new

get '/*' do
  handler.run(request)
end
