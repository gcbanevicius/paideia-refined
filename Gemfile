source 'https://rubygems.org'

# ruby '1.9.2'

gem 'rails', '3.2.13'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

group :production do
  gem 'pg', '0.12.2'
  ## for s3 service
  gem 'fog'
end

group :development, :test do
  gem 'sqlite3'
  gem 'pg', '0.12.2'
end

gem 'json'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails', '~> 2.0.0'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug'

## for twitter bootstrap
gem "twitter-bootstrap-rails", :git => 'git://github.com/seyhunak/twitter-bootstrap-rails.git'

## The following gem is for Rails-Bootstrap-Navbar
gem 'rails_bootstrap_navbar'

## special add-on for ruby on rails
gem 'bootstrap-addons-rails'

# Refinery CMS
gem 'refinerycms', '~> 2.0.0', :git => 'git://github.com/refinery/refinerycms.git', :branch => '2-0-stable'

# Specify additional Refinery CMS Extensions here (all optional):
gem 'refinerycms-i18n', '~> 2.0.0'
#  gem 'refinerycms-blog', '~> 2.0.0'
#  gem 'refinerycms-inquiries', '~> 2.0.0'
#  gem 'refinerycms-search', '~> 2.0.0'
#  gem 'refinerycms-page-images', '~> 2.0.0'

# for adding image plugin to refinery core
gem 'refinerycms-page-images', '~> 2.0.0'

## useful for slugs
gem 'friendly_id'

## add inquiries pluing to refinery core
gem 'refinerycms-inquiries', '~> 2.0.0'

## Gemfile for Rails 3, Sinatra, and Merb
gem 'will_paginate', '~> 3.0'

## home-made engines
gem 'refinerycms-carousel_images', :path => 'vendor/extensions'
gem 'refinerycms-staff_members', :path => 'vendor/extensions'

## on deployment, heroku says this gem is required
## gem 'activerecord-sqlite3-adapter'

gem 'pg', '0.12.2'

gem 'heroku'
gem 'taps'

gem 'nokogiri'
gem 'mechanize'


