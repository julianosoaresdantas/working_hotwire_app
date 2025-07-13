# app/models/category.rb
class Category < ApplicationRecord
  has_many :post_categories # Add this line
  has_many :posts, through: :post_categories # Add this line

  validates :name, presence: true, uniqueness: true
end
