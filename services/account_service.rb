# frozen_string_literal: true

class AccountService
  def initialize(account_repository)
    @account_repository = account_repository
  end

  def update_account_balance(account_number, balance_change)
    account = @account_repository.get_account(account_number)
    raise "Account #{account_number} does not exist" unless account

    new_balance = account.balance + balance_change
    if new_balance >= 0
      account.balance = new_balance
      @account_repository.update_account(account)
    else
      raise "Insufficient funds in account #{account_number}"
    end
  end
end
