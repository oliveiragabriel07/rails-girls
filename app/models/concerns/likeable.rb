module Likeable
  extend ActiveSupport::Concern

  included do
    has_many :likes, as: :likeable
  end

  def liked_by(user)
    likes.find_by(user: user)
  end

  def liked_by?(user)
    return false unless user
    liked_by(user).present?
  end
end
