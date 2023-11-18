# frozen_string_literal: true

require "lib/ioc_container"

RSpec.describe IocContainer do
  let(:container) { IocContainer.new }

  describe "#register and #resolve" do
    before do
      container.register(:test_service) { "Test Service" }
    end

    it "correctly registers and resolves a service" do
      expect(container.resolve(:test_service)).to eq("Test Service")
    end

    it "returns the same instance on multiple resolves" do
      first_instance = container.resolve(:test_service)
      second_instance = container.resolve(:test_service)
      expect(first_instance).to be(second_instance)
    end
  end

  describe "dependency management" do
    it "resolves services with dependencies" do
      container.register(:dependency) { "Dependency" }
      container.register(:dependent_service) do
        "Service with #{container.resolve(:dependency)}"
      end

      expect(container.resolve(:dependent_service)).to eq("Service with Dependency")
    end
  end
end
