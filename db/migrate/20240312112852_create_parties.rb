# frozen_string_literal: true

# Migration creates raw parties table
class CreateParties < ActiveRecord::Migration[7.1]
  def change
    create_table :parties, &:timestamps
  end
end
