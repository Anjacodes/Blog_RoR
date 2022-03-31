class User < ApplicationRecord
  has_many :posts
  has_many :comments
  has_many :likes, foreign_key: :user_id

  def last_three
    posts.order(created_at: :desc).slice(0, 3)
  end
end
