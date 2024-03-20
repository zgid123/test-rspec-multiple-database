# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "#{Faker::Internet.email}_#{n}" }
  end
end
