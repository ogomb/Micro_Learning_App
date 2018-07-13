require 'bundler'
Bundler.require

require 'sinatra/activerecord'
require 'sinatra/activerecord/rake'
require_relative 'app/controllers/application_controller'
require_relative 'app/models/lers/news_api_wrapper'
require 'sendgrid-ruby'
include SendGrid

# a rake task to send emails to users
task :email_users do
  news = News_Api.new
  mail_content = news.get_random_content

  news.get_emails.each do |email|
    from = Email.new(email: 'test@example.com')
    to = Email.new(email: email)
    subject = 'Learn new Stuff today'
    content = Content.new(type: 'text/plain', value: mail_content)
    mail = Mail.new(from, subject, to, content)

    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    sg.client.mail._('send').post(request_body: mail.to_json)
    end
end
