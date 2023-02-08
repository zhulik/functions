# frozen_string_literal: true

class Function::Telegram
  include Memery

  def initialize(token, chats)
    @token = token
    @chats = chats
  end

  def notify(text)
    @chats.map do |chat_id|
      Async { connection.post("/bot#{@token}/sendMessage", chat_id:, text:, parse_mode: "Markdown") }
    end.map(&:wait)
  end

  memoize def connection
    Faraday.new("https://api.telegram.org") do |f|
      f.request :json
      f.response :raise_error
    end
  end
end
