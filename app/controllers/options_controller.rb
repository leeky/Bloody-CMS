class OptionsController < ApplicationController
  
  skip_before_filter :ensure_installed
  before_filter :require_admin if Settings.get("installed?") && !User.count.zero?
  
  def index
    @errors = Hash.new
    
    if request.post?
      @errors['title'] = "Please provide a title for your site" if params['title'].blank? 
      @errors['twitter:consumer_key'] = "Please provide a Twitter consumer key" if params['twitter:consumer_key'].blank? 
      @errors['twitter:consumer_secret'] = "Please provide a Twitter consumer secret" if params['twitter:consumer_secret'].blank? 
      @errors['twitter:consumer_key'] = @errors['twitter:consumer_secret'] = "Your credentials are invalid. Please make sure you copy pasted the consumer key and secret exactly." if !params['twitter:consumer_key'].blank? && !params['twitter:consumer_secret'].blank? && !self.valid_twitter_credentials?
      
      if @errors.length.zero?  
        params.each do |key, value|
          key = key.gsub("::", "?")
          value = value.strip if value.is_a? String
          Settings.set(key, value)
        end
        
        Bloodycms::Application.reload_routes!
        
        if Settings.get("installed?")
          Settings.set("home:enabled?", false) unless params["home:enabled::"]
          Settings.set("blog:enabled?", false) unless params["blog:enabled::"]
          Settings.set("blog:in_nav?", false) unless params["blog:in_nav::"]
          
          
          redirect_to options_path, :notice => "Changes saved."
        else
          Settings.set("installed?", true)         
          redirect_to "/", :notice => "You are all done now!"
        end
      end
    end
  end
    
  ###
  ### Checks if the given twitter credentials are valid
  ###
  def valid_twitter_credentials?
    begin
      consumer = OAuth::Consumer.new(params['twitter:consumer_key'], params['twitter:consumer_secret'], :site => 'https://api.twitter.com/oauth/request_token')
      consumer.get_request_token
      #if it makes it this far all is good
      return true
    rescue
      #if somethign went wrong, return false
      return false
    end
  end
end
