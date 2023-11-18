require "repositories/transaction_request_repository"
require "models/transaction_request"

RSpec.describe TransactionRequestRepository do
  let(:repository) { TransactionRequestRepository.new }
  let(:request1) { TransactionRequest.new("1234567890123456", "6543210987654321", 200.00) }
  let(:request2) { TransactionRequest.new("6543210987654321", "1234567890123456", 500.00) }

  describe "adding and retrieving transaction requests" do
    it "adds transaction requests and retrieves them correctly" do
      repository.add_request(request1)
      repository.add_request(request2)
      requests = repository.all_requests
      expect(requests.length).to eq(2)
      expect(requests).to include(request1, request2)
    end
  end

  describe "#add_requests" do
    it "adds multiple transaction requests to the repository" do
      repository.add_requests([request1, request2])
      expect(repository.all_requests).to include(request1, request2)
    end
  end
end
