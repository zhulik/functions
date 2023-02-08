# frozen_string_literal: true

class Function::Handler
  METRICS_PREFIX = ENV.fetch("METRICS_PREFIX")

  def initialize(env, body: nil)
    @env = env
    @body = body
  end

  def call
    to_prometheus_metrics(Function::Restic.new.stats)
  end

  private

  def to_prometheus_metrics(stats)
    lines = stats[:snapshots].map do |host, timestamp|
      "#{METRICS_PREFIX}_last_snapshot{host=\"#{host}\"} #{timestamp}"
    end

    lines << "#{METRICS_PREFIX}_last_verified{} #{stats[:last_verified]}" if stats.key?(:last_verified)

    lines.join("\n")
  end
end
