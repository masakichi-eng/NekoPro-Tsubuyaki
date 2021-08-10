class GeneralController < ApplicationController
  def index
    @posts = Post.all
  end
end
