class Role < ApplicationRecord
  has_many :user_roles
  has_many :users, through: :user_roles

  validates :name, presence: true, inclusion: { in: %w(admin user) }
  validates :description, presence: true
end
