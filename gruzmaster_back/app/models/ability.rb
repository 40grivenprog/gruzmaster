# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Company
    can [:create, :destroy], Company if user&.is_admin?
  end
end
