class Users::LikesController < UserController
  before_action :set_item 

  def create
    Like.create(user_id: 1, post_id: params[:post_id])
  end
  
  def destroy
    Like.find_by(user_id: 1, post_id: params[:post_id]).destroy
  end

  private

  def set_item
    @post = Post.find_by(id: params[:post_id])
  end

end
