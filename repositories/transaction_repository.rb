# frozen_string_literal: true

class TransactionRepository
  def initialize
    @transactions = []
  end

  def add_transaction(transaction)
    @transactions << transaction
  end

  def all_transactions
    @transactions
  end
end
