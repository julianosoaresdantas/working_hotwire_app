# app/models/comment.rb
class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :content, presence: true # Ensures content is not empty
  validates :user, presence: true     # Ensures a user is always linked
end
