class Review < ApplicationRecord
  validates :content, presence: true, length: { minimum: 20 }
  validates :rating, presence: true, numericality: { only_integer: true }, inclusion: 1..5
  validate :rating_unchanged

  belongs_to :user
  belongs_to :movie

  private

  def rating_unchanged
    if rating_changed?
      errors.add(:rating, "cannot be changed")
    end
  end
end
