# frozen_string_literal: true

require "repositories/account_repository"
require "models/account"

RSpec.describe AccountRepository do
  let(:repository) { AccountRepository.new }
  let(:account1) { Account.new("1234567890123456", 1000.00) }
  let(:account2) { Account.new("6543210987654321", 2000.00) }

  describe "adding and retrieving accounts" do
    it "adds and retrieves an account" do
      repository.add_account(account1)
      expect(repository.get_account("1234567890123456")).to have_attributes(account_number: "1234567890123456", balance: 1000.00)
    end
  end

  describe "#add_accounts" do
    it "adds multiple accounts to the repository" do
      repository.add_accounts([account1, account2])
      expect(repository.all_accounts).to include(account1, account2)
      expect(repository.get_account("1234567890123456").balance).to eq(1000.00)
      expect(repository.get_account("6543210987654321").balance).to eq(2000.00)
    end
  end

  describe "updating accounts" do
    it "updates the balance of an existing account" do
      repository.add_account(account1)
      account1.balance = 1500.00
      repository.update_account(account1)
      expect(repository.get_account("1234567890123456").balance).to eq(1500.00)
    end
  end

  describe "listing all accounts" do
    it "lists all added accounts with correct data" do
      repository.add_account(account1)
      repository.add_account(account2)
      accounts = repository.all_accounts

      expect(accounts.length).to eq(2)
      expect(accounts).to include(account1, account2)
    end
  end
end
