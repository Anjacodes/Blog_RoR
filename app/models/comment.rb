class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post, foreign_key: :post_id

  def comments_counter
    post.increment!(:commentCounter)
  end
end
