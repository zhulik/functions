# frozen_string_literal: true

class Function::Restic
  def stats
    # restic gets it's arguments directly from env
    JSON.parse(snapshots, symbolize_names: true)
  end

  private

  def snapshots
    Async::Process.capture("restic", "snapshots", "--no-lock", "--json")
  end
end
