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
end
