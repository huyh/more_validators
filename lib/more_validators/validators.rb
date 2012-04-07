require 'active_model'
require 'json'

class JsonValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless valid_json?(value)
      record.errors[attribute] << (options[:message] || 'must be in JSON format')
    end
  end

  private  
  def valid_json?(json)
    JSON.parse(json)
  rescue
    false
  end
end  

class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
      record.errors[attribute] << (options[:message] || "is not a valid email") 
    end
  end
end