require 'sidekiq'

REDIS_CONFIG = { size: 1, url: ENV['REDISTOGO_URL'] }

Sidekiq.configure_client do |config|
  config.redis = REDIS_CONFIG if Padrino.env == :production
end

Sidekiq.configure_server do |config|
  config.redis = REDIS_CONFIG if Padrino.env == :production
end