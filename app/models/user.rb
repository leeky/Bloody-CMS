class User < ActiveRecord::Base
  has_many :authentications
  
  scope :admin, where(:is_admin => true)
    
  def self.find_or_create_by_omniauth(auth)
    authentication = Authentication.find_or_create_by_provider_and_uid(auth["provider"], auth["uid"])

    if authentication.user.nil?
      user = User.new
      user.is_admin = true if User.admin.count.zero?
      user.name = auth['user_info']['nickname']
      user.save
      authentication.user = user
      authentication.save
    end
    
    
    
    return authentication.user
  end
end
