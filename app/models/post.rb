class Post < ActiveRecord::Base
  
  before_create :slugify
  
  attr_accessible :title, :content
  
  
  def to_param
    "#{slug}"
  end
  
  private
  
  def slugify
    self.slug = self.title.parameterize
  end
end
