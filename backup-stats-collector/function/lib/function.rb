# frozen_string_literal: true

require "async/process"
require "aws-sdk-s3"
require "zeitwerk"

loader = Zeitwerk::Loader.for_gem
loader.setup

module Function # rubocop:disable Style/ClassAndModuleChildren
  class Unauthorized < StandardError; end
end

loader.eager_load
