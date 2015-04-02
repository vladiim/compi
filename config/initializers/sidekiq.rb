require 'sidekiq'


# CONFIG    = { production: ENV['REDISTOGO_URL'], development: 'http://localhost:6379', test: 'http://localhost:6379' }
# redis_url = CONFIG.fetch(Padrino.env)

Sidekiq.configure_client do |config|
  # config.redis = { size: 1, url: redis_url }
  config.redis = { size: 1, url: ENV['REDISTOGO_URL'] } if Padrino.env == :production
end

Sidekiq.configure_server do |config|
  # config.redis = { size: 2, url: redis_url }
  config.redis = { size: 1, url: ENV['REDISTOGO_URL'] } if Padrino.env == :production
end