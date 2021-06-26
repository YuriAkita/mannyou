# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(name: "Example User",
             email: "example@mail.com",
             password: "999999",
             admin: true)

10.times do |n|
  name = Faker::Games::Pokemon.name
  email = Faker::Internet.email
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               )
end

10.times do |n|
  title = Faker::Coffee.blend_name
  content = Faker::Games::Zelda.game
  task_deadline = Faker::Time.between_dates(from: Date.today - 1, to: Date.today, period: :day)
  Task.create!(title: title,
               content: content,
               task_deadline: task_deadline,
               user_id: rand(1..11)
               )
end

10.times do |n|
  name = Faker::Creature::Dog.name
  LabelCategory.create!(name: name)
end
