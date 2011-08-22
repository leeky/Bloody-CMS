class Option < ActiveRecord::Base
  def self.get(option_name, default=nil)
    tokens = option_name.split(":")
    raise ArgumentError, "Wrong argument count (expecting 1 or 2 instead of #{tokens.length})" unless tokens.count == 1 || tokens.count == 2
    
    domain = tokens.count == 2 ? tokens.first : "general"
    key = tokens.last
    
    return Rails.cache.fetch("option:#{domain}:#{key}") do    
      option = Option.find_by_domain_and_key(domain, key)
      if option.nil? || option.value.blank?
        return option_name.ends_with?("?") ? false : default
      elsif option_name.ends_with?("?")
        return option.value == 't'
      else
        return option.value
      end
    end
  end
  
  def self.set(option_name, value)
    tokens = option_name.split(":")
    raise ArgumentError, "Wrong argument count (expecting 1 or 2 instead of #{tokens.length})" unless tokens.count == 1 || tokens.count == 2
    
    domain = tokens.count == 2 ? tokens.first : "general"
    key = tokens.last
    
    value = true if option_name.ends_with?("?") && value == "t"
    value = false if option_name.ends_with?("?") && value == "f"
    
    option = Option.find_or_create_by_domain_and_key(domain, key)
    option.value = value
    saved = option.save
    Rails.cache.delete("option:#{domain}:#{key}") if saved
    return saved
  end
  
  def self.get_all(domain)
    options = Option.where(:domain => domain).collect {|o| ["#{domain}:#{o.key}", 0.value] }.flatten
  end
  
  def self.set_all(options)
    options.each do |key, value|
      Settings.set(key, value)
    end
  end
end
