class User < ApplicationRecord
    has_many :posts
    has_many :comments

    def last_three
        self.posts.order(created_at: :desc).slice(0,3)
    end
end