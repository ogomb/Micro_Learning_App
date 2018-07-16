require 'rack/test'
require 'rspec'
require_relative '../app/controllers/application_controller'

module MicroLearningApp
  RSpec.describe 'Micro Learning App' do
    include Rack::Test::Methods

    def app
      ApplicationController.new
    end

    it 'should show sign-up form' do
      get '/signup'
      expect(last_response.status).to eq(200)
    end
    it 'should show login form and redirect to home' do
      get '/login'
      expect(last_response.status).to eq(200)
    end

    it 'should redirect to add category after signup' do
      post '/signup', {name: 'esad',password: 'ereqreq', email: 'mbogolew@gmail.com',confirm_password: 'ereqreq'}
      expect(last_response).to be_redirect
      follow_redirect!
      expect(last_request.path).to eq('/add_category')
    end

    it 'should redirect to home after login' do
      post '/login', {password: 'ereqreq', email: 'mbogolew@gmail.com'}
      expect(last_response).to be_redirect
      follow_redirect!
      expect(last_request.path).to eq('/add_category')
    end

    it 'should redirect to logout' do
      get '/logout'
      expect(last_response).to be_redirect
      follow_redirect!
      expect(last_request.path).to eq('/login')
    end
  end
end