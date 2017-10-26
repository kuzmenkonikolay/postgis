require 'rails_helper'

RSpec.describe Location, :type => :model do
  let(:location) { create(:location) }

  context 'validations' do
    it "is valid with valid attributes" do
      expect(location).to be_valid
    end

    it "is not valid without expected attributes" do
      location.area = nil
      expect(location).to_not be_valid
      expect(location.errors.keys).to eq [:area]
    end

    it 'is not valid without coordinates' do
      loc = build(:location, area: nil, polygon_coordinates: nil)
      loc.save
      expect(loc).to_not be_valid
      expect(loc.errors.keys).to eq [:area]
    end

    it 'is valid with coordinates' do
      loc = Location.new(name: 'Test 2', polygon_coordinates: '-121, 47,-120, 45,-122, 43')
      loc.save
      expect(loc).to be_valid
    end
  end
end