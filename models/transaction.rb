# frozen_string_literal: true

class Transaction
  attr_reader :source_account, :destination_account, :amount, :timestamp

  def initialize(source_account, destination_account, amount)
    @source_account = source_account
    @destination_account = destination_account
    @amount = amount.to_f
    @timestamp = Time.now
  end
end
