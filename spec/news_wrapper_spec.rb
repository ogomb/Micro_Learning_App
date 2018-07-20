require_relative '../app/controllers/news_api_wrapper'
require_relative '../app/models/user'
require 'rack/test'

module MicroLearning
  RSpec.describe News_Api do
    include Rack::Test::Methods
    let(:category_name) {"test_data"}
    def app
      News_Api.new
    end

    describe 'news_wrapper' do
      it "should fetch all categories" do
        allow(app).to receive(:fetch_all_categories)
                          .and_return({
                                          'name' => "CNN report",
                                          'url'=> 'https://www.cnn.com',
                                          'url_to_image' => "https//www.cnn/fake_image.png"
                                      })
      end
      it "should fetch specific categories" do
        allow(app).to receive(:fetch_all_categories)
                          .with(:category_name)
                          .and_return({
                                          'name' => "BBC report",
                                          'url'=> 'https://www.bbc.com',
                                          'url_to_image' => "https//www.bbc/fake_image.png"
                                      })
      end
      it 'should get user email' do
        email = User.pluck
        allow(app).to receive(:get_emails).and_return(email)
      end

    end
  end
end