<<<<<<< HEAD
# app/models/post.rb
class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  # NEW: Relationships for Categories
  has_many :post_categories, dependent: :destroy # The join table records
  has_many :categories, through: :post_categories # The actual categories

  validates :title, presence: true
  validates :content, presence: true

  def liked_by?(user)
    likes.exists?(user: user)
  end
=======
class Post < ApplicationRecord
>>>>>>> 2d32fe77661cbb6d5c2f23a40816540019075e13
end
