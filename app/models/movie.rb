class Movie < ApplicationRecord
  validates :title, presence: true, length: { minimum: 3 }, uniqueness: true
  validates :blurb, presence: true, length: { minimum: 20 }
  validates :date_released, presence: true, comparison: { less_than_or_equal_to: :showing_start }
  validates :country_of_origin, presence: true, length: { minimum: 2 }
  validates :showing_start, presence: true, comparison: { less_than: :showing_end }
  validates :showing_end, presence: true, comparison: { greater_than: :showing_start }

  has_many :movie_genre_ships
  has_many :genres, through: :movie_genre_ships
  has_many :reviews, dependent: :destroy
  belongs_to :user

end