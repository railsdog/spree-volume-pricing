source 'http://rubygems.org'

# temporarily needed until next capybara release
gem 'selenium-webdriver', '0.2.1'

group :test do
  gem 'rspec-rails'
  gem 'factory_girl'
  gem 'factory_girl_rails'
  gem 'rcov'
  gem 'shoulda'
  gem 'faker'
  if RUBY_VERSION < "1.9"
    gem "ruby-debug"
  else
    gem "ruby-debug19"
  end
end

group :cucumber do
  gem 'cucumber-rails'
  gem 'database_cleaner'
  gem 'nokogiri'
  gem 'capybara'
  gem 'factory_girl'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'launchy'

  if RUBY_VERSION < "1.9"
    gem "ruby-debug"
  else
    gem "ruby-debug19"
  end
end

gem 'spree', :git => 'git://github.com/spree/spree.git'
gem 'spree_volume_pricing', :git => 'git://github.com/spree/spree_volume_pricing.git'
