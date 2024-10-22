class AddUniqueIndexToReviews < ActiveRecord::Migration[7.0]
  def change
    add_index :reviews, [:user_id, :movie_id], unique: true
  end
end
