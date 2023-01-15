# frozen_string_literal: true

require "sinatra"

require_relative "lib/function"

set :bind, "0.0.0.0"

get "/healthcheck" do
  [200, {}, "ok"]
end

post "/*" do
  Function::Handler.new(request).call
end

error Function::Unauthorized do
  [401, {}, "UNAUTHORIZED"]
end
