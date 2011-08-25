class Event < ActiveRecord::Base
  attr_accessible :title, :description, :review, :venue, :address, :start_date, :end_date, :signup_url, :all_day_event
  
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
  
  def date_range 
    start_date_date = self.start_date.strftime("%A %e %B %Y") 
    start_date_time = self.start_date.strftime("%R")
    end_date_date = self.end_date.strftime("%A %e %B %Y") 
    end_date_time = self.end_date.strftime("%R")
    
    if start_date_date == end_date_date && start_date_time != end_date_time && !self.all_day_event
      "#{start_date_date}, #{start_date_time}-#{end_date_time}"
    elsif start_date_date == end_date_date && start_date_time == end_date_time && !self.all_day_event
      "#{start_date_date}, #{start_date_time}"
    elsif start_date_date != end_date_date && self.all_day_event
      "#{start_date_date} - #{end_date_date}"
    elsif start_date_date == end_date_date && self.all_day_event
      "#{start_date_date}"
    else
      "#{start_date_date}, #{start_date_time} - #{end_date_date}, #{end_date_time}"
    end
  end
  
  private
  
  def slugify
    self.slug = self.title.parameterize
  end
  
end
