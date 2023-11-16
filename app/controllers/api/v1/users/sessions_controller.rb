# frozen_string_literal: true

class Api::V1::Users::SessionsController < Devise::SessionsController
  include RackSessionFix
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    render json: {
             status: { code: 200, message: "Logged in sucessfully." },
             data: UserSerializers.new(current_user).serializable_hash,
           }, status: :ok
  end

  def respond_to_on_destroy
    authorization_header = request.headers["Authorization"]

    if authorization_header.present?
      jwt_token = authorization_header.split(" ")[1]
      jwt_payload = JWT.decode(jwt_token, Rails.application.credentials.fetch(:secret_key_base)).first
      current_user = User.find(jwt_payload["sub"])

      if current_user
        render json: {
                 status: 200,
                 message: "logged out successfully",
               }, status: :ok
      else
        render json: {
                 status: 401,
                 message: "Couldn't find an active session.",
               }, status: :unauthorized
      end
    else
      render json: {
               status: 401,
               message: "Authorization header missing.",
             }, status: :unauthorized
    end
  end
end
