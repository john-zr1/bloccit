class CommentsController < ApplicationController

 before_action :require_sign_in

 before_action :require_sign_in

 def create
# #11
   if params[:post_id].present?
     @commentable = Post.find(params[:post_id])
   else
     @commentable = Topic.find(params[:topic_id])
   end

   comment = @commentable.comments.new(comment_params)
   comment.user = current_user

   if comment.save
     flash[:notice] = "Comment saved successfully."
   else
     flash[:alert] = "Comment failed to save."
   end

   if params[:post_id].present?
     redirect_to [@commentable.topic, @commentable]
   else
     redirect_to @commentable
   end
 end

  def destroy
    
    @commentable = Post.find(params[:post_id])
    comment = @commentable.comments.find(params[:id])

    if comment.destroy
      flash[:notice] = "Comment was deleted successfully."
      redirect_to [@commentable.topic, @commentable]
    else
      flash[:alert] = "Comment couldn't be deleted. Try again."
      redirect_to @commentable
    end
  end

 private

# #14
 def comment_params
   params.require(:comment).permit(:body)
 end

# #16
  def authorize_user
    comment = Comment.find(params[:id])
    unless current_user == comment.user || current_user.admin?
      flash[:alert] = "You do not have permission to delete a comment."
      redirect_to [comment.post.topic, comment.post]
    end
  end
end
