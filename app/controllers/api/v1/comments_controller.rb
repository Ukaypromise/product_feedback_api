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
      render json: @comment, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def update
    @comment = Comment.find(params[:id])

    if @comment.update(comment_params)
      render json: @comment, status: :ok
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :parent_id)
  end
end
