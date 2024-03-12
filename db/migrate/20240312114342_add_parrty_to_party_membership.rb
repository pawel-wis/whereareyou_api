# frozen_string_literal: true

# Migrations adds party reference
class AddPartyToPartyMembership < ActiveRecord::Migration[7.1]
  def change
    add_reference :party_memberships, :party, null: true, foreign_key: true
  end
end
