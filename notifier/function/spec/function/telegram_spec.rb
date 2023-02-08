# frozen_string_literal: true

RSpec.describe Function::Telegram do
  let(:telegram) { described_class.new("token", ["123"]) }

  describe "#notify" do
    subject { telegram.notify("text") }

    it "send a request to Telegram API" do
      stub = stub_request(:post, "https://api.telegram.org/bottoken/sendMessage")
             .with(
               body: "{\"chat_id\":\"123\",\"text\":\"text\",\"parse_mode\":\"Markdown\"}"
             )
             .to_return(status: 200, body: "", headers: {})

      subject
      expect(stub).to have_been_requested
    end
  end
end
