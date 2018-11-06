source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Backend
gem 'rails', '~> 5.0.7'
gem 'pg'
gem 'puma', '~> 3.0'
gem 'devise', '~> 4.5'

# BE/FE
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jbuilder', '~> 2.5'
gem 'webpacker'

# Frontend
gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'react-rails'
gem 'slim-rails'
gem 'bootstrap', '~> 4.1.3'

group :development, :test do
  gem 'pry', '~> 0.11.3'
  gem 'pry-rails'
  gem 'pry-doc'
  gem 'binding_of_caller'
  gem 'rspec', '~> 3.8'
  gem 'rspec-rails', '~> 3.8'
  gem 'capybara'
  gem 'factory_bot_rails'
  gem 'capybara-selenium'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end