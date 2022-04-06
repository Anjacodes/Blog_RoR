require_relative '../rails_helper'

RSpec.describe 'The user index page', type: :feature do
  describe 'after logging in' do
    before :each do
      profile_picture = 'https://images.unsplash.com/photo-1546019170-f1f6e46039f5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=928&q=80'
      @user1 = User.create!(name: 'test', email: 'test@testmail.com', password: '123456', photo: profile_picture,
                            postsCounter: 1, confirmed_at: Time.now)
      @user2 = User.create!(name: 'test2', email: 'test2@testmail.com', password: 'qwerty', photo: profile_picture,
                            postsCounter: 3, confirmed_at: Time.now)

      visit 'users/sign_in'
      fill_in 'email', with: 'test@testmail.com'
      fill_in 'password', with: '123456'
      click_on 'Log in'
    end

    it 'shows all user names' do
      visit 'users'
      expect(page).to have_content 'test'
      expect(page).to have_content 'test2'
    end

    it 'shows all profile pictures' do
      visit 'users'
      expect(page).to have_css("img[src='https://images.unsplash.com/photo-1546019170-f1f6e46039f5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=928&q=80']")
    end

    it 'shows the number of posts for each user' do
      visit 'users'
      expect(@user1.postsCounter).to eql 1
      expect(@user2.postsCounter).to eql 3
    end

    it "redirects me to user's show page when clicking on a user" do
      visit 'users'
      click_on 'test'
      user_id = @user1.id
      expect(current_path).to eql("/users/#{user_id}")
    end
  end
end
