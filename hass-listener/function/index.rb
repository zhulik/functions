# frozen_string_literal: true

require "sinatra"

require_relative "lib/handler"

handler = Handler.new

set :bind, "0.0.0.0"

get "/healthcheck" do
  [200, {}, "ok"]
end

post "/*" do
  handler.run(request)
end

error Handler::Unauthorized do
  [401, {}, "UNAUTHORIZED"]
end
