# app/controllers/comments_controller.rb
class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post # This line is looking for set_post in THIS controller

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @post, notice: "Comment was successfully created." }
        format.turbo_stream
      else
        format.html { render "posts/show", status: :unprocessable_entity }
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace(
            "new_comment_form",
            partial: "comments/form",
            locals: { post: @post, comment: @comment }
          ),
          status: :unprocessable_entity
        }
      end
    end
  end

  def destroy
    # Assuming you'll have a destroy action for comments eventually
    # You'll need @comment here too.
    @comment = @post.comments.find(params[:id])
    @comment.destroy!
    respond_to do |format|
      format.html { redirect_to @post, notice: "Comment was successfully destroyed." }
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@comment) }
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
