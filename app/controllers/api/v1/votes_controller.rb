class Api::V1::VotesController < ApplicationController
  def create
    @feedback_request = FeedbackRequest.find(params[:feedback_request_id])
    @vote = @feedback_request.votes.build(user: current_user)

    if @vote.save
      render json: @vote, status: :created
    else
      render json: @vote.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @vote = Vote.find(params[:id])
    if @vote.user_id != current_user.id
      render json: { error: "Not authorized" }, status: :unauthorized
    elsif @vote.destroy
      render json: { message: "Vote deleted sucessfully.",
                     data: @vote, status: :ok }
    else
      render json: {
               status: { message: "Vote couldn't be deleted successfully." },
               errors: @vote.errors.full_messages,
               status: :unprocessable_entity,
             }
    end
  end
end
