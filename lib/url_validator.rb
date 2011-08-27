class UrlValidator < ActiveModel::EachValidator
  URL_REGEX = /^(http[s]?:\/\/){0,1}(www\.){0,1}[a-zA-Z0-9\.\-]+\.[a-zA-Z]{2,5}[\.]{0,1}/i
  
  def validate_each(record, attribute, value)
    record.errors[attribute] << "is not a valid URL" unless value =~ URL_REGEX
  end
end