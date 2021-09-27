class Users::PostsController < UserController
  before_action :set_post, only: %i(show edit destroy)
  before_action :move_root, only: %i(edit destroy)

  def index
    @posts = current_user.posts.order(created_at: :desc)
  end

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
    params.require(:post).permit(:description, :photo).merge(user_id: current_user.id)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def move_root
    begin
      raise StandardError unless @post.user == current_user
    rescue
      puts "StandardError, user_id:#{current_user.id}が違うuser_id:#{@post.user.id}の投稿に編集・削除のアクセス"
      redirect_to root_path, notice: "投稿したユーザではありません"
    end
  end
end
