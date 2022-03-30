class Like < ApplicationRecord
  belongs_to :post
  belongs_to :author, class_name: 'User'
  after_save :post_like_counter

  def post_like_counter
    post = Post.find(post_id)
    post.increment!(:likesCounter)
  end
end
