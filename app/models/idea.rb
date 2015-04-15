class Idea < ActiveRecord::Base
	belongs_to :user
	has_many :comments
  has_many :likes, as: :likeable
	mount_uploader :picture, PictureUploader

  validates :name, presence: true, length: {
    minimum: 3,
    maximum: 50
  }
  validates :description, length: {
    minimum: 3,
    maximum: 256,
    allow_blank: true
  }
  validates :picture, presence: true
  validates :user, presence: true

  def liked_by?(user)
    liked_by(user).present?
  end

  def liked_by(user_id)
    user_id = user_id.id if user_id.is_a?(User)
    likes.find_by(user_id: user_id)
  end
end
