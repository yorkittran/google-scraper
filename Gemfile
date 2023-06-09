source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.3'

#
# Core libraries
#
gem 'rails', '~> 7.0', '>= 7.0.2.4'

#
# Database, ORM, Model, etc
#
gem 'activerecord-import', '~> 1.4.0'
gem 'pg', '~> 1.1'

#
# Web servers
#
gem 'puma', '~> 5.6', '>= 5.6.4'
gem 'redis', '~> 3.2', '>= 3.2.1'
gem 'redis-rails', '~> 5.0', '>= 5.0.1'

#
# Views
#
gem 'bootstrap', '~> 5.1', '>= 5.1.3'
gem 'sassc-rails', '~> 2.1', '>= 2.1.2'
gem 'slim-rails', '~> 3.4'

#
# Rack Middlewares
#
gem 'rack-cors', '~> 1.1', '>= 1.1.1'

#
# API
#
gem 'active_model_serializers', '~> 0.10.13'
gem 'graphql', '~> 2.0', '>= 2.0.9'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '~> 1.11', '>= 1.11.1', require: false

#
# Authentication and Authorization
#
gem 'devise', '~> 4.8', '>= 4.8.1'
gem 'jwt', '~> 1.5', '>= 1.5.4'

#
# Crawl
#
gem 'nokogiri', '~> 1.14', '>= 1.14.2'
gem 'watir', '~> 7.2', '>= 7.2.2'

#
# Background Job
#
gem 'sidekiq', '~> 7.0', '>= 7.0.7'

#
# Others
#
gem 'config', '~> 4.0'
gem 'image_processing', '~> 1.12', '>= 1.12.2'
gem 'importmap-rails', '~> 1.0'
gem 'rubocop-rails', '~> 2.13', '>= 2.13.2', require: false
gem 'stimulus-rails', '~> 1.0', '>= 1.0.4'
gem 'turbo-rails', '~> 1.1', '>= 1.1.1'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'annotate', '~> 3.2'
  gem 'better_errors', '~> 2.9', '>= 2.9.1'
  gem 'debug', '~> 1.5', platforms: %i[mri mingw x64_mingw]
  gem 'listen', '~> 3.7', '>= 3.7.1'
  gem 'rack-mini-profiler', '~> 3.0'
  gem 'rails-erd', '~> 1.5', '>= 1.5.2'
  gem 'spring', '~> 4.0'
  gem 'web-console', '~> 4.2'
end
