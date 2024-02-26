# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :controller do
  describe 'POST /users' do
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
    end

    it 'new user should be created' do
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

    it "can't create user with the same email" do
      user = FactoryBot.create(:user)
      new_user = user.clone
      new_user.username += "123"
      post :create, params: {
        user: {
          email: new_user.email,
          password: new_user.password,
          password_confirmation:  new_user.password,
          username: new_user.username
        }
      }
      expect(response).to have_http_status :conflict
      expect(response.body).to include('message')
    end

    it "can't create user with the same username" do
      user = FactoryBot.create(:user)
      new_user = user.clone
      new_user.email.prepend("TestMe")
      post :create, params: {
        user: {
          email: new_user.email,
          password: new_user.password,
          password_confirmation:  new_user.password,
          username: new_user.username
        }
      }
      expect(response).to have_http_status :conflict
      expect(response.body).to include('message')
    end

    it "can't create user with missing mandatory field" do
      user = FactoryBot.build(:user)
      json_template = {
        user: {
          email: user.email,
          password: user.password,
          password_confirmation:  user.password,
          username: user.username
        }
      }
      mandatory_fields = [:username, :password, :password_confirmation, :email]
      mandatory_fields.each do |field|
        bad_request = json_template.clone
        bad_request[:user].delete(field)
        post :create, params: bad_request
        expect(response).to have_http_status :unprocessable_entity
        expect(response.body).to include('message')
      end
    end
  end
end
