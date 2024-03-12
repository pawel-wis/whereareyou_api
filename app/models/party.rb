# frozen_string_literal: true

# Party model stores users as party members.
class Party < ApplicationRecord
  has_many :party_membership
  has_many :users, through: :party_membership

  validates_presence_of :name
end
