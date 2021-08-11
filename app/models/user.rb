class User < ApplicationRecord
  include Discard::Model
  before_destroy :posts_discard
  has_many :posts, dependent: :nullify

  def posts_discard
    posts.discard_all
  end
end
