# frozen_string_literal: true

class Function::Handler
  AUTH_TOKEN = ENV.fetch("AUTH_TOKEN")
  BUCKET = ENV.fetch("BUCKET")
  PATH = ENV.fetch("FILE_PATH")
  MINIO_HOST = ENV.fetch("MINIO_HOST")
  METRICS_PREFIX = ENV.fetch("METRICS_PREFIX")

  def initialize(env)
    @env = env
  end

  def call
    authenticate!

    "#{METRICS_PREFIX}_last_snapshot{host=\"external\"} #{passed}"
  end

  private

  def authenticate!
    raise Function::Unauthorized if @env["HTTP_AUTHORIZATION"] != AUTH_TOKEN
  end

  def s3
    @s3 ||= Aws::S3::Client.new(
      endpoint: "http://#{MINIO_HOST}",
      force_path_style: true
    )
  end

  def passed = Time.now.to_i - s3.get_object(bucket: BUCKET, key: PATH).body.read.to_i
end
