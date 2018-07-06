require 'active_record'
require_relative 'app/controllers/application_controller'

use Rack::MethodOverride

run ApplicationController