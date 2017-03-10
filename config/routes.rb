Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "*path" => "application#index"
  root to: "application#index"
  resources :auth do
    collection do
      post :sign_up
      post :log_in
    end
  end
  resources :third_party_integration do
  end
end
