# frozen_string_literal: true

require_relative "../models/transaction"

class TransactionService
  def initialize(account_service, account_repository, transaction_repository)
    @account_service = account_service
    @account_repository = account_repository
    @transaction_repository = transaction_repository
  end

  def process_transactions(transaction_requests)
    transaction_requests.each do |request|
      process_transaction_request(request)
    end
  end

  private

  def process_transaction_request(request)
    unless valid_transaction_request?(request)
      request.status = "failed"
      return
    end

    @account_service.update_account_balance(request.source_account, -request.amount)
    @account_service.update_account_balance(request.destination_account, request.amount)
    request.status = "processed"
    transaction = Transaction.new(request.source_account, request.destination_account, request.amount)
    @transaction_repository.add_transaction(transaction)
  end

  def valid_transaction_request?(request)
    # Check if both accounts exist and the source account has sufficient funds
    source_account = @account_repository.get_account(request.source_account)
    destination_account = @account_repository.get_account(request.destination_account)
    source_account && destination_account && source_account.balance >= request.amount
  end
end
