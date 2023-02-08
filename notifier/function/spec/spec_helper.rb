# frozen_string_literal: true

ENV["ENV"] ||= "test"
ENV["AUTH_TOKEN"] ||= "token"

require "async/rspec"
require "webmock/rspec"
require "simplecov"

SimpleCov.start do
  add_filter "spec"
end

require "function"

RSpec.configure do |config|
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include_context(Async::RSpec::Reactor)

  config.example_status_persistence_file_path = ".rspec_status"
end
