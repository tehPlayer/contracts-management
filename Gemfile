ruby '2.5.1'

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

# Backend
gem 'devise', '~> 4.5'
gem 'pg'
gem 'puma', '~> 3.0'
gem 'rails', '~> 5.0.7'

# BE/FE
gem 'coffee-rails', '~> 4.2'
gem 'jbuilder', '~> 2.5'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'webpacker'

# Frontend
gem 'bootstrap', '~> 4.1.3'
gem 'jquery-rails'
gem 'react-rails'
gem 'slim-rails'
gem 'turbolinks', '~> 5'

group :development, :test do
  gem 'binding_of_caller'
  gem 'capybara'
  gem 'capybara-selenium'
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'pry', '~> 0.11.3'
  gem 'pry-doc'
  gem 'pry-rails'
  gem 'rspec', '~> 3.8'
  gem 'rspec-rails', '~> 3.8'
  gem 'rubocop', '~> 0.60'
end

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end
