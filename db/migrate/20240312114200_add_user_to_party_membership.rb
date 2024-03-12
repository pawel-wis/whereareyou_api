# frozen_string_literal: true

# Migration adds user reference to membership proxy
class AddUserToPartyMembership < ActiveRecord::Migration[7.1]
  def change
    add_reference :party_memberships, :user, null: true, foreign_key: true
  end
end
