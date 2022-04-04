class User < ApplicationRecord
  has_many :posts
  has_many :comments
  has_many :likes, foreign_key: :user_id, dependent: :destroy

  validates :name, presence: true
  validates :postsCounter, numericality: { only_integer: true, greater_than_or_equal_to: 0}

  def last_three
    posts.order(created_at: :desc).limit(3)
  end
end
