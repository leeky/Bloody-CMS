class User < ActiveRecord::Base
  has_many :authentications
    
  def self.find_or_create_by_omniauth(auth)
    authentication = Authentication.find_or_create_by_provider_and_uid(auth["provider"], auth["uid"])

    if authentication.user.nil?
      user = User.new
      user.save
      authentication.user = user
      authentication.save
    end
    
    return authentication.user
  end
end
