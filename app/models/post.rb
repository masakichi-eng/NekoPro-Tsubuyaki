class Post < ApplicationRecord
  validates :description, presence: true, length: { maximum: 140 }

  belongs_to :user
  has_one_attached :photo
end
