source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

gem 'bootsnap', '>= 1.4.4', require: false
gem 'rails', '~> 6.1.3', '>= 6.1.3.1'
gem 'webpacker', '~> 5.0'


group :development, :test do
  gem 'sqlite3', '~> 1.4'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'web-console', '>= 4.1.0'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
end

group :production do
  gem 'pg'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
