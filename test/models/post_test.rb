<<<<<<< HEAD
# test/models/post_test.rb
require "test_helper" # This MUST be the first line

class PostTest < ActiveSupport::TestCase
  # This is a setup method that runs before each test
  setup do
    @user = users(:one) # Assuming you have a fixture for users
  end

  test "post must have a title" do
    post = Post.new(content: "Some content", user: @user)
    assert_not post.save, "Saved the post without a title"
    assert post.errors[:title].any?, "No error for missing title"
  end

  test "post must have content" do
    post = Post.new(title: "Some title", user: @user)
    assert_not post.save, "Saved the post without content"
    assert post.errors[:content].any?, "No error for missing content"
  end

  test "post can be saved with valid attributes" do
    post = Post.new(title: "Valid Title", content: "Valid Content", user: @user)
    assert post.save, "Could not save the post with valid attributes"
  end

  # Test the liked_by? method
  test "liked_by? returns true if user has liked the post" do
    post = posts(:one) # Assuming you have a fixture for posts
    user = users(:one) # Assuming you have a fixture for users
    # Ensure the user has liked the post in the fixture or create a like
    Like.create(post: post, user: user) unless post.liked_by?(user)

    assert post.liked_by?(user), "Post should be liked by the user"
  end

  test "liked_by? returns false if user has not liked the post" do
    post = posts(:two) # Assuming you have another post fixture
    user = users(:one)
    # Ensure the user has NOT liked this post in the fixture
    assert_not post.liked_by?(user), "Post should not be liked by the user"
  end
end # This 'end' closes the class PostTest
=======
require "test_helper"

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
>>>>>>> 2d32fe77661cbb6d5c2f23a40816540019075e13
