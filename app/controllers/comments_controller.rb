class CommentsController < ApplicationController

  def create
    @discussion = Discussion.find_by(id: params[:discussion_id])
    comment_params = params.require(:comment).permit(:body)
    @comment = Comment.new comment_params
    @comment.discussion = @discussion

    if @comment.save
      redirect_to discussion_path(@discussion), notice: "Comment posted to discussion."
    else
      flash[:alert] = "Error saving comment."
      render 'discussion/show'
    end
  end

  def edit
    @comment = Comment.find_by(id: params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    @discussion = @comment.discussion
    comment_params = params.require(:comment).permit(:body)
    if @comment.update comment_params
      redirect_to discussion_path(@discussion), notice: "Comment saved successfully."
    else
      flash[:alert] = "Error saving comment."
      render :edit
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @discussion = @comment.discussion
    if @comment.destroy
      redirect_to discussion_path(@discussion), notice: 'Comment deleted successfully.'
    else
      redirect_to discussion_path(@discussion), alert: 'Unable to delete comment.'
    end
  end
end
