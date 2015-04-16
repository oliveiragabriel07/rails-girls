class Comment < ActiveRecord::Base
  include Likeable
	belongs_to :idea

  validates :user_name, presence: true
  validates :body, presence: true
  validates :idea_id, presence: true
end
