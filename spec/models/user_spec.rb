require_relative '../rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Jenny', postsCounter: 8) }

  before(:each) { subject.save }

  it 'name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'postsCounter should be an integer' do
    subject.postsCounter = 'abc'
    expect(subject).to_not be_valid
  end

  it 'postsCounter should be greater than or equal to 0' do
    subject.postsCounter = -8
    expect(subject).to_not be_valid
  end

  context 'Last_three method' do
    it ' should return last three posts' do
      expect(subject.last_three.count).to be(0)
    end
  end
end
