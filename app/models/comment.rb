class Comment < ActiveRecord::Base
  include Likeable
	belongs_to :idea
  belongs_to :user

  validates :body, presence: true
  validates :idea_id, presence: true
  validates :user, presence: true
end
