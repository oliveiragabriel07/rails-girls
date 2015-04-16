class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :update, :destroy, :to => :modify

    user ||= User.new

    can :manage, Comment
    can [:create, :read, :like], Idea
    can :modify, Idea, :user_id => user.id
  end
end
