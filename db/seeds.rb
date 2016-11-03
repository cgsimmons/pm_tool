# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
50.times do
  date = Faker::Date.between(Date.today, 5.years.from_now)
  p = Project.create(title: Faker::Hipster.sentence,
              description: Faker::StarWars.quote,
              due_date: date)
  (2 + rand(5)).times do
    Task.create(    project: p,
                    title: Faker::Hacker.verb + " " + Faker::Hacker.adjective +  " " + Faker::Hacker.noun,
                    body: Faker::ChuckNorris.fact,
                    done: [true, false].sample,
                    due_date: Faker::Date.between(Date.today, date))
  end
  rand(3).times do
    Discussion.create(  project: p,
                        title: Faker::Commerce.product_name,
                        description: Faker::Lorem.paragraph
                      )
    rand(5).times do
      Comment.create( discussion: Discussion.last,
                      body: Faker::Hacker.say_something_smart)
    end
  end
end
puts "Seeded projects, tasks, discussion, and comments."
