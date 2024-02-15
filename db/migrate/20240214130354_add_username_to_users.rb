# frozen_string_literal: true

# Add username as additional field to users table
class AddUsernameToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :username, :string
  end
end
