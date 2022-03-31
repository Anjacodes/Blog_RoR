require_relative '../rails_helper'

RSpec.describe Post, type: :model do
    user = User.create(name: "Harriet", postsCounter: 0)
    subject { Post.new(title: "Title", text: "This is the text", user_id: 1, commentCounter: 3, likesCounter: 8 ) }

    before(:each) {subject.save}

    it 'title must be present' do
        subject.title = nil
        expect(subject).to_not be_valid
    end

    it 'title must not exceed 250 characters' do
        subject.title = "a" * 251
        expect(subject).to_not be_valid
    end

    it 'commentCounter is an integer' do
        subject.commentCounter = 'abc'
        expect(subject).to_not be_valid
    end

    it 'commentCounter is greater than or equal to 0' do
        expect(subject.commentCounter).to eql 3
    end

    it 'likesCounter is an integer' do
        expect(subject.likesCounter).to eql 8
    end

    it 'likesCounter is greater than or equal to 0' do
        expect(subject.likesCounter).to eql 8
    end

    context "recent_comments method" do
        it ' should return recent comments' do
            expect(subject.recent_comments.count).to be(0)
        end
    end

    context "user.increment! method" do
        it 'increments user posts counter' do
            user.increment!(:postsCounter)
            expect(user.postsCounter).to eql 1
        end
    end
end