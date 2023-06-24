class FilmPeople < ApplicationRecord
  belongs_to :people, class_name: 'People'
  belongs_to :film, class_name: 'Film'

  def self.table_name = 'Film_People'
end
