class Post < ApplicationRecord
  include Discard::Model
  scope :kept, -> { undiscarded.joins(:user).merge(User.kept) }

  def kept?
    undiscarded? && user.kept?
  end
  
  with_options presence: true do
    validates :description, length: { maximum: 140 }
    validates :photo
  end

  belongs_to :user
  has_one_attached :photo
end
