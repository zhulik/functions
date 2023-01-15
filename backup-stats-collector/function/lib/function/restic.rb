# frozen_string_literal: true

class Function::Restic
  # restic gets it's arguments directly from env

  MINIO_HOST = ENV.fetch("MINIO_HOST")
  MINIO_BUCKET = ENV.fetch("MINIO_BUCKET")
  LAST_VERIFIED_PATH = ENV.fetch("LAST_VERIFIED_PATH")

  def initialize
    @s3 = Aws::S3::Client.new(
      endpoint: "http://#{MINIO_HOST}",
      force_path_style: true
    )
  end

  def stats
    {
      snapshots:,
      last_verified:
    }
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
    now - @s3.get_object(bucket: MINIO_BUCKET, key: LAST_VERIFIED_PATH).body.read.to_i
  end

  def restic_output
    Async::Process.capture("restic", "snapshots", "--no-lock", "--json")
  end

  def now
    Time.now.to_i
  end
end
