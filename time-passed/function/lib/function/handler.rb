# frozen_string_literal: true

class Function::Handler
  AUTH_TOKEN = ENV.fetch("AUTH_TOKEN")
  BUCKET = ENV.fetch("BUCKET")
  PATH = ENV.fetch("PATH")

  def initialize(env)
    @env = env
  end

  def call
    authenticate!

    now - s3.get_object(bucket: BUCKET, key: PATH).body.read.to_i
  end

  private

  def authenticate!
    raise Function::Unauthorized if @env["HTTP_AUTHORIZATION"] != AUTH_TOKEN
  end

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
