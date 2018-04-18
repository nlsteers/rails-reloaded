source 'https://rubygems.org'

ruby '2.4'

gem 'bootstrap-sass', '3.3.6'
gem 'bootstrap-will_paginate', '1.0.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2.2'
gem 'psych', '2.1.1'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0.7'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

gem 'carrierwave', '1.2.2'
gem 'mini_magick', '4.7.0'

# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '1.0.0', group: :doc

# Use ActiveModel has_secure_password
gem 'bcrypt', '3.1.11'

# Generate fake user profiles
gem 'faker', '1.7.3'

gem 'will_paginate', '3.1.6'

# Use Puma as the app server
gem 'puma'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '5.1.5'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
end

group :development, :test do
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :test do
  gem 'minitest', '5.9.0'
  gem 'minitest-reporters', '1.1.11'
  gem 'rails-controller-testing'
end

group :production do
  gem 'fog', '1.42'
  gem 'pg'
  gem 'rails_12factor'
end
