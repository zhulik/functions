require 'sinatra'


require 'json'

class Handler
  def run(request)
    [200, {}, request.env.to_json]
  end
end

handler = Handler.new

get '/*' do
  handler.run(request)
end
