Rails.application.routes.draw do
  devise_for :users, path: "api/v1/users", path_names: {
                       registration: "sign_up",
                     },
                     controllers: {
                       registrations: "api/v1/users/registrations",
                       sessions: "api/v1/users/sessions",
                     }

  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      namespace :users do
        get '/user_details' => 'current_user#index'
      end
      resources :companies do
        resources :products do
          resources :feedback_requests, only: [:index, :show, :create, :update, :destroy] do
            resources :comments, only: [:index, :create, :update, :destroy]
            resources :votes, only: [:create, :destroy]
          end
        end
      end
      get '/products' => 'products#get_all_products'
    end
  end
end
