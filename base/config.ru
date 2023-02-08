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
  token = request.env["HTTP_AUTHORIZATION"] || params[:token]

  raise Function::Unauthorized if token != AUTH_TOKEN

  body = begin
    str = request.body.read
    JSON.parse(str, symbolize_names: true)
  rescue StandardError => e
    nil
  end

  [200, {}, Function::Handler.new(request.env, body:).call]
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
