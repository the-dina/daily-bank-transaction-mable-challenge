# frozen_string_literal: true

class TransactionRequestRepository
  def initialize
    @requests = []
  end

  def add_request(request)
    @requests << request
  end

  def add_requests(requests)
    @requests.concat(requests)
  end

  def all_requests
    @requests
  end
end
