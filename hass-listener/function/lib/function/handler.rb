# frozen_string_literal: true

class Function::Handler
  AUTH_TOKEN = ENV.fetch("AUTH_TOKEN")

  def initialize(request)
    @request = request
  end

  def call
    authenticate!
    [200, {}, @request.env.to_json]
  end

  private

  def authenticate!
    raise Unauthorized if @request.env.dig("rack.request.query_hash", "token") != AUTH_TOKEN
  end
end
