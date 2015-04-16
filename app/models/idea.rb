class Idea < ActiveRecord::Base
  include Likeable
  
	belongs_to :user
	has_many :comments
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
end
