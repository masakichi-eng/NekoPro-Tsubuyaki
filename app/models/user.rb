class User < ApplicationRecord
  include Discard::Model
  before_destroy :posts_discard
  has_many :posts, dependent: :nullify

  has_many :likes, dependent: :destroy
  has_many :like_posts, through: :likes, source: :post

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX

  validates :nickname, presence: true

  def posts_discard
    posts.discard_all
  end
end
