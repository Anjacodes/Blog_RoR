class Like < ApplicationRecord
    belongs_to :post
    belongs_to :user

    def post_like_counter
        post.increment!(:likesCounter)
    end
end