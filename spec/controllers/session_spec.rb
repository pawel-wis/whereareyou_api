# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::SessionsController, type: :controller do
  describe 'POST /users/sign_in' do
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:user]
    end

    it 'should log in an user' do
      user = FactoryBot.create(:user)
      post :create, params: {
        user: {
          email: user.email,
          password: user.password
        }
      }
      expect(response).to have_http_status :ok
      response_hash = JSON.parse(response.body)
      expect(response_hash.keys).to include('message', 'user')
      expect(response_hash['user']).to include('id')
    end
  end
end
