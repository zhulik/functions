# frozen_string_literal: true

def file_fixture(name)
  File.read("spec/fixtures/files/#{name}")
end

RSpec.describe Function::Restic do
  let(:restic) { described_class.new }

  before do
    allow(Async::Process).to receive(:capture).and_return(file_fixture("snapshots.json"))
  end

  describe "#stats" do
    subject { restic.stats }

    it "returns repository stats", skip: "reason" do
      pp subject
    end
  end
end
