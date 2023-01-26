# frozen_string_literal: true

RSpec.describe Function::Handler do
  let(:handler) { described_class.new({}) }

  describe "#call" do
    subject { handler.call }

    context "when token is valid" do
      before do
        allow(handler).to receive(:passed).and_return(123)
      end

      it "does" do
        expect(subject).to eq("prefix_last_snapshot{host=\"external\"} 123")
      end
    end
  end
end
