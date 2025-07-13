# app/models/user.rb
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable # Ensure these are present
  # :trackable is particularly relevant as you just added its columns

  # ... other associations like has_many :comments ...
  has_many :comments, dependent: :nullify # or :destroy
  has_many :likes, dependent: :destroy
  has_many :posts, dependent: :destroy

end
