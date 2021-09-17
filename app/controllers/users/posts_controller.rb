class Users::PostsController < UserController
  before_action :set_post, only: %i(show edit destroy)

  def index; end

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
    @post = Post.includes(comments: :user).find(params[:id])
  end

  def edit; end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to users_post_path(@post), notice: '記事が編集されました'
    else
      render :edit
    end
  end

  def destroy
    if @post.discard
      redirect_to root_path, notice: '記事が削除されました'
    else
      render :show
    end
  end

  private

  def post_params
    # 投稿機能のみでuser_idは1固定、ユーザー管理が入ったらcurrent_user.idに変更
    params.require(:post).permit(:description, :photo).merge(user_id: 1)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
