# frozen_string_literal: true

require "sinatra"
require "sentry-ruby"

if ENV.key?("SENTRY_DSN")
  Sentry.init do |config|
    config.dsn = ENV.fetch("SENTRY_DSN", nil)
  end
end

require_relative "lib/function"

set :bind, "0.0.0.0"

get "/healthcheck" do
  [200, {}, "ok"]
end

post "/*" do
  [200, {}, Function::Handler.new(request.env).call]
end

error Function::Unauthorized do
  [401, {}, "UNAUTHORIZED"]
end

use Sentry::Rack::CaptureExceptions
run Sinatra::Application
