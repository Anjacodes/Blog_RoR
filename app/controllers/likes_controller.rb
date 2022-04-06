class LikesController < ApplicationController
  before_action :find_post, :find_user

  def create
    @like = @post.likes.new(author: @user)
    if @like.save
      redirect_to user_post_path(@user, @post), notice: 'Like added successfully!'
    else
      flash.now[:notice] = 'Like could not be added'
      render 'posts/show'
    end
  end

  def find_post
    @post = Post.find(params[:post_id])
  end

  def find_user
    @user = User.find(params[:user_id])
  end
end
