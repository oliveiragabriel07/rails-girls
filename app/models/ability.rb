class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :update, :destroy, :to => :modify

    user ||= User.new

    if user.is_a?(Admin)
      can :manage, :all
    else
      can :manage, Comment
      can [:create, :read, :like], Idea
      can :modify, Idea, :user_id => user.id
    end
  end
end
