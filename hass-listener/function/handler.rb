class Handler
  def run(body, env)
    status_code = 200 # Optional status code, defaults to 200
    response_headers = {"content-type" => "text/plain"}
    body = "Hello world from the Ruby template"

    [body, response_headers, status_code]
  end
end

require 'sinatra'

set :port, 5000
# set :bind, '0.0.0.0'

handler = Handler.new

get '/*' do
  res, res_headers, status = handler.run(request.body, request.env)

  [status || 200, res_headers, res]
end
