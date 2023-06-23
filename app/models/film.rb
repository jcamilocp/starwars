class Film < ApplicationRecord
  has_and_belongs_to_many :people, join_table: 'Film_People', class_name: 'People'
  has_and_belongs_to_many :planets, join_table: 'Film_Planet', class_name: 'Planet'

  validates :title, presence: true, length: { maximum: 255 }
  validates :episode_id, presence: true
  validates :opening_crawl, presence: true, length: { maximum: 255 }
  validates :director, presence: true, length: { maximum: 255 }
  validates :producer, presence: true, length: { maximum: 255 }
  validates :release_date, presence: true

  def self.table_name = 'Film'
end
