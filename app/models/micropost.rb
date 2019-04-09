class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true	#This is related to the valid? method used in tests
  validates :content, presence: true, length: { maximum: 140 }
end
