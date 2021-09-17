class Users::CommentsController < UserController
  before_action :set_item, only: %i(create destroy)

  def create
    @post.comments.create(user_id: 1, comment: params[:comment])
    redirect_back fallback_location: root_path
  end

  def destroy
    @post.comments.find(params[:id]).destroy
    redirect_back fallback_location: root_path
  end

  private

  def set_item
    @post = Post.find(params[:post_id])
  end
end
