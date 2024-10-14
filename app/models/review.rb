class Review < ApplicationRecord
  validates :content, presence: true, length: { minimum: 20 }
  validates :rating, presence: true, numericality: { only_integer: true }, inclusion: 0..5

  belongs_to :user
  belongs_to :movie
end
