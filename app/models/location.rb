# frozen_string_literal: true

# Location model stores user coordinates in a relation in user model.
class Location < ApplicationRecord
  belongs_to :user
  validates_inclusion_of :latitude, in: -90..90
  validates_inclusion_of :longitude, in: -180..180
end
