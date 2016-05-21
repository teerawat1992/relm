# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Product.delete_all

Product.create!(
  title: "Elm",
  description: "A functional programming language for declaratively creating web browser-based graphical user interfaces.",
  image_url: "https://avatars0.githubusercontent.com/u/4359353?v=3&s=200.png",
  price: 69.99
)

Product.create!(
  title: "Elixir",
  description: "A dynamic, functional language designed for building scalable and maintainable applications.",
  image_url: "http://jobs.elixirdose.com/images/elixir-logo.png",
  price: 69.99
)

Product.create!(
  title: "Ruby",
  description: "A dynamic, open source programming language with a focus on simplicity and productivity.",
  image_url: "http://www.unixstickers.com/image/cache/data/stickers/ruby/ruby.sh-600x600.png",
  price: 69.99
)

puts "Created #{Product.count} product(s)."
