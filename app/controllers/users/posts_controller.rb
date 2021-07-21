class Users::PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    puts params.inspect
    @post = Post.new(post_paramas)
    if @post.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def post_paramas
    # 投稿機能のみでuser_idは1固定、ユーザー管理が入ったらcurrent_user.idに変更
    params.require(:post).permit(:description, :photo).merge(user_id: 1)
  end
end
