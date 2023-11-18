# frozen_string_literal: true

require "services/account_service"
require "models/account"
require "repositories/account_repository"

RSpec.describe AccountService do
  let(:account_repository) { AccountRepository.new }
  let(:service) { AccountService.new(account_repository) }
  let(:account1) { Account.new("1234567890123456", 1000.00) }
  let(:account2) { Account.new("6543210987654321", 2000.00) }

  describe "#update_account_balance" do
    context "with sufficient funds" do
      it "updates the account balance" do
        account_repository.add_accounts([account1])
        service.update_account_balance("1234567890123456", -500.00)
        expect(account_repository.get_account("1234567890123456").balance).to eq(500.00)
      end
    end

    context "with insufficient funds" do
      it "raises an error" do
        account_repository.add_accounts([account1])
        expect { service.update_account_balance("1234567890123456", -1500.00) }.to raise_error(RuntimeError, /Insufficient funds/)
      end
    end

    context "with non-existent account" do
      it "raises an error" do
        expect { service.update_account_balance("nonexistent", 500.00) }.to raise_error(RuntimeError, /Account nonexistent does not exist/)
      end
    end
  end
end
