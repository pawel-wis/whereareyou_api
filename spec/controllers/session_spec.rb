# frozen_string_literal: true

require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe Users::SessionsController, type: :controller do
  describe 'POST /users/login' do
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
    it "shouldn't log in with wrong email" do
      user = FactoryBot.create(:user)
      post :create, params: {
        user: {
          email: "#{user.email}1927409",
          password: user.password
        }
      }
      expect(response).to have_http_status :unauthorized
      expect(response.body).to include('Invalid Email or password')
    end
    it "shouldn't log in with wrong password" do
      user = FactoryBot.create(:user)
      post :create, params: {
        user: {
          email: user.email,
          password: "#{user.password}wrong123"
        }
      }
      expect(response).to have_http_status :unauthorized
      expect(response.body).to include('Invalid Email or password')
    end
  end

  describe 'POST /users/logout' do
    it "user can't destroy token is not created before" do
      user = FactoryBot.create(:user)
      post :destroy, params: {
        user: {
          email: user.email,
          password: user.password
        }
      }
      expect(response).to have_http_status :unauthorized
      expect(response.body).to include('message')
    end

    it 'user can destroy token by loggin out' do
      user = FactoryBot.create(:user)
      Devise::JWT::TestHelpers.auth_headers(request.headers, user)
      post :destroy
      expect(response).to have_http_status :ok
    end
  end
end
