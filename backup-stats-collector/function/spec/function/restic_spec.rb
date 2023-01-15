# frozen_string_literal: true

def file_fixture(name)
  File.read("spec/fixtures/files/#{name}")
end

RSpec.describe Function::Restic do
  let(:restic) { described_class.new }

  before do
    allow(restic).to receive(:last_verified).and_return(123)
    allow(Async::Process).to receive(:capture).and_return(file_fixture("snapshots.json"))
  end

  describe "#stats" do
    subject { restic.stats }

    before do
      Timecop.freeze(2023, 0o1, 16)
    end

    it "returns repository stats" do
      expect(subject).to eq({
                              snapshots: {
                                "server.example.com" => 68_397,
                                "desktop.example.com" => 104_835,
                                "laptop.example.com" => 116_999
                              },
                              last_verified: 123
                            })
    end
  end
end
