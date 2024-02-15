# frozen_string_literal: true

# Migration for JWT. It reflects DenyList strategy taken form devise-jwt docuemntation.
class CreateJwtDenylist < ActiveRecord::Migration[7.1]
  def change
    create_table :jwt_denylist do |t|
      t.string :jti, null: false
      t.datetime :exp, null: false

      t.timestamps
    end
    add_index :jwt_denylist, :jti
  end
end
