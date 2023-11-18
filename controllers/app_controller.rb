# frozen_string_literal: true

require_relative "../services/account_csv_service"
require_relative "../services/transaction_csv_service"

class AppController
  def initialize(account_csv_file, transaction_csv_file, container)
    @account_csv_file = account_csv_file
    @transaction_csv_file = transaction_csv_file
    @account_repository = container.resolve(:account_repository)
    @transaction_request_repository = container.resolve(:transaction_request_repository)
    @transaction_service = container.resolve(:transaction_service)
  end

  def run
    load_accounts
    load_transaction_requests
    process_transactions
  end

  private

  def load_accounts
    accounts = AccountCSVService.load_accounts(@account_csv_file)
    @account_repository.add_accounts(accounts)
  end

  def load_transaction_requests
    transaction_requests = TransactionCSVService.load_transaction_requests(@transaction_csv_file)
    @transaction_request_repository.add_requests(transaction_requests)
  end

  def process_transactions
    all_requests = @transaction_request_repository.all_requests
    @transaction_service.process_transactions(all_requests)
  end
end
