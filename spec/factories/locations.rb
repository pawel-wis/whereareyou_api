# frozen_string_literal: true

FactoryBot.define do
  factory :location do
    longitude { rand(-180..180).round(7) }
    latitude { rand(-90..90).round(7) }
  end
end
