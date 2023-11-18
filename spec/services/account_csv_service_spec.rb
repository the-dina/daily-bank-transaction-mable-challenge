# frozen_string_literal: true

require "services/account_csv_service"
require "models/account"

RSpec.describe AccountCSVService do
  describe ".load_accounts" do
    let(:file_path) { "spec/fixtures/sample_accounts.csv" }

    it "correctly creates account objects from a CSV file" do
      accounts = AccountCSVService.load_accounts(file_path)

      expect(accounts.length).to eq(5)

      expect(accounts[0]).to have_attributes(account_number: "1234567890123456", balance: 10000.00)
      expect(accounts[1]).to have_attributes(account_number: "1111222233334444", balance: 15000.00)
      expect(accounts[2]).to have_attributes(account_number: "9876543210987654", balance: 5000.00)
      expect(accounts[3]).to have_attributes(account_number: "1234987612349876", balance: 7500.00)
      expect(accounts[4]).to have_attributes(account_number: "5555666677778888", balance: 12000.00)
    end
  end
end
