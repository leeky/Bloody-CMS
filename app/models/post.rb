class Post < ActiveRecord::Base
  
  before_create :slugify
  
  attr_accessible :title, :content
  
  # scopes
  scope :published, where("published_at IS NOT NULL")
  scope :descending_date, order("published_at DESC,  created_at DESC")

  
  def to_param
    "#{slug}"
  end
  
  def published?
    !self.published_at.nil?
  end
  
  def published_or_created_at
    self.published_at || self.created_at
  end
  
  private
  
  def slugify
    self.slug = self.title.parameterize
  end
end
