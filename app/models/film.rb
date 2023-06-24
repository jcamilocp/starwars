class Film < ApplicationRecord
  has_many :film_people, class_name: 'FilmPeople'
  has_many :people, through: :film_people, class_name: 'People'
  has_many :film_planets, class_name: 'FilmPlanet'
  has_many :planets, through: :film_planets, class_name: 'Planet'

  validates :title, presence: true, length: { maximum: 255 }
  validates :episode_id, presence: true
  validates :opening_crawl, presence: true, length: { maximum: 255 }
  validates :director, presence: true, length: { maximum: 255 }
  validates :producer, presence: true, length: { maximum: 255 }
  validates :release_date, presence: true

  def self.table_name = 'Film'
end
