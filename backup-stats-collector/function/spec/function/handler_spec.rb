# frozen_string_literal: true

RSpec.describe Function::Handler do
  let(:handler) { described_class.new(env) }

  describe "#call" do
    subject { handler.call }

    context "when token is valid" do
      let(:env) { { "rack.request.query_hash" => { "token" => ENV.fetch("AUTH_TOKEN") } } }

      it "returns backup stats", skip: "reason" do
        expect(subject).to eq("{\"rack.request.query_hash\":{\"token\":\"token\"}}")
      end
    end

    context "when token is invalid" do
      let(:env) { { "rack.request.query_hash" => { "token" => "wrong" } } }

      it "raises unauthorized" do
        expect { subject }.to raise_error(Function::Unauthorized)
      end
    end
  end
end
