class Users::LikesController < UserController
  before_action :set_item

  def create
    Like.create(user: current_user, post_id: params[:post_id])
  end

  def destroy
    Like.find_by(user: current_user, post_id: params[:post_id]).destroy
  end

  private

  def set_item
    @post = Post.find(params[:post_id])
  end
end
