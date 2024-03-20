# frozen_string_literal: true

Kredis::Connections.connections[:shared] = Redis.new(
  url: ENV.fetch('REDIS_URL', 'redis://localhost:6379/1')
)
