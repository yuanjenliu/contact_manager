require 'spec_helper'

describe PhoneNumber do
  #let(:phone_number) {PhoneNumber.new number: "1234567890", person_id: 1 }
  # when just added person_id: 1 => got error
    #Failure/Error: let(:phone_number) {PhoneNumber.new number: "1234567890", person_id: 1 }
    #ActiveModel::MassAssignmentSecurity::Error:
    #Can't mass-assign protected attributes: person_id
  # fix =>
  # 1. modify model - attr_accessible :number, person_id
  # 2. modify spec file => my choice
  #    remove person_id: 1 from let statemet, just set person_id
  let (:phone_number) do
    phone_number = PhoneNumber.new number: "1234567890"
    phone_number.person_id = 1
    phone_number
  end

  it "is valid" do
    expect(phone_number).to be_valid
  end

  it 'is invalid without a phone number' do
    phone_number.number = nil
    expect(phone_number).to be_invalid
  end

  it 'is invalid phone number' do
    phone_number.number = 'this is a phone number'
    expect(phone_number).to be_invalid

  end

  it 'must have a reference to a person' do
    phone_number.person_id = nil
    expect(phone_number).to be_invalid
  end

  it '' do

  end
end
