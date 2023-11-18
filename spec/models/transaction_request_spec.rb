# frozen_string_literal: true

require "models/transaction_request"

RSpec.describe TransactionRequest do
  let(:transaction_request) { TransactionRequest.new("1234567890123456", "6543210987654321", 500.00) }

  describe "initialization" do
    it "is initialized with source, destination, and amount" do
      expect(transaction_request.source_account).to eq("1234567890123456")
      expect(transaction_request.destination_account).to eq("6543210987654321")
      expect(transaction_request.amount).to eq(500.00)
    end

    it "has a default status of pending" do
      expect(transaction_request.status).to eq("pending")
    end
  end
end
