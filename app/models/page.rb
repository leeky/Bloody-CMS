class Page < ActiveRecord::Base
  
  before_validation :slugify
  
  attr_accessible :title, :content, :sidebar_title, :show_in_sidebar, :published_at
  validates_presence_of :title, :content
  validates_uniqueness_of :slug, :message => "^A page with a similar title already exists"
  
  
  # scopes
  scope :published, where("published_at IS NOT NULL")
  scope :unpublished, where("published_at IS NULL")
  scope :unpublished_or_hidden, where("published_at IS NULL OR show_in_sidebar = ?", false)
  scope :in_sidebar, where("show_in_sidebar = ?", true)
  
  
  def to_param
    "#{slug}"
  end
  
  def published?
    !self.published_at.nil?
  end
  
  def in_sidebar?
    self.show_in_sidebar
  end
  
  def hidden?
    !self.show_in_sidebar
  end
  
  def published_or_created_at
    self.published_at || self.created_at
  end
  
  def sidebar_title_or_title
    self.sidebar_title.blank? ? self.title : self.sidebar_title
  end
  
  private
  
  def slugify
    self.slug = self.title.parameterize
  end
end
