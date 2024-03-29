# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :party do
    name { Faker::Name.unique.name }
  end
end
