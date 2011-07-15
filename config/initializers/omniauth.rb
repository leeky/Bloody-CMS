Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, CONFIG['twitter']['consumer_key'], CONFIG['twitter']['consumer_secret']
end