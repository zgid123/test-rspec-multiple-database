# frozen_string_literal: true

require 'rails_helper'

root_db_config = TenantRealm::DbContext.root_db_config
tenant_1_db_config = root_db_config.merge(database: 'test_rspec_multiple_database_1_test')
tenant_2_db_config = root_db_config.merge(database: 'test_rspec_multiple_database_2_test')

RSpec.describe UsersController, type: :request do
  let!(:tenant_1_user) do
    ActiveRecord::Tasks::DatabaseTasks.with_temporary_connection(tenant_1_db_config) do
      p "create user from #{ActiveRecord::Base.connection_db_config.configuration_hash[:database]}"

      create(:user)
    end
  end

  let!(:tenant_2_user) do
    ActiveRecord::Tasks::DatabaseTasks.with_temporary_connection(tenant_2_db_config) do
      p "create user from #{ActiveRecord::Base.connection_db_config.configuration_hash[:database]}"

      create(:user)
    end
  end

  describe 'GET /users' do
    %i[tenant_1 tenant_2].each do |tenant|
      context "get user for #{tenant}" do
        before do
          get '/users', headers: { tenant: tenant.to_s }
        end

        it 'returns user list' do
          p "data #{tenant}_user"
          p send(:"#{tenant}_user")
          expect(response.parsed_body['email']).to eq(send(:"#{tenant}_user").email)
        end
      end
    end
  end
end
