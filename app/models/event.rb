class Event < ActiveRecord::Base
  attr_accessible :title, :description, :review, :venue, :address, :start_date, :end_date
  
  before_validation :slugify
  validates_presence_of :title, :description, :venue, :address, :start_date, :end_date
  validates_uniqueness_of :slug, :message => "^An event with a similar title already exists"
  
  scope :published, where("published_at IS NOT NULL")
  scope :coming_up, order("start_date DESC, end_date ASC")
  
  def to_param
    "#{slug}"
  end
  
  def published?
    !self.published_at.nil?
  end
  
  def ended?
    self.end_date < Time.now
  end
  
  def started?
    self.start_date < Time.now
  end
  
  private
  
  def slugify
    self.slug = self.title.parameterize
  end
  
end
