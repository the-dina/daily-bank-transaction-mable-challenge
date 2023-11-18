# Daily Bank Transaction - Mable Challenge

## The challenge
Link to the [challenge.](challenge.md)

## Installed gems
- rspec
- Rubymine debugging related gems
- pry and pry-byebug
- simplecov (for test coverage)

## How to run the app
```
ruby app.rb ./data/accounts.csv ./data/transaction_requests.csv
```

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

## How to run the specs(tests)
```
rspec ./spec/
```

__How to Check The Test Coverage__
- run `rspec ./spec/` 
- run `open coverage/index.html` to open the html report


## App's structure
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
