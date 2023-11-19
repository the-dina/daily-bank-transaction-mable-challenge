# Daily Bank Transaction - Mable Challenge

## The Challenge
Link to the [challenge description](challenge.md) for more details.

## Installed Gems
- `rspec` - A testing tool for Ruby.
- `pry` and `pry-byebug` - Interactive debugging tools.
- `simplecov` - Used for measuring test coverage.

## Run Without Local Setup
To run the app in an environment other than your local setup, it functions seamlessly in the default container of GitHub Codespaces. Ruby is pre-installed, so simply use the following button to create a Codespace, which takes about a minute to set up. Then, run `bundle` to install dependencies.

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/the-dina/daily-bank-transaction-mable-challenge)

## How to Run the App
Execute the following command to start the application:
```
ruby app.rb ./data/accounts.csv ./data/transaction_requests.csv
```
This will process the transactions as per the data in the provided CSV files and display the final state of accounts and transaction requests.


Result will be:
```
~/dev/daily-bank-transaction-mable-challenge > ruby app.rb ./data/accounts.csv ./data/transaction_requests.csv

Final state of accounts:
Account: 1111234522226789, Balance: 4820.50
Account: 1111234522221234, Balance: 9974.40
Account: 2222123433331212, Balance: 1550.00
Account: 1212343433335665, Balance: 1725.60
Account: 3212343433335755, Balance: 48679.50

Transaction requests:
From: 1111234522226789, To: 1212343433335665, Amount: 500.00, Status: PROCESSED
From: 3212343433335755, To: 2222123433331212, Amount: 1000.00, Status: PROCESSED
From: 3212343433335755, To: 1111234522226789, Amount: 320.50, Status: PROCESSED
From: 1111234522221234, To: 1212343433335665, Amount: 25.60, Status: PROCESSED
```

## How to Run the Specs (Tests)
Run the tests using RSpec to ensure the application is functioning correctly:
```
rspec ./spec/
```

## Checking Test Coverage
To assess test coverage:
- Run `rspec ./spec/`
- Open `coverage/index.html` in a web browser to view the detailed coverage report.

## Single Responsibility Principle
This application is designed with the Single Responsibility Principle in mind. Each component has a specific role:
- `Models` handle data representation.
- `Repositories` are responsible for data storage.
- `Services` manage business logic.
- `App Controller` orchestrates the interaction between these components.

## Dependency Injection
Dependencies in services are injected through their constructors, promoting flexibility and ease of testing. An IoC (Inversion of Control) Container is implemented in the `lib` directory, which is utilized by `app_controller` to manage dependencies.

## Transaction Request vs Transaction

### Transaction Request
A `transaction_request` represents the initial data we receive from the CSV file. This data indicates a desire to transfer funds from a source account to a destination account. However, not all transaction requests are guaranteed to be processed successfully.

### Transaction
When a `transaction_request` is processed successfully, a `transaction` is created. This transaction reflects the successful transfer of funds between accounts.

### Failed Transaction Requests
There are scenarios where a transaction request might fail. In such cases, the status of the `transaction_request` is updated to 'failed', and this is reflected in the console output. The reasons for a transaction request failing include:

1. **Invalid Source Account**: The account from which funds are to be transferred does not exist or is not recognized.
2. **Invalid Destination Account**: The account to which funds are to be transferred is invalid or unrecognized.
3. **Insufficient Funds in Source Account**: The source account does not have enough funds to complete the transaction.

### Testing and Handling Failures
Although the provided CSV files contain only successful transaction scenarios (the happy path), the robustness of the application is ensured through extensive testing. Both `transaction_service` and `app_controller` tests confirm that invalid transaction requests are handled appropriately, ensuring reliability and accuracy in transaction processing.


## Application Structure

```
banking_system/
│
├── app.rb                    # Main application file
│
├── controllers/              # Controllers directory
│   └── app_controller.rb     # Our main application controller
│
├── services/                 # Service classes
│   ├── account_service.rb
│   ├── transaction_service.rb
│   ├── csv_reader_service.rb
│   ├── account_csv_service.rb
│   └── transaction_csv_service.rb
│
├── models/                   # Domain models
│   ├── account.rb
│   ├── transaction.rb
│   └── transaction_request.rb
│
├── repositories/             # Repositories for data storage
│   ├── account_repository.rb
│   ├── transaction_repository.rb
│   └── transaction_request_repository.rb
│
├── spec/                     # RSpec tests
│   ├── controllers/
│   ├── models/   
│   ├── services/
│   └── repositories/
│
└── config/                   # configurations
│   └── container_setup.rb
│
└── lib/                      # Utility libraries
│   └── ioc_container.rb
│
└── data/                     # Directory for CSV files and other data
    ├── accounts.csv
    └── transaction_requests.csv
```
