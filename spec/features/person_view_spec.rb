require "spec_helper"
require "capybara/rails"
require "capybara/rspec"

describe 'the person view', type: :feature do
  let(:person) { Person.create(first_name: 'Johe', last_name: 'Doe') }

  before(:each) do
    person.phone_numbers.create(number: "1234567890")
    person.phone_numbers.create(number: "2345678901")
    visit person_path(person)
  end

  it'show the phone numbers' do
    person.phone_numbers.each do |phone|
      expect(page).to have_content(phone.number)
    end
  end

  it 'has a link to add a new phone number' do
    expect(page).to have_link('Add phone number', href: new_phone_number_path(person_id: person.id))
  end

  it 'add a new phone number' do
    page.click_link("Add phone number")
    page.fill_in('Number', with: '1234567890')
    page.click_button('Create Phone number')
    expect(current_path).to eq(person_path(person))
    expect(page).to have_content('1234567890')
  end

  it 'has links to edit the phone number' do
    person.phone_numbers.each do |phone|
      expect(page).to have_link('edit', href: edit_phone_number_path(phone))
    end
  end

  it 'edit phone number' do
    phone = person.phone_numbers.first
    old_num = phone.number
    new_num = "7890123456"
    page.find("#edit-phone-#{phone.id}").click
    page.fill_in('Number', with: new_num)
    page.click_button('Update Phone number')
    expect(current_path).to eq(person_path(person))
    expect(page).to have_content(new_num)
    expect(page).not_to have_content(old_num)
  end

  it 'has links to delete the phone number' do
    person.phone_numbers.each do |phone|
      expect(page).to have_link('delete', href: phone_number_path(phone))
    end
  end

  it 'delete phone number' do
    phone = person.phone_numbers.first
    page.find("#delete-phone-#{phone.id}").click
    expect(current_path).to eq(person_path(person))
    expect(page).not_to have_content(phone.number)
  end
end