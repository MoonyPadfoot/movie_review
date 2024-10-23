class Review < ApplicationRecord
  default_scope { where(deleted_at: nil) }

  validates :content, presence: true, length: { minimum: 20 }
  validates :rating, presence: true, numericality: { only_integer: true, in: 1..5 }
  validates :user_id, uniqueness: { scope: :movie_id, message: "User can only review a movie once" }

  belongs_to :user
  belongs_to :movie

  after_save :update_movie_average_rating
  after_destroy :update_movie_average_rating

  def destroy
    update(deleted_at: Time.now)
  end

  private

  def update_movie_average_rating
    movie.update(average_rating: movie.average_rating)
  end
end
