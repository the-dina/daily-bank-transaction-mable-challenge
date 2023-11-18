# frozen_string_literal: true

class AccountRepository
  def initialize
    @accounts = {}
  end

  def add_account(account)
    @accounts[account.account_number] = account
  end

  def add_accounts(accounts)
    accounts.each do |account|
      add_account(account)
    end
  end

  def get_account(account_number)
    @accounts[account_number]
  end

  def update_account(account)
    @accounts[account.account_number] = account
  end

  def all_accounts
    @accounts.values
  end
end
