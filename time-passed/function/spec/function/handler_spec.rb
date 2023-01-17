# frozen_string_literal: true

RSpec.describe Function::Handler do
  let(:handler) { described_class.new(env) }

  describe "#call" do
    subject { handler.call }

    context "when token is valid" do
      let(:env) { { "HTTP_AUTHORIZATION" => ENV.fetch("AUTH_TOKEN") } }

      before do
        allow(handler).to receive(:passed).and_return(123)
      end

      it "does" do
        expect(subject).to eq("prefix_last_snapshot{host=\"external\"} 123")
      end
    end

    context "when token is invalid" do
      let(:env) { { "HTTP_AUTHORIZATION" => "wrong" } }

      it "raises unauthorized" do
        expect { subject }.to raise_error(Function::Unauthorized)
      end
    end
  end
end
