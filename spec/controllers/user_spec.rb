# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :controller do
  describe 'POST /users' do
    it 'new user should be created' do
      @request.env["devise.mapping"] = Devise.mappings[:user]

      user = FactoryBot.build(:user)

      post :create, params: {
        user: {
          email: user.email,
          password: user.password,
          password_confirmation:  user.password,
          username: user.username
        }
      }
      expect(response).to have_http_status :created
      response_as_hash = JSON.parse(response.body)
      expect(response_as_hash.keys).to include('message', 'user')
      expect(response_as_hash['user'].keys).to include('id')
    end
  end
end
