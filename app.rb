require 'sinatra'
require 'sinatra/flash'
require 'sequel'
require 'digest'
require 'yaml'

class MyApp < Sinatra::Application
    set :environment, ENV['RACK_ENV']

    configure do
        enable :sessions
        env = ENV['RACK_ENV']
        DB = Sequel.connect(YAML.load(File.open('database.yml'))[env])
        Dir[File.join(File.dirname(__FILE__), 'db', '*.rb')].each { |model| require model }
    end
end


before do
  if  request.path_info.split('/')[1] != 'login' &&
      request.path_info.split('/')[1] != 'signup' &&
      session[:user_id].nil?
    redirect '/login'
  end
end

get '/home' do
  @session = session[:user_id]
  news = News_Api.new
  @all_categories = news.fetch_all_categories
  @all_categories.each do |cat|
    p cat
  end
  erb :home
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
    flash[:notice] = if user.errors[:name]
                       user.errors[:name][0]
                     else
                       user.errors[:email][0]
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
  user = User.first(email: params[:email])
  if !user.nil? and user.test_password(params[:password], user.password )
    session[:user_id] = user.id
    redirect '/home'
  else
    flash[:notice] = 'Invalid login credentials'
    redirect uri 'login'
  end
end

post '/category' do
  category = params[:cat].downcase
  news = News_Api.new
  fetched = news.fetch_specific_category category
  redirect '/home', fetched
end

get '/logout/?' do
  session[:user_id] = nil
  redirect '/login'
end

