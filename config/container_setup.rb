# frozen_string_literal: true

require_relative "../lib/ioc_container"
require_relative "../services/transaction_csv_service"
require_relative "../services/account_service"
require_relative "../services/transaction_service"
require_relative "../services/account_csv_service"
require_relative "../services/transaction_csv_service"
require_relative "../repositories/account_repository"
require_relative "../repositories/transaction_repository"
require_relative "../repositories/transaction_request_repository"

def setup_container
  container = IocContainer.new

  container.register(:account_repository) { AccountRepository.new }
  container.register(:transaction_repository) { TransactionRepository.new }
  container.register(:transaction_request_repository) { TransactionRequestRepository.new }
  container.register(:account_service) do
    account_repository = container.resolve(:account_repository)
    AccountService.new(account_repository)
  end
  container.register(:transaction_service) do
    account_service = container.resolve(:account_service)
    account_repository = container.resolve(:account_repository)
    transaction_repository = container.resolve(:transaction_repository)
    TransactionService.new(account_service, account_repository, transaction_repository)
  end
  container.register(:account_csv_service) { AccountCSVService.new }
  container.register(:transaction_csv_service) { TransactionCSVService.new }

  container
end
