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
