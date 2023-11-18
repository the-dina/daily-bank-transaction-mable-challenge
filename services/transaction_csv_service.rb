# frozen_string_literal: true

require_relative "csv_reader_service"
require_relative "../models/transaction_request"

class TransactionCSVService
  def self.load_transaction_requests(file_path)
    transaction_requests = []
    CSVReaderService.read_csv(file_path).each do |transaction_data|
      source_account, destination_account, amount = transaction_data
      transaction_requests << TransactionRequest.new(source_account, destination_account, amount)
    end
    transaction_requests
  end
end
