# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create!(name: "test")
post = Post.create!(
  user_id: user.id,
  description: 'test記事'
)
post.photo.attach(io: File.open('public/images/text_image_300×300.png'), filename: 'test_image.png')
another_user = User.create!(name: "sample")
another_post = Post.create!(
  user_id: another_user.id,
  description: 'sample記事'
)
another_post.photo.attach(io: File.open('public/images/text_image_300×300.png'), filename: 'test_image.png')
