# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

the_maker = User.create(
  email:                 "maker@maker.maker",
  username:              "The Maker",
  profile_pic:           "totoro-greenit.png",
  password:              "The Maker",
  password_confirmation: "The Maker"
  )
beezy = User.create(
  email:                 "b@b.b",
  username:              "beezy",
  profile_pic:     "http://media0.giphy.com/media/eVSFl2KPjUUiQ/giphy.gif",
  password:              "b",
  password_confirmation: "b"
)

harper = User.create(
  email:                 "harper.reilly@mac.com",
  username:              "harper",
  password:              "123",
  password_confirmation: "123"
)

the_first = Subgreen.create(
  name:                  "The First",
  user_id:                 "1",
  description:           "The First Subgreenit"
  )

Post.create(
  title:                 "hello, world",
  user_id:               "1",
  subgreen_id:           "1",
  url_link:              "greenit-alien.png",
  body:                  "Hi there"
  )

the_first.users << the_maker
