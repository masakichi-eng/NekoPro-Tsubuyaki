class Post < ApplicationRecord
  with_options presence: true do
    validates :description, length: { maximum: 140 }
    validates :photo
  end

  belongs_to :user
  has_one_attached :photo
end
