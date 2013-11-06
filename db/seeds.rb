# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

ActiveRecord::Base.transaction do 
  test = User.create!(username: "test", email: "test@test.test",
              password: "123456", password_confirmation: "123456")

  15.times do
    User.create!(username: Faker::Internet.user_name,
                 email: Faker::Internet.email,
                 password: "123456",
                 password_confirmation: "123456")
  end

  Project.create!(title: "test", description: "this is a test", creator_id: test.id)
end
