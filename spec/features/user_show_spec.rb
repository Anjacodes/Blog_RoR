require_relative '../rails_helper'

RSpec.describe 'The user show page', type: :feature do
  describe 'after logging in' do
    before :each do
      profile_picture = 'https://images.unsplash.com/photo-1546019170-f1f6e46039f5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=928&q=80'
      @user1 = User.create!(name: 'test', email: 'test@testmail.com', password: '123456', bio: 'test bio',
                            photo: profile_picture, postsCounter: 1, confirmed_at: Time.now)

      @post1 = @user1.posts.create(title: 'Test Post', text: 'test post')
      @post2 = @user1.posts.create(title: 'Test Post 2', text: 'test post 2')
      @post3 = @user1.posts.create(title: 'Test Post 3', text: 'test post 3')

      visit 'users/sign_in'
      fill_in 'email', with: 'test@testmail.com'
      fill_in 'password', with: '123456'
      click_on 'Log in'

      @path = "/users/#{@user1.id}"
    end

    it "shows the user's profile picture, username and number of posts" do
      visit @path
      expect(page).to have_css("img[src='https://images.unsplash.com/photo-1546019170-f1f6e46039f5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=928&q=80']")
      expect(page).to have_content('test')
      expect(page).to have_content('Number of posts: 4')
      expect(page).to have_content('test bio')
    end

    it "shows the user's first 3 posts and has a button to see all posts" do
      visit @path
      expect(page).to have_content('Test Post')
      expect(page).to have_content('Test Post 2')
      expect(page).to have_content('Test Post 3')
      expect(page).to have_button('See All Posts')
    end

    it "redirects me to post's show page when clicking on a post title" do
      path = @path
      visit path
      click_on 'Test Post 3'
      expect(current_path).to eql("#{path}/posts/#{@post3.id}")
    end

    it 'redirects me to see all posts when clicking the button' do
      path = @path
      visit path
      click_link 'See All Posts'
      expect(current_path).to eql("#{path}/posts")
    end
  end
end
