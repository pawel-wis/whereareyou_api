# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'user is created with minunim name email and password' do
    user = FactoryBot.create(:user)
    db_user = User.where('username = :username and email = :email',
                         { username: user.username, email: user.email }).first
    expect(db_user).to_not be_nil
    expect(db_user.username).to eq(user.username)
    expect(db_user.email).to eq(user.email)
    expect(user.new_record?).to eq(false)
  end

  it "user isn't created without email provided" do
    user = FactoryBot.build(:user)
    user.email = nil
    expect do
      user.save!
    end.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "user isn't created withou password provided" do
    user = FactoryBot.build(:user)
    user.password = nil
    expect do
      user.save!
    end.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "user isn't created withou name provided" do
    user = FactoryBot.build(:user)
    user.username = nil
    expect do
      user.save!
    end.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'created user should have hashed password' do
    user = FactoryBot.create(:user)
    db_user = User.where('username = :username and email = :email',
                         { username: user.username, email: user.email }).first
    expect(user.password).not_to eq(db_user.password)
  end

  it "can't create user with same email as existed" do
    user = FactoryBot.create(:user)
    new_user = FactoryBot.build(:user)
    new_user.email = user.email
    expect do
      new_user.save!
    end.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "can't create user with same username as existed" do
    user = FactoryBot.create(:user)
    new_user = FactoryBot.build(:user)
    new_user.username = user.username
    expect do
      new_user.save!
    end.to raise_error(ActiveRecord::RecordInvalid)
  end
end
