class Comment < ActiveRecord::Base
	belongs_to :idea

  validates :user_name, presence: true
  validates :body, presence: true
  validates :idea_id, presence: true
end
