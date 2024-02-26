# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Location, type: :model do
  let(:user) do
    FactoryBot.create(:user)
  end

  it 'should create location record with user reference' do
    location = FactoryBot.build(:location)
    location.user = user
    location.save
    location_db = Location.find_by(id: location.id)
    expect(location_db.id).to eq(location.id)
    expect(location_db.user_id).to eq(location.user_id)
  end

  it 'should not create location if latitude is out of rage' do
    location = FactoryBot.build(:location)
    location.latitude = -91
    location.user = user
    expect(location.save).to be_falsey
    location.latitude = 90.1
    expect(location.save).to be_falsey
  end

  it 'should not create location if longitude is out of rage' do
    location = FactoryBot.build(:location)
    location.longitude = -180.5
    location.user = user
    expect(location.save).to be_falsey
    location.longitude = 181
    expect(location.save).to be_falsey
  end

  it 'should not create location without user reference' do
    location = FactoryBot.build(:location)
    expect(location.save).to be_falsey
  end
end
