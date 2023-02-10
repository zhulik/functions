# frozen_string_literal: true

class Function::Handler
  def initialize(env, body: nil)
    @env = env
    @body = body
  end

  def call
    sleep(1)
    {}.to_json
  end
end
