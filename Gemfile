source 'https://rubygems.org'

# ------ Framework
gem 'padrino', '~> 0.12.4'

# ------ Server
gem 'rake', '~> 10.4.2'
gem 'thin', '~> 1.6.3'

# ------ Front end
gem 'json',      '~> 1.7'
gem 'sass',      '~> 3.4.13'
gem 'haml',      '~> 4.0.6'
gem 'redcarpet', '~> 3.2.2'

# ------ Database
gem 'pg',     '~> 0.18.1'
gem 'sequel', '~> 4.20.0'
gem 'redis',  '~> 3.2.1'

# ------ Background jobs
gem 'resque',  '~> 1.25.2'
gem 'sidekiq', '~> 3.3.3'

# ------ SaaS
gem 'mandrill-api', '~> 1.0.53'

# ------ Test
group :test do
  gem 'rspec',      '~> 3.2.0'
  gem 'rack-test',  '~> 0.6.3', :require => 'rack/test'
  gem 'capybara',   '~> 2.4.4'
  gem 'mock_redis', '~> 0.14.0'
end

# ------ Development & test
group :development, :test do
  gem 'byebug', '~> 4.0.3'
  gem 'dotenv', '~> 2.0.1'
end