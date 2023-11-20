class Api::V1::CommentsController < ApplicationController
  def create
    @feedback_request = FeedbackRequest.find(params[:feedback_request_id])
    @comment = @feedback_request.comments.build(comment_params.merge(user: current_user))

    if @comment.save
      render json: @comment, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :parent_id)
  end
end
