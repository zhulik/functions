# frozen_string_literal: true

class Function::Handler
  TELEGRAM_TOKEN = ENV.fetch("TELEGRAM_TOKEN", "")

  TELEGRAM_CHATS = ENV.fetch("TELEGRAM_CHATS", "")
                      .split(",")
                      .map(&:strip)

  TELEGRAM = Function::Telegram.new(TELEGRAM_TOKEN, TELEGRAM_CHATS)

  def initialize(env)
    @env = env
  end

  def call
    pp(@env.to_json)
    @env.to_json
  end
end
