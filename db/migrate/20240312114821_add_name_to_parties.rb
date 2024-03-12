# frozen_string_literal: true

# Migration adds name column to parties table
class AddNameToParties < ActiveRecord::Migration[7.1]
  def change
    add_column :parties, :name, :string
  end
end
