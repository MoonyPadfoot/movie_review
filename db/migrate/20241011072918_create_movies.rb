class CreateMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :movies do |t|
      t.string :title
      t.text :blurb
      t.datetime :date_released
      t.string :country_of_origin
      t.datetime :showing_start
      t.datetime :showing_end

      t.timestamps
    end
  end
end
