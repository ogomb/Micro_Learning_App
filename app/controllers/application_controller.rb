require 'sinatra'
require 'sinatra/flash'
require_relative '../../app/models/user'
require_relative '../../app/models/category'
require_relative '../../app/models/user_category'
require_relative 'news_api_wrapper'
require 'sinatra/form_helpers'

class ApplicationController < Sinatra::Base
  register Sinatra::Flash
  helpers Sinatra::FormHelpers

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'password_security'
  end

  # check the route before processing it
  before do
    if request.path_info.split('/')[1] != 'login' &&
            request.path_info.split('/')[1] != 'signup' &&
            session[:user_id].nil?
      redirect '/login'
    end
  end
  get '/home' do
    @session = session[:user_id]
    user = User.find_by(id: @session)
    user_cats = user.categories.each.map {|cat| cat.name }
    category = user_cats.first
    news = News_Api.new
    fetched = news.fetch_specific_category category
    erb :home, locals: {all_categories: user_cats, fetched: fetched}
  end

  get '/signup/?' do
    if session[:user_id].nil?
      erb :sign_up
    else
      @error = 'Please log out first'
      erb :error
    end
  end

  post '/signup/?' do
    password = params[:password].strip
    confirm_password = params[:confirm_password].strip
    user = User.new(name: params[:name], email: params[:email])
    unless user.valid?
      flash[:notice] = if user.errors.messages
                         user.errors.messages[:name][0]
                       else
                         user.errors.messages[:email][0]
                       end
      redirect uri 'signup'
    end
    if password != confirm_password
      flash[:notice] = "Passwords don't match"
      redirect uri 'signup'
    end

    user.password = user.hash_password(params[:password])
    begin
      user.save
      redirect '/login'
    rescue StandardError => e
      flash[:notice] = 'Similar user-name or email exists'
      redirect uri 'signup'
    end
  end

  get '/login/?' do
    if session[:user_id].nil?
      erb :login
    else
      @error = 'Please log out first'
      erb :error
    end
  end

  post '/login/?' do
    user = User.find_by(email: params[:email])
    if !user.nil? and user.test_password(params[:password], user.password )
      session[:user_id] = user.id
      redirect  uri '/add_category'
    else
      flash[:notice] = 'Invalid login credentials'
      redirect uri 'login'
    end
  end

  post '/category' do
    @session = session[:user_id]
    category = params[:f]
    news = News_Api.new
    fetched = news.fetch_specific_category category
    user = User.find_by(id: @session)
    user_cats = user.categories.each.map {|cat| cat.name }
    erb  :home, locals: { fetched: fetched, all_categories: user_cats }
  end

  get '/add_category' do
    @session = session[:user_id]
    all_categories = Category.all
    mapped = all_categories.each.map { |category| category.name }
    erb :add_cat, locals: { cats: mapped }
  end

  post '/add_category' do
    @session = session[:user_id]
    preferences = params[:category]
    if preferences
      preferences = params[:category]['choose']
      user = User.find_by(id: @session)
      unless preferences.empty?
        preferences.each do |single_preference|
          category = Category.find_by(name: single_preference)
          user.categories << category unless user.categories.include? category
        end
      end
      redirect uri :home
    else
      redirect uri '/add_category'
    end
  end

  get '/logout/?' do
    session[:user_id] = nil
    redirect uri '/login'
  end
end