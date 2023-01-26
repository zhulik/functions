# frozen_string_literal: true

class Function::Handler
  def initialize(env)
    @env = env
  end

  def call
    @env.to_json
  end
end
