class Genre < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3 }, uniqueness: true

  has_many :movie_genre_ships
  has_many :movies, through: :movie_genre_ships
end
