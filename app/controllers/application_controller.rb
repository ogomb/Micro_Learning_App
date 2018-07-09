require 'sinatra'
require 'sinatra/flash'
require_relative '../models/user'
require_relative '../models/news_api_wrapper'

class ApplicationController < Sinatra::Base
  register Sinatra::Flash

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
    news = News_Api.new
    all_categories = news.fetch_all_categories
    erb :home, locals: { all_categories: all_categories }
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
      redirect '/home'
    else
      flash[:notice] = 'Invalid login credentials'
      redirect uri 'login'
    end
  end

  post '/category' do
    @session = session[:user_id]
    category = params[:cat].downcase
    news = News_Api.new
    fetched = news.fetch_specific_category category
    erb :home, locals: { all_categories: fetched }
  end

  get '/logout/?' do
    session[:user_id] = nil
    redirect '/login'
  end
end