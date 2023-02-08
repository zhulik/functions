# frozen_string_literal: true

RSpec.describe Function::Handler do
  let(:handler) { described_class.new({}) }

  describe "#call" do
    subject { handler.call }

    it "does" do
      expect(subject).to be_nil
    end
  end
end
