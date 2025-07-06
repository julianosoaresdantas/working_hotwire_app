# app/models/post_category.rb
class PostCategory < ApplicationRecord
  # NEW: Relationships for Post and Category
  belongs_to :post
  belongs_to :category

  # Optional: Add a validation to prevent duplicate post-category pairs
  validates :post_id, uniqueness: { scope: :category_id, message: "already has this category" }
end
