class User < ApplicationRecord
  include Discard::Model
  before_destroy :posts_discard
  has_many :posts, dependent: :nullify

  has_many :likes, dependent: :destroy
  has_many :like_posts, through: :likes, source: :post

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates :password, format: { with: PASSWORD_REGEX }

  has_many :posts

  validates :nickname, presence: true

  has_many :comments, dependent: :destroy

  def posts_discard
    posts.discard_all
  end
end
