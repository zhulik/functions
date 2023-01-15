# frozen_string_literal: true

require "zeitwerk"

loader = Zeitwerk::Loader.for_gem
loader.setup

module Function # rubocop:disable Style/ClassAndModuleChildren
  class Unauthorized < StandardError; end
end

loader.eager_load
