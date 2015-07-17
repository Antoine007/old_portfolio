class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      record.errors[attribute] << (options[:message] || "is not an email")
    end
  end
end

class Clinician < ActiveRecord::Base

  has_many :patients

  validates :token,     uniqueness: true
  validates :first_name, :last_name, presence: true

  auto_strip_attributes :email, :first_name, :last_name, :squish => true

  # only reactivate this at the end of test
  # validates             :email,      uniqueness: true
  validates :email, email: true, presence: true
end
