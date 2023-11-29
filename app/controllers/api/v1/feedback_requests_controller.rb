class Api::V1::FeedbackRequestsController < ApplicationController
  before_action :set_product, only: [:index, :create]

  def index
    @feedback_requests = @product.feedback_requests.recent.page(params[:page]).per(params[:per_page])
    render json: {
             data: @feedback_requests,
           }
  end

  def show
    @feedback_request = FeedbackRequest.find(params[:id])
    render json: {
      data: @feedback_request,
    }
  end

  def create
    @feedback_request = @product.feedback_requests.build(feedback_request_params.merge(user: current_user))

    if @feedback_request.save
      render json: {
               message: "Feedback created sucessfully.",
               data: @feedback_request,
               status: :created,
             }
    else
      render json: {
               message: "Feedback couldn't be created successfully.",
               data: @feedback_request.errors,
               status: :unprocessable_entity,
             }
    end
  end

  def update
    @feedback_request = FeedbackRequest.find(params[:id])

    if @feedback_request.user_id != current_user.id
      render json: { error: "Not authorized" }, status: :unauthorized
    elsif @feedback_request.update(feedback_request_params)
      render json: { message: "Feedback updated sucessfully.",
                     data: @feedback_request, status: :ok }
    else
      render json: {
               status: { message: "Feedback couldn't be updated successfully." },
               errors: @feedback_request.errors.full_messages,
               status: :unprocessable_entity,
             }
    end
  end

  def destroy
    @feedback_request = FeedbackRequest.find(params[:id])
    if @feedback_request.user_id != current_user.id
      render json: { error: "Not authorized" }, status: :unauthorized
    elsif @feedback_request.destroy
      render json: { message: "Feedback deleted sucessfully.",
                     data: @feedback_request, status: :ok }
    else
      render json: {
               status: { message: "Feedback couldn't be deleted successfully." },
               errors: @feedback_request.errors.full_messages,
               status: :unprocessable_entity,
             }
    end
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def feedback_request_params
    params.require(:feedback_request).permit(:title, :description)
  end
end
