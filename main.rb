require 'sinatra'


before do
    set_title
end

def set_title
    @title ||= 'Micro Learning App'
end
get('/styles.css'){ scss :styles }
    
get '/' do
    erb :home
end

get '/signup' do
    erb :sign_up
end