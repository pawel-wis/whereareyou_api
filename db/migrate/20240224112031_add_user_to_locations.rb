# frozen_string_literal: true

# Addition one-to-one user relation to Location model
class AddUserToLocations < ActiveRecord::Migration[7.1]
  def change
    add_reference :locations, :user, null: false, foreign_key: true
  end
end
