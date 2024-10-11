class Movie < ApplicationRecord
  validates :title, presence: true, minimum: 3, uniqueness: true
  validates :blurb, presence: true, minimum: 10
  validates :date_released, presence: true
  validates :country_of_origin, presence: true, minimum: 2
  validates :showing_start, presence: true, comparison: { less_than: :showing_end }
  validates :showing_end, presence: true, comparison: { greater_than: :showing_start }

  has_many :movie_genre_ships
  has_many :genres, through: :movie_genre_ships
end