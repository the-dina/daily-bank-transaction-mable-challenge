# frozen_string_literal: true

require "models/transaction"

RSpec.describe Transaction do
  let(:transaction) { Transaction.new("1234567890123456", "6543210987654321", 300.00) }

  describe "initialization" do
    it "is initialized with source, destination, amount, and timestamp" do
      expect(transaction.source_account).to eq("1234567890123456")
      expect(transaction.destination_account).to eq("6543210987654321")
      expect(transaction.amount).to eq(300.00)
      expect(transaction.timestamp).to be_a(Time)
    end
  end
end
