# frozen_string_literal: true
require "services/transaction_csv_service"
require "models/transaction_request"

RSpec.describe TransactionCSVService do
  describe '.load_transaction_requests' do
    let(:file_path) { 'spec/fixtures/sample_transactions.csv' }

    it 'correctly creates transaction request objects from a CSV file' do
      transaction_requests = TransactionCSVService.load_transaction_requests(file_path)

      expect(transaction_requests.length).to eq(4)

      expect(transaction_requests[0]).to have_attributes(source_account: '1234567890123456', destination_account: '1111222233334444', amount: 2000.00)
      expect(transaction_requests[1]).to have_attributes(source_account: '1111222233334444', destination_account: '9876543210987654', amount: 1500.00)
      expect(transaction_requests[2]).to have_attributes(source_account: '9876543210987654', destination_account: '1234987612349876', amount: 1000.00)
      expect(transaction_requests[3]).to have_attributes(source_account: '1234987612349876', destination_account: '5555666677778888', amount: 500.00)
    end
  end
end
