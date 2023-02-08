# frozen_string_literal: true

require "sinatra"
require "sentry-ruby"

require_relative "lib/function"

AUTH_TOKEN = ENV.fetch("AUTH_TOKEN")

if ENV.key?("SENTRY_DSN")
  Sentry.init do |config|
    config.dsn = ENV.fetch("SENTRY_DSN", nil)
  end
end

set :bind, "0.0.0.0"

get "/healthcheck" do
  [200, {}, "ok"]
end

handler = lambda do
  raise Function::Unauthorized if request.env["HTTP_AUTHORIZATION"] != AUTH_TOKEN

  [200, {}, Function::Handler.new(request.env).call]
end

get "/*", &handler
post "/*", &handler
patch "/*", &handler
put "/*", &handler
delete "/*", &handler
options "/*", &handler

error Function::Unauthorized do
  [401, {}, "UNAUTHORIZED"]
end

use Sentry::Rack::CaptureExceptions
run Sinatra::Application
