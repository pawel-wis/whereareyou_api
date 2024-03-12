# frozen_string_literal: true

# Proxy model to create many to one association.
class PartyMembership < ApplicationRecord
  belongs_to :user
  belongs_to :party
end
