# frozen_string_literal: true

RSpec.describe Function::Restic do
  let(:restic) { described_class.new("", "") }

  it "works works works", skip: "reason" do
    pp restic.stats
  end
end
