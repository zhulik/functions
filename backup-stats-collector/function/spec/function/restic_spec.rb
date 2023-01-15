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

    it "returns repository stats" do
      expect(subject).to eq({
                              snapshots: {
                                "server.example.com" => 1_673_755_203,
                                "desktop.example.com" => 1_673_718_765,
                                "laptop.example.com" => 1_673_706_601
                              },
                              last_verified: 123
                            })
    end
  end
end
