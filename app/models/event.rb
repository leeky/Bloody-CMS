require 'nokogiri'
require 'open-uri'
require 'url_validator'

class Event < ActiveRecord::Base
  attr_accessible :title, :description, :review, :venue, :address, :start_date, :end_date, :signup_url, :all_day_event, :url
  
  before_validation :slugify
  validates_presence_of :title, :description, :venue, :address, :start_date, :end_date
  validates_uniqueness_of :slug, :message => "^An event with a similar title already exists"
  validates :start_date, :date => {:before_or_equal_to => :end_date}
  validates :signup_url, :url => true, :allow_blank => true
  validates :url, :url => true, :allow_blank => true
  
  before_save :determine_eventbrite_id
  
  scope :published, where("published_at IS NOT NULL")
  scope :coming_up, where("end_date > ?", Time.now)
  scope :by_date_asc, order("start_date ASC, end_date ASC")
  scope :by_date_desc, order("start_date DESC, end_date DESC")
  
  def to_param
    "#{slug}"
  end
  
  def published?
    !self.published_at.nil?
  end
  
  def published_or_created_at
    self.published_at || self.created_at
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
  
  def determine_eventbrite_id
    if self.signup_url.include?("eventbrite.com") && (self.eventbrite_id.nil? || self.signup_url_changed?)
      doc = Nokogiri::HTML(open(self.signup_url))
      doc.css('input[name=eid]').each do |input|
        self.eventbrite_id = input['value']
      end
    elsif !self.signup_url.include?("eventbrite.com")
      self.eventbrite_id = nil
    end
  end
  
end
