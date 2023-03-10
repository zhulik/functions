# frozen_string_literal: true

RSpec.describe Function::Handler do
  let(:handler) { described_class.new({}) }

  describe "#call" do
    subject { handler.call }

    before do
      allow_any_instance_of(Function::Restic).to receive(:stats) # rubocop:disable RSpec/AnyInstance
        .and_return({
                      snapshots: {
                        "server.example.com" => 1_673_755_203,
                        "desktop.example.com" => 1_673_718_765,
                        "laptop.example.com" => 1_673_706_601
                      },
                      last_verified: 123
                    })
    end

    it "returns backup stats" do
      expected = <<~PROM
        archlinux_backup_last_snapshot{host="server.example.com"} 1673755203
        archlinux_backup_last_snapshot{host="desktop.example.com"} 1673718765
        archlinux_backup_last_snapshot{host="laptop.example.com"} 1673706601
        archlinux_backup_last_verified{} 123
      PROM
      expect(subject).to eq(expected.strip)
    end
  end
end
