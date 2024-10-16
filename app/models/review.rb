class Review < ApplicationRecord
  default_scope { where(deleted_at: nil) }

  validates :content, presence: true, length: { minimum: 20 }
  validates :rating, presence: true, numericality: { only_integer: true }, inclusion: 1..5

  belongs_to :user
  belongs_to :movie

  def destroy
    update(deleted_at: Time.now)
  end
end
