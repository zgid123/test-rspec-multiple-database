# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :email, index: { unique: true }
      t.string :first_name
      t.string :last_name

      t.timestamps
    end
  end
end
