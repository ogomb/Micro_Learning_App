require 'simplecov'
require 'coveralls'

ENV['RACK_ENV'] = 'test'
Coveralls.wear!

SimpleCov.start
RSpec.configure do |config|
end
