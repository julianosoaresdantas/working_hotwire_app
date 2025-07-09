# app/controllers/posts_controller.rb
class PostsController < ApplicationController
  # Ensure these are only present once, at the top of the class
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  # If you had a temporary CSRF bypass, it would typically go here, e.g.:
  # skip_before_action :verify_authenticity_token, only: [:create]


  # --- Your controller actions (index, show, new, create, edit, update, destroy) ---
  def index
    @posts = Post.all
  end

  def show
    # @post is set by set_post
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params) # Assuming posts belong_to user
    if @post.save
      redirect_to @post, notice: "Post was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # @post is set by set_post
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: "Post was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_url, notice: "Post was successfully destroyed."
  end


  private # Private methods for the controller

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :category_id) # Adjust permitted params as per your Post model
  end

  def authorize_user!
    unless @post.user == current_user # Assuming a 'user' association
      redirect_to posts_path, alert: "You are not authorized to perform this action."
    end
  end

end # <--- This 'end' should be the very last line, closing the PostsController class
