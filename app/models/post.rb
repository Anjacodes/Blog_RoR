class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes
  after_save :update_counter

  def update_counter
    user = User.find(user_id)
    user.increment!(:postsCounter)
  end

  def recent_comments
    comments.order(created_at: :desc).slice(0, 5)
  end
end
