require_relative '../rails_helper'

RSpec.describe Comment, type: :model do
    post = Post.create(title: "Hello World", commentCounter: 0)
    subject { Comment.new(text: "Comment", user_id: 1, post_id: post.id ) }

    before(:each) {subject.save}

    context 'post.increment! method' do
      it "increments a posts comment counter" do
        post.increment!(:commentCounter)
        expect(post.commentCounter).to eql 1
      end
    end
end