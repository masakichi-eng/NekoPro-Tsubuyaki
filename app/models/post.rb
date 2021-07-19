class Post < ApplicationRecord
  validates :description, presence: true, length: { maximum: 140 }
  validates :photo, presence: true

  belongs_to :user
  has_one_attached :photo
end
