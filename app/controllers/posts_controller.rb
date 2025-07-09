# app/controllers/posts_controller.rb
class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  # GET /posts
  def index
    @posts = Post.all.order(created_at: :desc)
  end

  # GET /posts/1
  def show
    @comment = Comment.new
  end

  # GET /posts/new
  def new
    @post = current_user.posts.build
    @categories = Category.all # NEW: Load all categories for the form
  end

  # GET /posts/1/edit
  def edit
    @categories = Category.all # NEW: Load all categories for the form
  end

  # POST /posts or /posts.json
  def create
    @post = current_user.posts.build(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy!

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      # IMPORTANT: Add category_ids to permitted parameters
      params.require(:post).permit(:title, :content, :image, category_ids: [])
    end

    def authorize_user!
      unless @post.user_id == current_user.id
        respond_to do |format|
          format.html { redirect_to posts_path, alert: "Not authorized to edit this post.", data: { turbo_frame: "_top" } }
          format.turbo_stream { render turbo_stream: turbo_stream.replace("flash", partial: "layouts/flash", locals: { alert: "Not authorized to edit this post." }) }
        end
      end
    end
end
=======
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
>>>>>>> 2d32fe77661cbb6d5c2f23a40816540019075e13
