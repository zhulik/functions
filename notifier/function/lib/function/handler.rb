# frozen_string_literal: true

class Function::Handler
  TELEGRAM_TOKEN = ENV.fetch("TELEGRAM_TOKEN", "")

  TELEGRAM_CHATS = ENV.fetch("TELEGRAM_CHATS", "")
                      .split(",")
                      .map(&:strip)

  TELEGRAM = Function::Telegram.new(TELEGRAM_TOKEN, TELEGRAM_CHATS)

  def initialize(env, body: nil)
    @env = env
    @body = body
  end

  def call
    @body
  end
end
