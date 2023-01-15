# frozen_string_literal: true

class Function::Restic
  def stats
    # restic gets it's arguments directly from env
    JSON.parse(Async::Process.capture("restic", "snapshots"), symbolize_names: true)
  end
end
