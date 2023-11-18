require 'repositories/transaction_repository'
require 'models/transaction'

RSpec.describe TransactionRepository do
  let(:repository) { TransactionRepository.new }
  let(:transaction1) { Transaction.new("1234567890123456", "6543210987654321", 300.00) }
  let(:transaction2) { Transaction.new("6543210987654321", "1234567890123456", 150.00) }

  describe "adding and retrieving transactions" do
    it "adds transactions and retrieves them correctly" do
      repository.add_transaction(transaction1)
      repository.add_transaction(transaction2)
      transactions = repository.all_transactions
      expect(transactions.length).to eq(2)
      expect(transactions).to include(transaction1, transaction2)
    end
  end
end
