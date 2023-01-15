# frozen_string_literal: true

class Function::Restic
  def initialize(repository, password)
    @repository = repository
    @password = password
  end

  def stats
    JSON.parse(Async::Process.capture(env, "restic", "snapshots"), symbolize_names: true)
  end

  def env
    ENV.merge(
      "RESTIC_REPOSITORY" => @repository,
      "RESTIC_PASSWORD" => @password
    )
  end
end
