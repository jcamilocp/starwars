require 'rails_helper'

RSpec.describe People, type: :model do
  describe 'validations' do
    it 'validates pressence of required fields' do
      should validate_presence_of(:name)
      should validate_presence_of(:birth_year)
      should validate_presence_of(:eye_color)
      should validate_presence_of(:gender)
      should validate_presence_of(:hair_color)
      should validate_presence_of(:height)
      should validate_presence_of(:mass)
      should validate_presence_of(:skin_color)
      should validate_presence_of(:planet_id)
    end

    it 'validates lenght of required fields' do
      should validate_length_of(:name)
      should validate_length_of(:birth_year)
      should validate_length_of(:eye_color)
      should validate_length_of(:gender)
      should validate_length_of(:hair_color)
      should validate_length_of(:height)
      should validate_length_of(:mass)
      should validate_length_of(:skin_color)
    end

    it 'validates the relations' do
      should belong_to(:planet)
      should have_many(:films)
      should have_many(:film_people)
    end
  end
end