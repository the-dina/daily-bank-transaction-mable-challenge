# frozen_string_literal: true

class Account
  attr_accessor :account_number, :balance

  def initialize(account_number, balance)
    validate_account_number(account_number)
    @account_number = account_number
    @balance = balance.to_f
  end

  private

  def validate_account_number(account_number)
    unless account_number.to_s.match?(/^\d{16}$/)
      raise ArgumentError, "Account number must be a 16-digit number"
    end
  end
end
