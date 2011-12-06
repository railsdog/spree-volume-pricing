ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../dummy/config/environment", __FILE__)
require 'rspec/rails'

#include spree's factories
require 'spree/core'
require 'spree/core/testing_support/factories'

# include local factories
Dir["#{File.dirname(__FILE__)}/factories/**/*.rb"].each do |f|
  fp =  File.expand_path(f)
  require fp
end

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}


RSpec.configure do |config|
  config.mock_with :rspec
  config.use_transactional_fixtures = true
end
