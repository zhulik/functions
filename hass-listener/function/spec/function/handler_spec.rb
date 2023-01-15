# frozen_string_literal: true

RSpec.describe Function::Handler do
  let(:handler) { described_class.new(request) }

  describe "#call" do
    subject { handler.call }

    context "when token is valid" do
      let(:request) { double(env: { "rack.request.query_hash" => { "token" => ENV.fetch("AUTH_TOKEN", nil) } }) } # rubocop:disable RSpec/VerifiedDoubles

      it "does" do
        expect(subject).to eq([200, {}, "{\"rack.request.query_hash\":{\"token\":\"token\"}}"])
      end
    end

    context "when token is invalid" do
      let(:request) { double(env: { "rack.request.query_hash" => { "token" => "wrong" } }) } # rubocop:disable RSpec/VerifiedDoubles

      it "raises unauthorized" do
        expect { subject }.to raise_error(Function::Unauthorized)
      end
    end
  end
end
