class Users::PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_paramas)
    if @post.save
      redirect_to root_path
    else
      render :new
    end
  end

  private
    def post_paramas
      params.require(:post).permit(:description, :photo).merge(user_id: 1)
    end
end