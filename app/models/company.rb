class Company < ApplicationRecord
  belongs_to :user
  validates :name, presence: true
  validates :address, :established_year, presence: true
end
