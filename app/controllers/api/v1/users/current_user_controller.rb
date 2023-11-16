class Api::V1::Users::CurrentUserController < ApplicationController
  before_action :authenticate_user!
  def index
    render json: {
        status: { code: 200, message: "User profile." },
        data: UserSerializers.new(current_user).serializable_hash,
      }, status: :ok
  end
end
