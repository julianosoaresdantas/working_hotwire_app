# app/models/post.rb
class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :comments, dependent: :destroy
  # Add other associations here if they were part of the intended code but were in the conflicted section.
  # For example, if you have likes and categories for posts:
  # has_many :likes, dependent: :destroy
  # has_many :post_categories
  # has_many :categories, through: :post_categories

  # ... (rest of your Post model code, like validations, methods, etc.) ...
  # Ensure there is only ONE 'class Post < ApplicationRecord' definition
  # and ONE matching 'end' statement at the very end of the class.
end
