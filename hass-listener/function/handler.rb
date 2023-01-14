require 'sinatra'

class Handler
  def run(request)
    [200, {}, request.env.to_json]
  end
end

handler = Handler.new

get '/healthcheck' do
  [200, {}, "ok"]
end

post '/*' do
  handler.run(request)
end
