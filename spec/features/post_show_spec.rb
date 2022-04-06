require_relative '../rails_helper'

RSpec.describe 'The page show page', type: :feature do
  describe 'after logging in' do
    before :each do
      profile_picture = 'https://images.unsplash.com/photo-1546019170-f1f6e46039f5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=928&q=80'

      @user1 = User.create!(name: 'test', email: 'test@testmail.com', password: '123456', bio: 'test bio',
                            photo: profile_picture, postsCounter: 1, confirmed_at: Time.now)

      @user2 = User.create!(name: 'test 2', email: 'test2@testmail.com', password: 'qwerty', bio: 'test bio 2',
                            photo: profile_picture, postsCounter: 1, confirmed_at: Time.now)

      @post1 = @user1.posts.create!(title: 'Test Post', text: 'test post', commentCounter: 0, likesCounter: 2)

      @comment1 = @post1.comments.create!(author: @user1, text: 'test comment')
      @comment2 = @post1.comments.create!(author: @user2, text: 'test comment 2')

      visit 'users/sign_in'
      fill_in 'email', with: 'test@testmail.com'
      fill_in 'password', with: '123456'
      click_on 'Log in'

      @path = "/users/#{@user1.id}/posts/#{@post1.id}"
    end

    it 'shows the post title and author' do
      visit @path
      expect(page).to have_content 'Test Post by test'
    end

    it 'shows the number of comments and likes' do
      visit @path
      expect(page).to have_content 'Comments: 2, Likes: 2'
    end

    it 'shows the post body' do
      visit @path
      expect(page).to have_content 'test post'
    end

  end
end
