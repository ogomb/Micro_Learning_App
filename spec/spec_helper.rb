require 'simplecov'
require 'coveralls'
require 'shoulda-matchers'

ENV['RACK_ENV'] = 'test'
Coveralls.wear!

SimpleCov.start
RSpec.configure do |config|
end
