source 'https://rubygems.org'
ruby '2.2.2'

gem 'rails', '~> 4.1'

gem 'pg'

gem 'devise'

gem 'wicked'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.2'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

gem 'foundation-icons-sass-rails'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem "jquery-ui-rails"

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

gem 'foundation-rails'

gem 'acts_as_list' #added so we can sort the habits

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

group :development do
  gem 'rack-mini-profiler'
  gem 'pry-rails'
end

group :development, :test do
  gem 'rspec-rails', '~> 2.14.0'
  gem 'factory_girl_rails', '~> 4.2.1'
  #There were install issues with these two gems when moving to ruby 2.2.1.
  #gem 'guard-rspec'
  #gem 'spork-rails', github: 'sporkrb/spork-rails'
  gem 'simplecov', :require => false, :group => :test
end

group :test do
  gem 'faker', '~> 1.1.2'
  gem 'capybara', '~> 2.1.0'
  gem 'database_cleaner', '~> 1.0.1'
  gem 'launchy', '~> 2.3.0'
  gem 'selenium-webdriver', '~> 2.35.1'
end

group :production do
  gem 'newrelic_rpm'
end
