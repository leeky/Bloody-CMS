class Settings
  def self.get(option_name, default=nil)
    begin 
      return Option.get(option_name, default)
    rescue
      return nil
    end
  end

  def self.set(option_name, value)
    begin 
      return Option.set(option_name, value)
    rescue
      return false
    end
  end

  def self.get_all(domain)
    begin 
      return Option.get_all(domain)
    rescue
      return {}
    end
  end

  def self.set_all(options)
    begin 
      return Option.set_all(options)
    rescue
      return false
    end
  end
end