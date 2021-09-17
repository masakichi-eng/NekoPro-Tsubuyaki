class GeneralController < ApplicationController
  def index
    @posts = Post.includes(comments: :user).page(params[:page]).per(2).order(created_at: :desc)
  end
end
