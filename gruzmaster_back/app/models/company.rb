class Company < ApplicationRecord
  validates :company_name, presence: true
  validates :company_description, presence: true
end
