class Planet < ApplicationRecord
  has_many :people, class_name: 'People'
  has_and_belongs_to_many :films, join_table: 'Film_Planet', class_name: 'Film'

  validates :name, presence: true, length: { maximum: 255 }
  validates :diameter, presence: true, length: { maximum: 255 }
  validates :rotation_period, presence: true, length: { maximum: 255 }
  validates :orbital_period, presence: true, length: { maximum: 255 }
  validates :gravity, presence: true, length: { maximum: 255 }
  validates :population, presence: true, length: { maximum: 255 }
  validates :climate, presence: true, length: { maximum: 255 }
  validates :surface_water, presence: true, length: { maximum: 255 }
  validates :terrain, presence: true, length: { maximum: 255 }

  def self.table_name = 'Planet'
end
