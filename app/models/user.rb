class User < ApplicationRecord
  has_many :posts
  has_many :comments
  has_many :likes, foreign_key: :user_id, dependent: :destroy

  def last_three
    posts.order(created_at: :desc).limit(3)
  end
end
