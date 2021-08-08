class User < ApplicationRecord
  include Discard::Model
  has_many :posts, dependent: :destroy

  after_discard do
    puts posts
    posts.discard_all
  end

  after_undiscard do
    posts.undiscard_all
  end

end
