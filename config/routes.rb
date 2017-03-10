Rails.application.routes.draw do

  resources :auth do
    get :index
    collection do
      post :sign_up
      post :log_in
      delete :log_out

    end
  end

  resources :third_party_integration do
    collection do
      get :get_n24_tasks
    end
  end

  resources :messages, only: [:create, :index] do
    post :broadcasted
  end

  resources :users do
    collection do
      get :messages
    end
  end

  get "*path" => "application#index"
  root to: "application#index"
end
