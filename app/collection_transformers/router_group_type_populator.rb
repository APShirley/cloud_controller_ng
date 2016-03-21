module VCAP::CloudController
  class RouterGroupTypePopulator
    attr_reader :routing_api_client

    def initialize(routing_api_client)
      @routing_api_client = routing_api_client
    end

    def transform(domains, opts={})
      return domains if routing_api_client.nil?
      router_groups = routing_api_client.router_groups
      router_group_mapping = {}
      router_groups.each do |router_group|
        router_group_mapping[router_group.guid] = router_group.types
      end
      domains.each { |domain| domain.router_group_types = router_group_mapping[domain.router_group_guid] unless domain.router_group_guid.nil? }
    end
  end
end
