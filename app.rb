require "pry-byebug"
require_relative "config/container_setup"
require_relative "controllers/app_controller"

if ARGV.length != 2
  puts "Usage: ruby app.rb ACCOUNTS_CSV_FILE TRANSACTIONS_CSV_FILE"
  exit
end

# Setup IoC container
ioc_container = setup_container

# Extract files from command-line arguments
accounts_csv_file, transaction_requests_csv_file = ARGV

# Create AppController with dependencies from the container
controller = AppController.new(accounts_csv_file, transaction_requests_csv_file, ioc_container)
controller.run

# Output the final state of accounts and transaction requests
puts "\nFinal state of accounts:"
account_repository = ioc_container.resolve(:account_repository)
account_repository.all_accounts.each do |account|
  puts "Account: #{account.account_number}, Balance: #{"%.2f" % account.balance}"
end

puts "\nTransaction requests:"
transaction_request_repository = ioc_container.resolve(:transaction_request_repository)
transaction_request_repository.all_requests.each do |request|
  status = request.status.upcase
  puts "From: #{request.source_account}, To: #{request.destination_account}, Amount: #{"%.2f" % request.amount}, Status: #{status}"
end
