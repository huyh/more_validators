require 'spec_helper'
require 'ostruct'

describe "Validators" do
  let(:attribute) { :an_attr }
  let(:model) { OpenStruct.new(:errors => { attribute => [] }) }
  subject { model.errors[attribute] }

  describe JsonValidator do
    let(:validator) { JsonValidator.new({:attributes => attribute}) }

    it "returns if the value is a valid JSON string" do
      validator.validate_each(model, attribute, '{"first_name": "hello", "last_name": "world"}')
      subject.should be_empty

      validator.validate_each(model, attribute, 'hello')
      subject.should_not be_empty
    end

    it "sets a default error message if there isn't one in the options" do
      validator.validate_each(model, attribute, 'hello')
      subject.should == ['must be in JSON format']
    end

    it "can use a specified error message" do
      validator = JsonValidator.new({:attributes => attribute, :message => 'hello world error'}) 
      validator.validate_each(model, attribute, 'hello')
      subject.should == ['hello world error']
    end
  end

  describe EmailValidator do
    let(:validator) { EmailValidator.new({:attributes => attribute}) }

    it "returns if the value is a valid email" do
      validator.validate_each(model, attribute, 'test@email.com')
      subject.should be_empty

      validator.validate_each(model, attribute, 'test@email')
      subject.should_not be_empty
    end
  end
end