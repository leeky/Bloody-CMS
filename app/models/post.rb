class Post < ActiveRecord::Base
  
  belongs_to :user
  
  before_validation :slugify
  
  attr_accessible :title, :content, :published_at
  validates_presence_of :title, :content
  
  # scopes
  scope :published, where("published_at IS NOT NULL")
  scope :descending_date, order("published_at DESC,  created_at DESC")
  validates_uniqueness_of :slug, :message => "^A post with a similar title already exists"

  
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
