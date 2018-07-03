require 'sinatra'
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


get '/' do
  @session = session[:user_id]
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
  user = User.new(name: params[:name], email: params[:email])
  user.password = user.hash_password(params[:password])
  user.save
  redirect '/login'
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
  if user.test_password(params[:password], user.password )
    session[:user_id] = user.id
    redirect '/'
  else
    @error = 'Invalid login credentials'
    erb :error
  end
end

get '/logout' do
  session[:user_id] = nil
  redirect '/login'
end

get '/logout' do
  session[:user_id] = nil
  redirect '/login'
end
