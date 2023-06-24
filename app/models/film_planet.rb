class FilmPlanet < ApplicationRecord
  belongs_to :planet, class_name: 'Planet'
  belongs_to :film, class_name: 'Film'

  def self.table_name = 'Film_Planet'
end
