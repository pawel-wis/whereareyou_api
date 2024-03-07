# frozen_string_literal: true

require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe LocationsController, type: :controller do
  describe 'PUT /users/:id/locations' do
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      @current_user = FactoryBot.create(:user)
      Devise::JWT::TestHelpers.auth_headers(request.headers, @current_user)
    end

    it 'should create new user location' do
      location = FactoryBot.build(:location)

      put :update, params: {
        id: @current_user.id,
        location: {
          longitude: location.longitude,
          latitude: location.latitude
        }
      }
      expect(response).to have_http_status :ok
    end

    it 'should return 442 if permitted parameter is missing' do
      location = FactoryBot.build(:location)

      put :update, params: {
        id: @current_user.id,
        location: {
          longitude: location.longitude
        }
      }
      expect(response).to have_http_status :unprocessable_entity
      put :update, params: {
        id: @current_user.id,
        location: {
          latitude: location.latitude
        }
      }
      expect(response).to have_http_status :unprocessable_entity
    end

    it "can't update locaiton for other user than me" do
      other_user = FactoryBot.create(:user)
      location = FactoryBot.build(:location)

      put :update, params: {
        id: other_user.id,
        location: {
          latitude: location.latitude
        }
      }
      expect(response).to have_http_status :unauthorized
    end
  end
end
