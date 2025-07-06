class LikesController < ApplicationController
  before_action :authenticate_user! # Ensure user is logged in to like/unlike

  # POST /posts/:post_id/likes
  def create
    @post = Post.find(params[:post_id])
    # Prevent user from liking the same post multiple times
    @like = @post.likes.find_or_initialize_by(user: current_user)

    respond_to do |format|
      if @like.new_record? && @like.save # Only save if it's a new like
        format.html { redirect_to @post, notice: "Post liked!" }
        format.turbo_stream # This will look for create.turbo_stream.erb
      else
        # If it's not a new record (already liked) or save fails
        format.html { redirect_to @post, alert: "Could not like post (perhaps already liked)." }
        format.turbo_stream { render turbo_stream: turbo_stream.replace("flash", partial: "layouts/flash", locals: { alert: "Could not like post (perhaps already liked)." }) }
      end
    end
  end

  # DELETE /posts/:post_id/likes/:id
  def destroy
    @post = Post.find(params[:post_id])
    @like = @post.likes.find(params[:id]) # Find the specific like to destroy

    # Ensure only the owner of the like can destroy it (basic authorization)
    if @like.user == current_user
      @like.destroy
      respond_to do |format|
        format.html { redirect_to @post, notice: "Post unliked." }
        format.turbo_stream # This will look for destroy.turbo_stream.erb
      end
    else
      respond_to do |format|
        format.html { redirect_to @post, alert: "Not authorized to unlike this post." }
        format.turbo_stream { render turbo_stream: turbo_stream.replace("flash", partial: "layouts/flash", locals: { alert: "Not authorized to unlike this post." }) }
      end
    end
  end
end
