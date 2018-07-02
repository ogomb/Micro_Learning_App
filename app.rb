require 'sinatra'
require 'sequel'
require 'digest'
require 'yaml'

class MyApp < Sinatra::Application
    set :environment, ENV['RACK_ENV']

    configure do
        env = ENV['RACK_ENV']
        DB = Sequel.connect(YAML.load(File.open('database.yml'))[env])
        Dir[File.join(File.dirname(__FILE__), 'db', '*.rb')].each { |model| require model }
    end
end


get '/' do
  erb :home
end

get '/signup' do
  erb :sign_up
end

get '/login' do
  erb :login
end
