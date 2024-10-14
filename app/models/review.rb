class Review < ApplicationRecord
  validates :content, presence: true, length: { minimum: 20 }
  validates :rating, presence: true, numericality: { only_integer: true }

  belongs_to :user
  belongs_to :movie
end
