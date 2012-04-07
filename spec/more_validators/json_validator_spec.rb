require 'spec_helper'
require 'ostruct'

describe 'MoreValidators::JsonValidator' do
  let(:model) { OpenStruct.new(:errors => {:name => []}) }
  let(:validator) { MoreValidators::JsonValidator.new({:attributes => :name}) }
  subject { model.errors[:name] }

  it "returns if the value is a valid JSON string" do
    validator.validate_each(model, :name, '{"first_name": "hello", "last_name": "world"}')
    subject.should be_empty

    validator.validate_each(model, :name, 'hello')
    subject.should_not be_empty
  end

  it "sets a default error message if there isn't one in the options" do
    validator.validate_each(model, :name, 'hello')
    subject.should == ['must be in JSON format']
  end

  it "can use a specified error message" do
    validator = MoreValidators::JsonValidator.new({:attributes => :name, :message => 'hello world error'}) 
    validator.validate_each(model, :name, 'hello')
    subject.should == ['hello world error']
  end
end