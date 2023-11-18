# frozen_string_literal: true
require_relative "csv_reader_service"
require_relative "../models/account"

class AccountCSVService
  def self.load_accounts(file_path)
    accounts = []
    CSVReaderService.read_csv(file_path).each do |account_data|
      account_number, balance = account_data
      accounts << Account.new(account_number, balance)
    end
    accounts
  end
end
