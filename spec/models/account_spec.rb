# frozen_string_literal: true

require "models/account"

RSpec.describe Account do
  describe "initialization" do
    context "with valid account number" do
      let(:account) { Account.new("1234567890123456", 1000.00) }

      it "is initialized with an account number and balance" do
        expect(account.account_number).to eq("1234567890123456")
        expect(account.balance).to eq(1000.00)
      end
    end

    context "with invalid account number" do
      it "raises an ArgumentError for a short account number" do
        expect { Account.new("123", 1000.00) }.to raise_error(ArgumentError, "Account number must be a 16-digit number")
      end

      it "raises an ArgumentError when there a non-digit character in account number" do
        expect { Account.new("12345678901234a5", 1000.00) }.to raise_error(ArgumentError, "Account number must be a 16-digit number")
      end
    end
  end
end
