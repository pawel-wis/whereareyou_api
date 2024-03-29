# frozen_string_literal: true

# User model implementation related with Devise gem
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one :location
  has_one :party_membership
  has_one :party, through: :party_membership
  devise :database_authenticatable, :registerable,
         :jwt_authenticatable,
         jwt_revocation_strategy: JwtDenylist
  validates_presence_of :email, :password, :username
  validates_uniqueness_of :email, :username
  validates_confirmation_of :password
end
