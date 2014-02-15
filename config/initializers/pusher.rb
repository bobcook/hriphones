require 'pusher'

#unless defined?(ENV['PUSHER_APP_ID']) #&& PUSHER_CONFIG
  #filename = 'config/pusher.yml'
  #if File.exists? Rails.root.join(filename)
    #pusher_configs = YAML.load_file Rails.root.join(filename)
   # PUSHER_CONFIG = pusher_configs[Rails.env]
  #else
    #PUSHER_CONFIG = nil
    #end
#end

#if PUSHER_CONFIG
  #Pusher.app_id = PUSHER_CONFIG["app_id"]
  #Pusher.key = PUSHER_CONFIG["app_key"]
  #Pusher.secret = PUSHER_CONFIG["secret"]
  #else
  #Rails.logger.warn "Telephony will not work. #{filename} does not include config for RAILS_ENV=#{Rails.env}"
  #end


# test if you have ENV var, load from file if not
if ENV['PUSHER_APP_ID']
  Pusher.app_id = ENV['PUSHER_APP_ID']
  Pusher.key = ENV['PUSHER_APP_KEY']
  Pusher.secret = ENV['PUSHER_SECRET']
  #else
  #... load from config file as before
end