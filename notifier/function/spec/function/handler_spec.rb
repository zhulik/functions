# frozen_string_literal: true

RSpec.describe Function::Handler do
  let(:handler) { described_class.new({}, body: { text: "text" }) }

  describe "#call" do
    subject { handler.call }

    it "does" do
      expect(subject).to eq('{"ok":true}')
    end
  end
end
