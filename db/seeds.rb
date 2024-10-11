# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

7.times do |i|
  puts "start create #{i} genre"
  genre = Genre.create!(name: Faker::Book.genre)
  puts "create genre id: #{genre.id}, name: #{genre.name}"
end