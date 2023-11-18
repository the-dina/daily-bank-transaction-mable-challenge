# frozen_string_literal: true

require "services/transaction_service"
require "models/transaction_request"
require "repositories/transaction_repository"
require "repositories/account_repository"
require "services/account_service"

RSpec.describe TransactionService do
  let(:account_repository) { AccountRepository.new }
  let(:account_service) { AccountService.new(account_repository) }
  let(:transaction_repository) { TransactionRepository.new }
  let(:service) { TransactionService.new(account_service, account_repository, transaction_repository) }
  let(:account1) { Account.new("1234567890123456", 1000.00) }
  let(:account2) { Account.new("6543210987654321", 2000.00) }

  before do
    account_repository.add_accounts([account1, account2])
  end

  describe "#process_transactions" do
    context "with multiple valid transaction requests" do
      let(:request1) { TransactionRequest.new("1234567890123456", "6543210987654321", 500.00) }
      let(:request2) { TransactionRequest.new("6543210987654321", "1234567890123456", 1000.00) }

      it "successfully processes all valid transaction requests" do
        service.process_transactions([request1, request2])
        expect(request1.status).to eq("processed")
        expect(request2.status).to eq("processed")
        expect(account_repository.get_account("1234567890123456").balance).to eq(1500.00)
        expect(account_repository.get_account("6543210987654321").balance).to eq(1500.00)

        created_transactions = transaction_repository.all_transactions
        expect(created_transactions.size).to eq(2)
        expect(created_transactions.first).to have_attributes(
          source_account: "1234567890123456",
          destination_account: "6543210987654321",
          amount: 500.00,
        )
        expect(created_transactions.last).to have_attributes(
          source_account: "6543210987654321",
          destination_account: "1234567890123456",
          amount: 1000.00,
        )
      end
    end

    context "when destination account does not exist" do
      let(:invalid_request) { TransactionRequest.new("1234567890123456", "nonexistent", 500.00) }

      it "fails to process the transaction request" do
        service.process_transactions([invalid_request])
        expect(invalid_request.status).to eq("failed")
        expect(transaction_repository.all_transactions.size).to eq(0)
      end
    end

    context "when source account does not exist" do
      let(:invalid_request) { TransactionRequest.new("nonexistent", "6543210987654321", 500.00) }

      it "fails to process the transaction request" do
        service.process_transactions([invalid_request])
        expect(invalid_request.status).to eq("failed")
        expect(transaction_repository.all_transactions.size).to eq(0)
      end
    end

    context "with transaction request causing negative balance" do
      let(:invalid_request) { TransactionRequest.new("1234567890123456", "6543210987654321", 1500.00) }

      it "fails to process the transaction request due to insufficient funds" do
        service.process_transactions([invalid_request])
        expect(invalid_request.status).to eq("failed")
        expect(transaction_repository.all_transactions.size).to eq(0)
        expect(account_repository.get_account("1234567890123456").balance).to eq(1000.00) # Unchanged balance
      end
    end
  end
end
