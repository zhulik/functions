# frozen_string_literal: true

class Function::Handler
  AUTH_TOKEN = ENV.fetch("AUTH_TOKEN")

  def initialize(env)
    @env = env
  end

  def call
    authenticate!

    Function::Restic.new.stats.to_json
  end

  private

  def authenticate!
    raise Function::Unauthorized if @env.dig("rack.request.query_hash", "token") != AUTH_TOKEN
  end
end
