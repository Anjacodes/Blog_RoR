require_relative '../rails_helper'

RSpec.describe Post, type: :model do
  subject { Post.new(title: 'Title', text: 'This is the text', user_id: 1, commentCounter: 3, likesCounter: 8) }

  before { subject.save }

  it 'title must be present' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'title must not exceed 250 characters' do
    subject.title = 'a' * 251
    expect(subject).to_not be_valid
  end

  it 'commentCounter is an integer' do
    subject.commentCounter = 'abc'
    expect(subject).to_not be_valid
  end

  it 'commentCounter is greater than or equal to 0' do
    subject.commentCounter = -8
    expect(subject).to_not be_valid
  end

  it 'likesCounter is an integer' do
    subject.likesCounter = 'abc'
    expect(subject).to_not be_valid
  end

  it 'likesCounter is greater than or equal to 0' do
    subject.likesCounter = -8
    expect(subject).to_not be_valid
  end
end
