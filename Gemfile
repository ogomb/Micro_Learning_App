# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

gem 'sinatra'
gem 'activerecord', :require => 'active_record'
gem 'sinatra-activerecord', :require => 'sinatra/activerecord'
gem 'rake'
gem 'require_all'
gem 'pg'
gem 'shotgun'
gem 'pry'
gem 'bcrypt'
gem 'news-api'
gem 'whenever'
gem 'sendgrid-ruby'
gem 'sinatra-flash', :require => 'sinatra/flash'

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'rspec'
  gem 'rack-test'
  gem 'simplecov'
end