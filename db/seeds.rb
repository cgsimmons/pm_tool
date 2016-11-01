# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
50.times do
  date = Faker::Date.between(Date.today, 5.years.from_now)
  p = Project.create(title: Faker::Hipster.words(4).join(" "),
              description: Faker::StarWars.quote,
              due_date: date)
  rand(5).times do
    Task.create(project: p,
                    title: Faker::Hacker.verb + ' ' +Faker::Hacker.adjective +  ' ' + Faker::Hacker.noun,
                    due_date: Faker::Date.between(Date.today, date))
  end
end
puts "Made the Projects"
 # TODO:  NOT SEEDING TASKS!
