require 'rails_helper'

RSpec.describe Film, type: :model do
  describe 'validations' do
    it 'validates pressence of required fields' do
      should validate_presence_of(:title)
      should validate_presence_of(:episode_id)
      should validate_presence_of(:opening_crawl)
      should validate_presence_of(:director)
      should validate_presence_of(:producer)
      should validate_presence_of(:release_date)
    end

    it 'validates lenght of required fields' do
      should validate_length_of(:title)
      should validate_length_of(:opening_crawl)
      should validate_length_of(:director)
      should validate_length_of(:producer)
    end

    it 'validates the relations' do
      should have_and_belong_to_many(:people)
      should have_and_belong_to_many(:planets)
    end
  end
end