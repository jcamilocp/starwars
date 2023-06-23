class People < ApplicationRecord
  belongs_to :planet
  has_and_belongs_to_many :films, join_table: 'Film_People', class_name: 'Film'

  validates :name, presence: true, length: { maximum: 255 }
  validates :birth_year, presence: true, length: { maximum: 255 }
  validates :eye_color, presence: true, length: { maximum: 255 }
  validates :gender, presence: true, length: { maximum: 255 }
  validates :hair_color, presence: true, length: { maximum: 255 }
  validates :height, presence: true, length: { maximum: 255 }
  validates :mass, presence: true, length: { maximum: 255 }
  validates :skin_color, presence: true, length: { maximum: 255 }
  validates :planet_id, presence: true

  def self.table_name = 'People'
end
