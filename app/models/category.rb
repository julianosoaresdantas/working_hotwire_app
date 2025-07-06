# app/models/category.rb
class Category < ApplicationRecord
  # Relationships for Posts
  has_many :post_categories, dependent: :destroy
  has_many :posts, through: :post_categories

  validates :name, presence: true, uniqueness: true
end
