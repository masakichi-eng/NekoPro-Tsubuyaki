class Post < ApplicationRecord
  include Discard::Model
  default_scope -> { kept }

  with_options presence: true do
    validates :description, length: { maximum: 140 }
    validates :photo
  end

  belongs_to :user
  has_one_attached :photo

  has_many :likes, dependent: :destroy
  has_many :like_users, through: :likes, source: :user
end
