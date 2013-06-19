class PhoneNumber < ActiveRecord::Base
  belongs_to :person
  attr_accessible :number, :person_id

  validates :number, format: { with: /\A\d{10}\z/ } # http://rubular.com/  for reg exp
  validates :person_id, presence: true
end
