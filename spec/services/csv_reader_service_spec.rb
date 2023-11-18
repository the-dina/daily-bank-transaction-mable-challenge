# frozen_string_literal: true

require "services/csv_reader_service"

RSpec.describe CSVReaderService do
  describe ".read_csv" do
    let(:file_path) { "spec/fixtures/sample_accounts.csv" }
    let(:expected_result) do
      [
        ["1234567890123456", "10000.00"],
        ["1111222233334444", "15000.00"],
        ["9876543210987654", "5000.00"],
        ["1234987612349876", "7500.00"],
        ["5555666677778888", "12000.00"],
      ]
    end

    it "correctly reads and parses a CSV file" do
      result = CSVReaderService.read_csv(file_path)
      expect(result).to eq(expected_result)
    end
  end
end
