Rails.application.routes.draw do
  devise_for :users
  root to: "prototypes#index"

  post "users/sign_up" => "devise/registrations#new"

  resources :prototypes do
    resources :comments, only: :create
  end
  resources :users, only: :show
end
