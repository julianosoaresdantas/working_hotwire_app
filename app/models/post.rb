# app/models/post.rb
class Post < ApplicationRecord
  
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy # Make sure this line exists
  has_many :post_categories
  has_many :categories, through: :post_categories

  has_rich_text :content
  has_one_attached :image

  validates :title, presence: true, length: { minimum: 5 }
  validates :content, presence: true

  # Add this method
  def liked_by?(user)
    # Checks if there's a Like record for this post and the given user
    likes.exists?(user: user)
  end
end
