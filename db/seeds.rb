require 'random_data'

 50.times do
   Post.create!(
     title:  RandomData.random_sentence,
     body:   RandomData.random_paragraph
   )
 end
 Post.find_or_create_by(title: "An awesome book", body: "Harry Potter is an awesome book!")
 posts = Post.all
 
 100.times do
   Comment.create!(
     post: posts.sample,
     body: RandomData.random_paragraph
   )
 end
 Post.find_by(title: "An awesome book").comments.find_or_create_by(body: "I agree!")
 
 puts "Seed finished"
 puts "Total number of posts: #{Post.count}"
 puts "Total number of comments: #{Comment.count}"
