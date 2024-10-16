class AddDeletedAtToMovies < ActiveRecord::Migration[7.0]
  def change
    add_column :movies, :deleted_at, :datetime, default: nil
  end
end
