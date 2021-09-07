class Users::CommentsController < UserController
  before_action :set_item, only: %i(create destroy)
  
  def create
    Comment.create(user_id: 1, post_id: @post.id, comment: params[:comment][:comment])
    render :index
  end

  def destroy
    Comment.find(params[:id]).destroy
    render :index
  end

  private
  def set_item
    @post = Post.find(params[:post_id])
  end
end
