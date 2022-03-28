class User < ApplicationRecord
  devise :database_authenticatable,
         :jwt_authenticatable,
         :registerable,
         jwt_revocation_strategy: JwtDenylist
  
  validates :email, uniqueness: true, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP } 
  validates :password, presence: true, length: { minimum: 6 }

  
  has_many :members, dependent: :destroy
  has_many :user_roles, dependent: :destroy
  has_many :roles, through: :user_roles, dependent: :destroy

  after_create :set_default_role

  def set_default_role
    user_role = Role.find_by(name: 'user')
    user_role = Role.create(name: 'user', description: 'User') unless user_role
    user_roles.create(role_id: user_role.id)
  end

  def is_admin?
    !!roles.find_by(name: 'admin')
  end
end
