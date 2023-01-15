# frozen_string_literal: true

class Function::Restic
  # restic gets it's arguments directly from env
  def initialize
    @check_verification = ENV.key?("LAST_VERIFIED_PATH")
  end

  def stats
    {
      snapshots:,
      last_verified:
    }.compact
  end

  private

  def snapshots
    JSON.parse(restic_output, symbolize_names: true)
        .map { { time: now - DateTime.parse(_1[:time]).to_time.to_i, hostname: _1[:hostname] } }
        .sort_by { _1[:time] }
        .group_by { _1[:hostname] }
        .transform_values { _1.first[:time] }
  end

  def last_verified
    return unless @check_verification

    minio_bucket = ENV.fetch("MINIO_BUCKET")
    last_verified_path = ENV.fetch("LAST_VERIFIED_PATH")

    now - s3.get_object(bucket: minio_bucket, key: last_verified_path).body.read.to_i
  end

  def restic_output = Async::Process.capture("restic", "snapshots", "--no-lock", "--json")

  def now = Time.now.to_i

  def s3
    @s3 ||= begin
      minio_host = ENV.fetch("MINIO_HOST")

      Aws::S3::Client.new(
        endpoint: "http://#{minio_host}",
        force_path_style: true
      )
    end
  end
end
