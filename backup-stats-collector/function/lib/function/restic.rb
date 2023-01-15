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
    JSON.parse(Async::Process.capture("restic", "snapshots", "--no-lock", "--json"), symbolize_names: true)
        .sort_by { _1[:time] }
        .reverse
        .map { { time: DateTime.parse(_1[:time]), hostname: _1[:hostname] } }
        .group_by { _1[:hostname] }
        .transform_values { _1.first[:time].to_time.to_i }
  end

  def last_verified
    @s3.get_object(bucket: MINIO_BUCKET, key: LAST_VERIFIED_PATH).body.read.to_i
  end
end
