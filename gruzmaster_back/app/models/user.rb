class User < ApplicationRecord
  devise :database_authenticatable,
         :jwt_authenticatable,
         :registerable,
         jwt_revocation_strategy: JwtDenylist
  
  has_many :members, dependent: :destroy
  has_many :user_roles, dependent: :destroy
  has_many :roles, through: :user_roles, dependent: :destroy
  after_create :set_default_role

  def set_default_role
    user_role = Role.find_by(name: 'user')
    user_roles.create(role_id: user_role.id)
  end
end
