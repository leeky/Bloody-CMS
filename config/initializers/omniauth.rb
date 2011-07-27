Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, Option.get("twitter:key"), Option.get("twitter:secret")
end