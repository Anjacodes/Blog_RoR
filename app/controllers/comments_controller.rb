class CommentsController < ApplicationController

    before_action :find_post

    def create
      @user = User.find(params[:user_id])
      @comment = @post.comments.create(comment_params)
      @comment.user_id = @user.id

      if @comment.save
        redirect_to user_post_path(@user, @post), notice: "Successful!"
      else
        flash.now[:notice] = "Comment could not be created"
        render :new
      end
    end

    private

    def comment_params
      params.require(:comment).permit(:text)
    end

    def find_post
     @post = Post.find(params[:post_id])
    end
end
