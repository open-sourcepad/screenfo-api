Rails.application.routes.draw do

  resources :auth do
    get :index
    collection do
      post :sign_up
      post :log_in
    end
  end

  resources :third_party_integration do
  end

  resources :messages, only: [:create, :get]

  get "*path" => "application#index"
  root to: "application#index"
end
