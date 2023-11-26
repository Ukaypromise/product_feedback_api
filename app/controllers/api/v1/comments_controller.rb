class Api::V1::CommentsController < ApplicationController
  def index
    @feedback_request = FeedbackRequest.find(params[:feedback_request_id])
    @comments = @feedback_request.comments
    render json: {
             data: @comments,
           }
  end

  def create
    @feedback_request = FeedbackRequest.find(params[:feedback_request_id])
    @comment = @feedback_request.comments.build(comment_params.merge(user: current_user))

    if @comment.save
      render json: {
               message: "Comment created sucessfully.",
               data: @comment,
               status: :created,
             }
    else
      render json: {
               message: "Comment couldn't be created successfully.",
               data: @comment.errors,
               status: :unprocessable_entity,
             }
    end
  end

  def update
    @comment = Comment.find(params[:id])

    if @comment.user_id != current_user.id
      render json: { error: "Not authorized" }, status: :unauthorized
    elsif @comment.update(comment_params)
      render json: { message: "Comment updated sucessfully.",
                     data: @comment, status: :ok }
    else
      render json: {
               status: { message: "Comment couldn't be updated successfully." },
               errors: @comment.errors.full_messages,
               status: :unprocessable_entity,
             }
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.user_id != current_user.id
      render json: { error: "Not authorized" }, status: :unauthorized
    elsif @comment.destroy
      render json: { message: "Comment deleted sucessfully.",
                     data: @comment, status: :ok }
    else
      render json: {
               status: { message: "Comment couldn't be deleted successfully." },
               errors: @comment.errors.full_messages,
               status: :unprocessable_entity,
             }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :parent_id)
  end
end
