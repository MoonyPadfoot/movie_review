class Movie < ApplicationRecord
  default_scope { where(deleted_at: nil) }
  before_create :generate_slug

  def to_param
    slug
  end

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

  def destroy
    update(deleted_at: Time.now)
  end

  scope :filter_by_title, ->(title) { where('title LIKE ?', "%#{title}%") if title.present? && title != "" }
  scope :filter_by_genre, ->(genre_ids) { joins(:genres).where(genres: { id: genre_ids }) if genre_ids.present? }
  scope :filter_by_status, ->(status) {
    case status
    when "SHOWING"
      where("CURRENT_DATE BETWEEN showing_start AND showing_end")
    when "SOON"
      where("CURRENT_DATE < showing_start")
    when "SCREENED"
      where("CURRENT_DATE > showing_end")
    end
  }
  scope :order_by_rating, -> {
    left_joins(:reviews)
      .select('movies.*, COALESCE(AVG(reviews.rating), 0) AS average_rating')
      .group('movies.id')
      .order('average_rating DESC')
  }
  scope :top_3_by_rating, -> {
    left_joins(:reviews)
      .select("movies.id, COALESCE(AVG(reviews.rating), 0) AS average_rating")
      .group('movies.id')
      .order('average_rating DESC')
      .limit(3)
  }

  private

  def generate_slug
    begin
      self.slug = SecureRandom.urlsafe_base64(5) if Movie.exists?(slug: slug)
    end
  end

end