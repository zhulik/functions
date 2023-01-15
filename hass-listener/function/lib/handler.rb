class Handler
  class Unauthorized < StandardError; end

  AUTH_TOKEN = ENV.fetch("AUTH_TOKEN")

  def run(request)
    authenticate!(request)
    [200, {}, request.env.to_json]
  end

  private

  def authenticate!(request)
    raise Unauthorized if request.env.dig("rack.request.query_hash", "token") != AUTH_TOKEN
  end
end
