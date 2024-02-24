class Location < ApplicationRecord
  belongs_to :user
  validates_inclusion_of :latitude, in: -90..90
  validates_inclusion_of :longitude, in: -180..180
end
