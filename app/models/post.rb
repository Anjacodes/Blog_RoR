class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'user_id'
  has_many :comments
  has_many :likes, dependent: :destroy
  after_save :update_counter

  validates :title, presence: true, length: { in: 1..250 }
  validates :commentCounter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_blank: true
  validates :likesCounter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_blank: true

  def update_counter
    user = User.find(user_id)
    user.increment!(:postsCounter)
  end

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end
end
