# frozen_string_literal: true

supported_tenants = {
  tenant_1: {
    slug: 'tenant_1',
    db_config: {
      database: 'test_rspec_multiple_database_1_test'
    }
  },
  tenant_2: {
    slug: 'tenant_2',
    db_config: {
      database: 'test_rspec_multiple_database_2_test'
    }
  }
}

TenantRealm.configure do |config|
  config.fetch_tenant = lambda { |identifier|
    supported_tenants[identifier.to_sym]
  }

  config.fetch_tenants = lambda {
    supported_tenants.values
  }

  config.dig_db_config = lambda { |tenant|
    tenant.try(:[], :db_config)
  }

  config.identifier_resolver = lambda { |request|
    request.headers['tenant']
  }

  config.shard_name_from_tenant = lambda { |tenant|
    tenant[:slug]
  }
end
