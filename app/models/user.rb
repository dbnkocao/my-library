class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_one :library, dependent: :destroy
  has_one :address, dependent: :destroy
  accepts_nested_attributes_for :address

  normalizes :email_address, with: ->(e) { e.strip.downcase }
end
