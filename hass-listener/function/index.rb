# frozen_string_literal: true

require "sinatra"

require_relative "lib/function"

class Unauthorized < StandardError; end

set :bind, "0.0.0.0"

get "/healthcheck" do
  [200, {}, "ok"]
end

post "/*" do
  Function::Handler.new(request).call
end

error Unauthorized do
  [401, {}, "UNAUTHORIZED"]
end
