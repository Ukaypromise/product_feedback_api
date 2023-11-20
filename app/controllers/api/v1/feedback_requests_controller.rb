class Api::V1::FeedbackRequestsController < ApplicationController
  def create
    @product = Product.find(params[:product_id])
    @feedback_request = @product.feedback_requests.build(feedback_request_params.merge(user: current_user))

    if @feedback_request.save
      render json: @feedback_request, status: :created
    else
      render json: @feedback_request.errors, status: :unprocessable_entity
    end
  end

  private

  def feedback_request_params
    params.require(:feedback_request).permit(:title, :description)
  end
end
