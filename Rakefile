require 'sinatra/activerecord/rake'
require 'sinatra/activerecord'
require_relative 'app/controllers/application_controller'
require_relative 'app/models/news_api_wrapper'
require 'sendgrid-ruby'

include SendGrid

task :email_users do
    news = News_Api.new
     content = news.get_random_content

    news.get_emails.each do |email| 
        from = Email.new(email: 'test@example.com')
        to = Email.new(email: email)
        subject = 'Learn new Stuff today'
        content = Content.new(type: 'text/plain', value: content )
        mail = Mail.new(from, subject, to, content)

        sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
        sg.client.mail._('send').post(request_body: mail.to_json)
    end
end