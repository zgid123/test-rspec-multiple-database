# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    users = User.all

    p "test controller from #{ActiveRecord::Base.connection_db_config.configuration_hash[:database]}"
    p users

    render json: {
      data: users
    }
  end
end
