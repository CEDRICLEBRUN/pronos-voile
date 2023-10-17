Rails.application.routes.draw do
  root 'pages#home'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  resources :boats, only: %i[index show]
  resources :bets, only: %i[index new create]
  resources :crews, only: %i[index show new create] do
    resources :admissions, only: %i[create destroy]
  end

  patch "/admissions/:id/reject", to: "admissions#reject", as: "admission_reject"
  patch "/admissions/:id/accept", to: "admissions#accept", as: "admission_accept"
end
