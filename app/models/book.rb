class Book < ApplicationRecord
  validates :isbn, uniqueness: true
  has_and_belongs_to_many :authors
  has_and_belongs_to_many :subjects
  has_many :search_prices, dependent: :destroy
end
