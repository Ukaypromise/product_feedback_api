# frozen_string_literal: true

class Api::V1::Users::RegistrationsController < Devise::RegistrationsController
  include RackSessionFix
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    if resource.persisted?
      render json: {
        status: { code: 200, message: "Signed up sucessfully." },
        data: UserSerializers.new(resource).serializable_hash,
      }, status: :ok
    else
      render json: {
               status: { message: "User couldn't be created successfully.",
                         errors: resource.errors.full_messages.to_sentence },
               status: :unprocessable_entity,
             }
    end
  end
end
