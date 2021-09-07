class GeneralController < ApplicationController
  def index
    @posts = Post.includes(:user).page(params[:page]).per(2).order(created_at: :desc)
    @comment = Comment.new
  end
end
