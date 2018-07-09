require 'news-api'
require_relative './user'

class News_Api
  @@news_api = News.new ('77cf0019ddac41acb887527a1c06111c')

  # fetch all categories from an endpoint
  def fetch_all_categories
    pages = 1 + rand(5)
    everything = @@news_api.get_everything(
      language: 'en',
      sources:'techcrunch,talksport,the-next-web,
                national-geographic, al-jazeera-english,
                crypto-coins-news',
      page: pages
  )
  end

  # fetch specific category
  def fetch_specific_category(category)
    category = category.strip
    specific_category = @@news_api.get_top_headlines(
        language: 'en',
        category:category,
        country: 'us'
    )
  end

  # get user emails
  def get_emails
    users_email = User.pluck(:email)
  end

  # get random content to send to the user
  def get_random_content
    random_content = ""
    fetch_all_categories.each do |link_to_send|
      random_content = link_to_send.url
    end
    random_content
  end
end


