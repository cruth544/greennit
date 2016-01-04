# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.delete_all

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

Post.create(
  title:                 "hello, world",
  url_link:              "https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcSqIp7xeTFujvK28UBHn3j0QcAWHISIfDwHw0YLxWTcVb5B0XC7oDP6g5w",
  body:                  "Hi there"
  )
