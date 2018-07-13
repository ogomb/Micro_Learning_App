require 'active_record'
require_relative 'app/controllers/application_controller'
require 'sass/plugin/rack'

Sass::Plugin.options[:style] = :compressed
use Sass::Plugin::Rack

use Rack::MethodOverride

run ApplicationController