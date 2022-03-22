require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  # make a get request
  describe 'GET #index' do
    before(:example) { get '/users/:user_id/posts' }
    it 'successfully loads the page' do
      expect(response).to have_http_status(:ok)
    end
    it "renders 'index' template" do
      expect(response).to render_template(:index)
    end
    it 'response body includes correct placeholder text' do
      expect(response.body).to include('This is a list of all posts for a certain user')
    end
  end

  describe 'GET #show' do
    before(:example) { get '/users/:user_id/posts/:id' }
    it 'successfully loads the page' do
      expect(response).to have_http_status(:ok)
    end
    it "renders 'show' template" do
      expect(response).to render_template(:show)
    end
    it 'response body includes correct placeholder text' do
      expect(response.body).to include('This is a specific post for a specific user')
    end
  end
end
