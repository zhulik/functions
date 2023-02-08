# frozen_string_literal: true

class Function::Telegram
  include Memery

  API_URL = "https://api.telegram.org"

  def initialize(token, chats)
    @token = token
    @chats = chats
  end

  def notify(text)
    @chats.map do |chat_id|
      Async { send_notification(chat_id:, text:) }
    end.map(&:wait)
  end

  private

  memoize def connection
    Faraday.new(API_URL) do |f|
      f.request :json
      f.response :raise_error
    end
  end

  def send_notification(chat_id:, text:)
    connection.post("/bot#{@token}/sendMessage", chat_id:, text:, parse_mode: "Markdown")
  end
end
