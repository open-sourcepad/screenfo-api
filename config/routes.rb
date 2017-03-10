Rails.application.routes.draw do

  resources :auth do
    get :index
    collection do
      post :sign_up
      post :log_in
    end
  end

  resources :third_party_integration do
    collection do
      get :get_n24_tasks
    end
  end

  resources :messages, only: [:create, :get]

  get "*path" => "application#index"
  root to: "application#index"
end
