class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token

  def posts_index
    @posts = Post.where('user_id = ?', find_user)
    render json: @posts
  end

  def list_comments
    @comments = Comment.where('post_id = ?', find_post)
    render json: @comments
  end

  def create_comment
    user = User.find(params[:user_id])
    @new_comment = user.comments.new(post_id: find_post, text: "New Api Comment")

    if @new_comment.save
      render json: @new_comment, status: :created
    else
      render json: @new_comment.errors, status: :unprocessable_entity
    end
  end

  private

  def find_user
    @user = User.find(params[:id])
    @user.id
  end

  def find_post
    @post = Post.find(params[:id])
    @post.id
  end
end