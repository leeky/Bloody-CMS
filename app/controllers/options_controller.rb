class OptionsController < ApplicationController
  
  before_filter :require_admin if Option.get("installed?") && !User.count.zero?
  
  def index
    if request.post?
      params.each do |key, value|
        Option.set(key, value)
      end
      unless Option.get("installed?")
        Option.set("installed?", true)
        Option.set("root", "posts#index")
        Option.set("cookies_secret_token", ActiveSupport::SecureRandom.hex(64))
      end
    end
  end
end
