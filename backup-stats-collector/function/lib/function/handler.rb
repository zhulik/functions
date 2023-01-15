# frozen_string_literal: true

class Function::Handler
  AUTH_TOKEN = ENV.fetch("AUTH_TOKEN")

  def initialize(env)
    @env = env
  end

  def call
    authenticate!

    to_prometheus_metrics(Function::Restic.new.stats)
  end

  private

  def authenticate!
    raise Function::Unauthorized if @env.dig("rack.request.query_hash", "token") != AUTH_TOKEN
  end

  def to_prometheus_metrics(stats)
    (stats[:snapshots].map do |host, timestamp|
      "archlinux_backup_last_snapshot{host=\"#{host}\"} #{timestamp}"
    end + ["archlinux_backup_last_verified{} #{stats[:last_verified]}"]).join("\n")
  end
end
