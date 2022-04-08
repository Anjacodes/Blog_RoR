module Api
  class ApiController < ApplicationController
    skip_before_action :verify_authenticity_token

    def posts_index
      @user = User.find_by_api_token(request.headers['X-AUTH-TOKEN'])
      @posts = Post.where(user_id: @user.id)
      render json: @posts
    end

    def list_comments
      @user = User.find_by_api_token(request.headers['X-AUTH-TOKEN'])
      @comments = Comment.where(user_id: @user_id)
      render json: @comments
    end

    def create_comment
      @user = User.find_by_api_token(request.headers['X-AUTH-TOKEN'])
      @new_comment = @user.comments.new(post_id: params[:post_id], text: params[:text])

      if @new_comment.save
        render json: @new_comment, status: :created
      else
        render json: @new_comment.errors, status: :unprocessable_entity
      end
    end
  end
end
