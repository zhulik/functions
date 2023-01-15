# frozen_string_literal: true

ENV["ENV"] ||= "test"
ENV["AUTH_TOKEN"] ||= "token"

ENV["AWS_REGION"] ||= "main"
ENV["MINIO_HOST"] ||= "minio.example.com"
ENV["MINIO_BUCKET"] ||= "bucket"
ENV["LAST_VERIFIED_PATH"] ||= "last_verified"

require "async/rspec"
require "simplecov"
require "timecop"

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
