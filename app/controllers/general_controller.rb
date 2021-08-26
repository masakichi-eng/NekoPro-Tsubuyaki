class GeneralController < ApplicationController
  def index
    @posts = Post.page(params[:page]).per(2).includes(:user)
  end
end
