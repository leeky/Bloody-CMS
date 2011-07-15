class Post < ActiveRecord::Base
  
  before_create :slugify
  
  attr_accessible :title, :content
  
  scope :published, where("published_at IS NOT NULL")
  
  
  def to_param
    "#{slug}"
  end
  
  def published?
    !self.published_at.nil?
  end
  
  private
  
  def slugify
    self.slug = self.title.parameterize
  end
end
