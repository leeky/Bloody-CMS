class User < ActiveRecord::Base
  has_many :authentications
  
  scope :admin, where(:is_admin => true)
    
  before_create { generate_token(:auth_token) }  
    
    
  ###
  ### Finds and or creates a user based of the omniauth hash
  ###
  def self.find_or_create_by_omniauth(auth)
    authentication = Authentication.find_or_create_by_provider_and_uid(auth["provider"], auth["uid"])

    if authentication.user.nil?
      user = User.new
      user.is_admin = true if User.admin.count.zero?
      user.save
      authentication.user = user
      authentication.save
    end
    
    authentication.user.name = auth['user_info']['nickname']
    authentication.user.image = auth['user_info']['image']
    authentication.user.save
    
    return authentication.user
  end
    
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
end
