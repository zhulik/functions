# frozen_string_literal: true

class Function::Handler
  def initialize(env, body: nil)
    @env = env
    @body = body
  end

  def call
    @env.to_json
  end
end
