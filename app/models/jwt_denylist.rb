# frozen_string_literal: true

# DenyList strategy implmentation model based on devise-jwt documentation
class JwtDenylist < ApplicationRecord
  include Devise::JWT::RevocationStrategies::Denylist

  self.table_name = 'jwt_denylist'
end
