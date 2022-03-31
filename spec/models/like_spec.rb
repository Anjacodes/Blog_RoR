require_relative '../rails_helper'

RSpec.describe Like, type: :model do
  user = User.create(name: 'Harriet')
  post = Post.create(id: 1, title: 'Hello World', likesCounter: 0)
  subject { Like.new(user_id: user.id, post_id: post.id) }

  before(:each) { subject.save }

  context 'post.increment! method' do
    it 'updates likes counter' do
      post.increment!(:likesCounter)
      expect(post.likesCounter).to eql 1
    end
  end
end
