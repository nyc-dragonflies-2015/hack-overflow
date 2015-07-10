require 'net/http'
require 'json'
require 'faker'
require 'pry'

def get_paragraph
  uri = URI('http://hipsterjesus.com/api/?html=false')
  response = Net::HTTP.get_response(uri)
  body = JSON.parse(response.body)["text"]
  title = body.split(" ").first(8).join(" ")
  return [title, body]
end

10.times do
  user = User.create(username: Faker::Name.name, email: Faker::Internet.email, password: "password")
  paragraph = get_paragraph
  user.questions << Question.create(title: paragraph[0], body: paragraph[1], view_count: 0 )
end

User.all.each_with_index do |user, index|
  question = Question.all.sample
  answer = Answer.create(question_id: question.id, body: Faker::Lorem.paragraph, user_id: User.first.id)
  user.comments << Comment.create(commentable_type: "Question", commentable_id: question.id, body: Faker::Lorem.sentence)
  user.answers << Answer.create(body: Faker::Lorem.paragraph, question_id: question.id)
end
