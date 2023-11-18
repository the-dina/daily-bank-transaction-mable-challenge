# frozen_string_literal: true

class IocContainer
  def initialize
    @services = {}
    @instances = {}
  end

  def register(service_name, &block)
    @services[service_name] = block
  end

  def resolve(service_name)
    @instances[service_name] ||= @services[service_name].call
  end
end
