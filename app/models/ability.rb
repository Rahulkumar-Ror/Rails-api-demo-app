class Ability
  include CanCan::Ability

  def initialize(user)
    if user.super_admin?
      can :manage, :all
    else user.admin?
      # binding.pry
      can :read, Company, user_id: user.id
      can :update, Company, user_id: user.id
      can :search, Company
      can :destroy, Company, user_id: user.id
    end
  end
end
