Rails.application.routes.draw do
  devise_for :users
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      
    end
  end
end
