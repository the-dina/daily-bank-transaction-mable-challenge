# frozen_string_literal: true

class TransactionRequest
  attr_accessor :source_account, :destination_account, :amount, :status

  def initialize(source_account, destination_account, amount)
    @source_account = source_account
    @destination_account = destination_account
    @amount = amount.to_f
    @status = "pending"
  end
end
