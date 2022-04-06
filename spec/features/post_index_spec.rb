require_relative '../rails_helper'

RSpec.describe 'The page index page', type: :feature do
  describe 'after logging in' do
    before :each do
      profile_picture = 'https://images.unsplash.com/photo-1546019170-f1f6e46039f5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=928&q=80'
      @user1 = User.create!(name: 'test', email: 'test@testmail.com', password: '123456', bio: 'test bio',
                            photo: profile_picture, postsCounter: 1, confirmed_at: Time.now)

      @post1 = @user1.posts.create!(title: 'Test Post', text: 'test post', commentCounter: 0, likesCounter: 2)
      @post2 = @user1.posts.create!(title: 'Test Post 2', text: 'test post 2', commentCounter: 0, likesCounter: 2)
      @post3 = @user1.posts.create!(title: 'Test Post 3', text: 'test post 3', commentCounter: 0, likesCounter: 2)

      @comment1 = @post1.comments.create!(author: @user1, text: 'test comment')
      @comment2 = @post1.comments.create!(author: @user1, text: 'test comment 2')

      visit 'users/sign_in'
      fill_in 'email', with: 'test@testmail.com'
      fill_in 'password', with: '123456'
      click_on 'Log in'
    end

    it "shows the user's username, profile picture and number of posts" do
      visit "/users/#{@user1.id}/posts"
      expect(page).to have_content 'test'
      expect(page).to have_content 'Number of posts: 4'
      expect(page).to have_css("img[src='https://images.unsplash.com/photo-1546019170-f1f6e46039f5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=928&q=80']")
    end

    it "shows a post's title and some of it's body" do
      visit "/users/#{@user1.id}/posts"
      expect(page).to have_content 'Test Post'
      expect(page).to have_content 'test post'
    end

    it 'shows the first comments on a post' do
      visit "/users/#{@user1.id}/posts"
      expect(page).to have_content 'test: test comment'
      expect(page).to have_content 'test: test comment 2'
    end

    it 'shows the number of likes and comments on a post' do
      visit "/users/#{@user1.id}/posts"
      expect(page).to have_content "Comments: #{@post1.commentCounter} , Likes: #{@post1.likesCounter}"
    end

    it "redirects me to post's show page when clicking on post" do
      path = "/users/#{@user1.id}/posts"
      visit path
      click_on 'Test Post 2'
      expect(current_path).to eql "#{path}/#{@post2.id}"
    end
  end
end
