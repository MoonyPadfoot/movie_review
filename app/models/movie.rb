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

  scope :filter_by_title, ->(title) { where('title LIKE ?', "%#{title}%") if title.present? && title != "" }
  scope :filter_by_genre, ->(genre_ids) { genre_ids.blank? ? all : joins(:genres).where(genres: { id: genre_ids }) }
  scope :filter_by_status, ->(status) {
    case status
    when showing
      where("CURRENT_DATE BETWEEN showing_start AND showing_end")
    when soon
      where("CURRENT_DATE < showing_start")
    when showing
      where("CURRENT_DATE > showing_end")
    end
  }

  enum role: { showing: "SHOWING", soon: "SOON", screened: "SCREENED" }
end