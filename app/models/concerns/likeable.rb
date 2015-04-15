module Likeable
  extend ActiveSupport::Concern

  included do
    has_many :likes, as: :likeable
  end

  def liked_by?(user)
    liked_by(user).present?
  end

  def liked_by(user_id)
    user_id = user_id.id if user_id.is_a?(User)
    likes.find_by(user_id: user_id)
  end
end