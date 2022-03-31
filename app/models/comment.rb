class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  after_save :comments_counter

  def comments_counter
    post = Post.find(post_id)
    post.increment!(:commentCounter)
  end
end
