class Like < ActiveRecord::Base
  belongs_to :likeable, polymorphic: true
  belongs_to :user

  validates :user, uniqueness: {scope: :likeable}
  validates :user, presence: true
  validates :likeable, presence: true
end
