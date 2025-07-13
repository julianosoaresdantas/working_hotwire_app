# app/controllers/posts_controller.rb

# ... (your existing code above) ...

private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
    # Add a debugging line here to inspect @post
    # Rails.logger.debug "Post found: #{@post.inspect}"
    # binding.pry # Or byebug, to pause execution and inspect in console
  rescue ActiveRecord::RecordNotFound # Good practice to rescue this
    redirect_to posts_path, alert: "Post not found."
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:title, :body, :user_id) # Ensure all your post attributes are listed here
  end

  def authorize_user!
    unless current_user == @post.user
      redirect_to posts_path, alert: "You are not authorized to perform this action."
    end
  end
