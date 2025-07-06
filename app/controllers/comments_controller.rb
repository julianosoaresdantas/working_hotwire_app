class CommentsController < ApplicationController
  before_action :authenticate_user! # Ensure user is logged in to comment
  before_action :set_post # Ensure post is found

  # POST /posts/:post_id/comments
  def create
    @comment = @post.comments.build(comment_params.merge(user: current_user))

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @post, notice: "Comment was successfully created." }
        format.turbo_stream # This will look for create.turbo_stream.erb
      else
        format.html { redirect_to @post, alert: "Could not create comment." }
        format.turbo_stream { render turbo_stream: turbo_stream.replace("flash", partial: "layouts/flash", locals: { alert: "Could not create comment." }) }
      end
    end
  end

  # DELETE /posts/:post_id/comments/:id
  def destroy
    @comment = @post.comments.find(params[:id])

    # Basic authorization: only owner can delete
    if @comment.user == current_user
      @comment.destroy
      respond_to do |format|
        format.html { redirect_to @post, notice: "Comment was successfully destroyed." }
        format.turbo_stream # This will look for destroy.turbo_stream.erb
      end
    else
      respond_to do |format|
        format.html { redirect_to @post, alert: "Not authorized to delete this comment." }
        format.turbo_stream { render turbo_stream: turbo_stream.replace("flash", partial: "layouts/flash", locals: { alert: "Not authorized to delete this comment." }) }
      end
    end
  end

  private
    def set_post
      @post = Post.find(params[:post_id])
    end

    def comment_params
      params.require(:comment).permit(:content)
    end
end
