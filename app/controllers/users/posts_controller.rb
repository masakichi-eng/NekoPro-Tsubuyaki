class Users::PostsController < UserController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to root_path, notice: '記事が投稿されました'
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  private

  def post_params
    # 投稿機能のみでuser_idは1固定、ユーザー管理が入ったらcurrent_user.idに変更
    params.require(:post).permit(:description, :photo).merge(user_id: 1)
  end
end
