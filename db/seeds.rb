require 'random_data'

 5.times do
   User.create!(
     name: RandomData.random_name,
     email: RandomData.random_email,
     password: RandomData.random_sentence
    )
 end
 # Create an admin user
 admin = User.create!(
   name: 'Admin User',
   email: 'admin@example.com',
   password: 'helloworld',
   role: 'admin',
   )
 # Create a moderator user
 moderator = User.create!(
   name: 'Moderator User',
   email: 'moderator@example.com',
   password: 'helloworld',
   role: 'moderator',
 )
 # Create a member user
 member = User.create!(
   name: 'Member User',
   email: 'member@example.com',
   password: 'helloworld',
 )
 users = User.all
 
 15.times do
   Topic.create!(
     name:         RandomData.random_sentence,
     description:  RandomData.random_paragraph
   )
 end
 topics = Topic.all

 50.times do
   post = Post.create!(
     user:   users.sample,
     topic:  topics.sample,
     title:  RandomData.random_sentence,
     body:   RandomData.random_paragraph
   )
   #randomize each post's creation time & votes
   post.update_attribute(:created_at, rand(10.minutes .. 1.month).ago)
   rand(1..5).times {post.votes.create!(value: [-1,1].sample, user: users.sample) }
 end
  #Post.find_or_create_by(title: "An awesome book", body: "Harry Potter is an awesome book!")
 posts = Post.all
 
 5.times do
   Sponsoredpost.create!(
     topic:  topics.sample,
     title:  RandomData.random_sentence,
     body:   RandomData.random_paragraph,
     price:  rand(1..50)
   )
 end

 100.times do
   Comment.create!(
     user: users.sample,
     post: posts.sample,
     body: RandomData.random_paragraph
   )
 end
 #Post.find_by(title: "An awesome book").comments.find_or_create_by(body: "I agree!")
 30.times do
  Comment.create!(
    user: users.sample,
    topic: topics.sample,
    body: RandomData.random_paragraph
  )
end
 
 10.times do
   Advertisement.create!(
     title:  RandomData.random_sentence,
     body:   RandomData.random_paragraph,
     price:  rand(1..50)
   )
 end
 
 20.times do
   Question.create!(
    title: RandomData.random_question,
    body: RandomData.random_paragraph,
    resolved: RandomData.random_resolve
   )
 end
 
 puts "Seed finished"
 puts "Total number of users: #{User.count}"
 puts "Total number of topics: #{Topic.count}"
 puts "Total number of posts: #{Post.count}"
 puts "Total number of sponsored posts: #{Sponsoredpost.count}"
 puts "Total number of comments: #{Comment.count}"
 puts "Total number of votes: #{Vote.count}"
 puts "Total number of advertisements: #{Advertisement.count}"
 puts "Total number of questions: #{Question.count}"
