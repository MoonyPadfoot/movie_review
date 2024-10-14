class AddUserToMovies < ActiveRecord::Migration[7.0]
  def change
    add_reference :movies, :user, null: false, index: true
  end
end
