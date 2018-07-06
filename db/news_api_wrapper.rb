require 'news-api'

class News_Api
  @@news_api = News.new ('77cf0019ddac41acb887527a1c06111c')

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

  def fetch_specific_category(category)
    specific_category = @@news_api.get_sources(language: 'en', sortBy: 'relevancy', sources:category)
  end
  
end


