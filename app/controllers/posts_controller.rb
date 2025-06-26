class PostsController < ApplicationController
  # TEMPORARY FIX: Bypasses CSRF token verification for create action due to Cloud Shell proxy issues.
  # This should be re-evaluated for production deployment for security reasons.
  skip_before_action :verify_authenticity_token, only: [:create, :update, :destroy] # UPDATED LINE
  # Set the @post instance variable before these actions to avoid repetition
  before_action :set_post, only: %i[ show edit update destroy ]

  def index
    @posts = Post.all
  end

  def show
    # @post is already set by the before_action :set_post
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params) # Assign allowed parameters

    if @post.save
      redirect_to posts_path, notice: "Post was successfully created." # Redirects to index if save is successful
    else
      # If save fails (e.g., due to validations), re-render the 'new' template
      # and include the unprocessable_entity status to show errors
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # @post is already set by the before_action :set_post
  end

  def update
    if @post.update(post_params) # Update the post with allowed parameters
      redirect_to @post, notice: "Post was successfully updated." # Redirects to the show page
    else
      # If update fails, re-render the 'edit' template and include errors
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy # Delete the post from the database
    redirect_to posts_path, notice: "Post was successfully destroyed." # Redirects to the index page
  end

  private # Private methods are used internally by the controller

  # Finds a Post by its ID and sets it to @post for use in other actions
  def set_post
    @post = Post.find(params[:id])
  end

  # Strong parameters: Defines which attributes are allowed to be mass-assigned from the form
  def post_params
    params.require(:post).permit(:title, :content)
  end
end