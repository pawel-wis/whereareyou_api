# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Party, type: :model do
  it 'should create new empty party' do
    p = FactoryBot.build(:party)
    p.save
    expect(Party.find_by(name: p.name)).to_not be_nil
  end

  it "shouldn't create party without name" do
    p = FactoryBot.build(:party)
    p.name = nil
    expect(p.save).to be_falsey
  end

  it 'should add user to party' do
    p = FactoryBot.create(:party)
    u = FactoryBot.create(:user)
    p.users << u
    p.save
    expect(Party.find_by(name: p.name).users).to_not be_empty
  end

  it 'should add couple of user to party' do
    p = FactoryBot.create(:party)
    users_to_add = []
    10.times do
      users_to_add << FactoryBot.create(:user)
    end
    p.users.push(*users_to_add)
    p.save
    expect(Party.find_by(name: p.name).users.length).to eq(users_to_add.length)
  end
end
