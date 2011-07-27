class Option < ActiveRecord::Base
  def self.get(option_name, default=nil)
    tokens = option_name.split(":")
    raise ArgumentError, "Wrong argument count (expecting 1 or 2 instead of #{tokens.length})" unless tokens.count == 1 || tokens.count == 2
    
    domain = tokens.count == 2 ? tokens.first : "general"
    key = tokens.last
    
    option = Option.find_or_create_by_domain_and_key(domain, key)
    option.value || default
  end
  
  def self.set(option_name, value)
    tokens = option_name.split(":")
    raise ArgumentError, "Wrong argument count (expecting 1 or 2 instead of #{tokens.length})" unless tokens.count == 1 || tokens.count == 2
    
    domain = tokens.count == 2 ? tokens.first : "general"
    key = tokens.last
    
    option = Option.find_or_create_by_domain_and_key(domain, key)
    option.value = value
    option.save
  end
  
  def self.get_all(domain)
    options = Option.where(:domain => domain).collect {|o| ["#{domain}:#{o.key}", 0.value] }.flatten
  end
  
  def self.set_all(options)
    options.each do |key, value|
      Option.set(key, value)
    end
  end
end
