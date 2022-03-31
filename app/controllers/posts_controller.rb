class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
    @comments = Comment.all.where("post_id = #{params[:id]}")
    @comment = Comment.all.where("post_id = #{params[:id]}, user_id = #{params[:user_id]}")
  end

  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.create(post_params)

    if @post.save
      redirect_to user_path(@user), notice: 'Successful!'
    else
      flash.now[:notice] = 'Post could not be created'
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
