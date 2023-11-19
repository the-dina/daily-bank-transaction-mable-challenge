# frozen_string_literal: true

require "controllers/app_controller"
require "config/container_setup"
require "models/account"
require "models/transaction_request"

RSpec.describe AppController do
  let(:container) { setup_container }
  let(:account_csv_file) { "spec/fixtures/sample_accounts.csv" }
  let(:transaction_csv_file) { "spec/fixtures/sample_transactions.csv" }
  let(:controller) { AppController.new(account_csv_file, transaction_csv_file, container) }

  describe "#run" do
    before do
      controller.run
    end

    it "correctly updates account balances after processing transactions" do
      accounts = container.resolve(:account_repository).all_accounts
      expect(accounts.find { |acc| acc.account_number == "1234567890123456" }).to have_attributes(balance: 8000.00)
      expect(accounts.find { |acc| acc.account_number == "1111222233334444" }).to have_attributes(balance: 15500.00)
      expect(accounts.find { |acc| acc.account_number == "9876543210987654" }).to have_attributes(balance: 5500.00)
      expect(accounts.find { |acc| acc.account_number == "1234987612349876" }).to have_attributes(balance: 8000.00)
      expect(accounts.find { |acc| acc.account_number == "5555666677778888" }).to have_attributes(balance: 12500.00)
    end

    it "correctly updates transaction request statuses" do
      transaction_requests = container.resolve(:transaction_request_repository).all_requests

      expect(transaction_requests.length).to eq(4)

      expect(transaction_requests[0]).to have_attributes(
        source_account: "1234567890123456",
        destination_account: "1111222233334444",
        amount: 2000.00,
        status: "processed",
      )
      expect(transaction_requests[1]).to have_attributes(
        source_account: "1111222233334444",
        destination_account: "9876543210987654",
        amount: 1500.00,
        status: "processed",
      )
      expect(transaction_requests[2]).to have_attributes(
        source_account: "9876543210987654",
        destination_account: "1234987612349876",
        amount: 1000.00,
        status: "processed",
      )
      expect(transaction_requests[3]).to have_attributes(
        source_account: "1234987612349876",
        destination_account: "5555666677778888",
        amount: 500.00,
        status: "processed",
      )
    end

    it "creates transactions for processed requests" do
      transactions = container.resolve(:transaction_repository).all_transactions

      expect(transactions.length).to eq(4) # Assuming 4 transactions should be created

      expect(transactions[0]).to have_attributes(
        source_account: "1234567890123456",
        destination_account: "1111222233334444",
        amount: 2000.00,
      )
      expect(transactions[1]).to have_attributes(
        source_account: "1111222233334444",
        destination_account: "9876543210987654",
        amount: 1500.00,
      )
      expect(transactions[2]).to have_attributes(
        source_account: "9876543210987654",
        destination_account: "1234987612349876",
        amount: 1000.00,
      )
      expect(transactions[3]).to have_attributes(
        source_account: "1234987612349876",
        destination_account: "5555666677778888",
        amount: 500.00,
      )
    end

    context "when transaction requests are not valid" do
      let(:transaction_csv_file) { "spec/fixtures/sample_bad_transactions.csv" }

      it "marks bad transaction requests as failed" do
        transaction_requests = container.resolve(:transaction_request_repository).all_requests

        expect(transaction_requests.length).to eq(3)

        # source_account doesn't exist
        expect(transaction_requests[0]).to have_attributes(
          source_account: "9999999999999999",
          destination_account: "1111222233334444",
          amount: 1000.00,
          status: "failed",
        )

        # destination doesn't exist
        expect(transaction_requests[1]).to have_attributes(
          source_account: "1234567890123456",
          destination_account: "9999999999999999",
          amount: 1000.00,
          status: "failed",
        )

        # source account doesn't have enough fund
        expect(transaction_requests[2]).to have_attributes(
          source_account: "1234567890123456",
          destination_account: "1111222233334444",
          amount: 50000.00,
          status: "failed",
        )
      end
    end
  end
end
