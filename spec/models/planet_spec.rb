require 'rails_helper'

RSpec.describe Planet, type: :model do
  describe 'validations' do
    it 'validates pressence of required fields' do
      should validate_presence_of(:name)
      should validate_presence_of(:diameter)
      should validate_presence_of(:rotation_period)
      should validate_presence_of(:orbital_period)
      should validate_presence_of(:gravity)
      should validate_presence_of(:population)
      should validate_presence_of(:climate)
      should validate_presence_of(:terrain)
      should validate_presence_of(:surface_water)
    end

    it 'validates lenght of required fields' do
      should validate_length_of(:name)
      should validate_length_of(:diameter)
      should validate_length_of(:rotation_period)
      should validate_length_of(:orbital_period)
      should validate_length_of(:gravity)
      should validate_length_of(:population)
      should validate_length_of(:climate)
      should validate_length_of(:terrain)
      should validate_length_of(:surface_water)
    end

    it 'validates the relations' do
      should have_many(:people)
      should have_and_belong_to_many(:films)
    end
  end
end