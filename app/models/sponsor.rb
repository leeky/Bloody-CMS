require 'url_validator'

class Sponsor < ActiveRecord::Base
  attr_accessible :name, :description, :url, :image
  
  before_validation :slugify

  validates_presence_of :name, :description, :url
  validates_uniqueness_of :slug, :message => "^A sponsor with a similar title already exists"
  validates :url, :url => true, :allow_blank => true
  validates :image, :url => true, :allow_blank => true

  scope :by_name, order("name ASC")
  
  def to_param
    "#{slug}"
  end
  
  def image_for_size(size)
    "/sponsors/image/#{size}/#{self.slug}.png"
  end
  
  private
  
  def slugify
    self.slug = self.name.parameterize
  end
end
