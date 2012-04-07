require 'active_model'
require 'json'

module MoreValidators
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
end
