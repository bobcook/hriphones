require 'pusher'

unless defined?(ENV['PUSHER_CONFIG']) #&& PUSHER_CONFIG
  filename = 'config/pusher.yml'
  if File.exists? Rails.root.join(filename)
    pusher_configs = YAML.load_file Rails.root.join(filename)
    PUSHER_CONFIG = pusher_configs[Rails.env]
  else
    PUSHER_CONFIG = nil
  end
end

if PUSHER_CONFIG
  Pusher.app_id = PUSHER_CONFIG["app_id"]
  Pusher.key = PUSHER_CONFIG["app_key"]
  Pusher.secret = PUSHER_CONFIG["secret"]
else
  Rails.logger.warn "Telephony will not work. #{filename} does not include config for RAILS_ENV=#{Rails.env}"
end

require 'pusher'

Pusher.url = "http://05a727cb51dd5bd1c402:7ddd5a5c5220415d6ab5@api.pusherapp.com/apps/59334"
Pusher.logger = Rails.logger
