class Users::CommentsController < UserController
  before_action :set_item
  
  def create
    #投稿に紐づいたコメントを作成
    @post.comments.build(comment_params).save
    render :index
  end

  def destroy
    Comment.find(params[:id]).destroy
    render :index
  end

  private
  def comment_params
    params.require(:comment).permit(:comment, :item_id, :user_id).merge(user_id: 1)
  end

  def set_item
    @post = Post.find(params[:post_id])
  end
end
