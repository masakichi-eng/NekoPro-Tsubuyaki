class User < ApplicationRecord
  include Discard::Model
  before_destroy :posts_discard
  has_many :posts, dependent: :nullify

  has_many :likes, dependent: :destroy
  has_many :like_posts, through: :likes, source: :post

  has_many :comments, dependent: :destroy

  def posts_discard
    posts.discard_all
  end
end
