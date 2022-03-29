class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :likes

  def update_counter
    user.increment!(:postsCounter)
  end

  def recent_comments
    comments.order(created_at: :desc).slice(0, 5)
  end
end
