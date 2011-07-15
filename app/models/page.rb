class Page < ActiveRecord::Base
  
  before_save :slugify
  
  attr_accessible :title, :content, :sidebar_title, :show_in_sidebar
  validates_presence_of :title, :content
  
  
  # scopes
  scope :published, where("published_at IS NOT NULL")
  scope :in_sidebar, where("show_in_sidebar = ?", true)
  
  
  def to_param
    "#{slug}"
  end
  
  def published?
    !self.published_at.nil?
  end
  
  def published_or_created_at
    self.published_at || self.created_at
  end
  
  def sidebar_title_or_title
    self.sidebar_title || self.title
  end
  
  private
  
  def slugify
    self.slug = self.title.parameterize
  end
end
