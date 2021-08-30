Rails.application.routes.draw do
  devise_for :schools
  root to: 'home#index'
  resources :months, only: [:new, :create, :show]
  resources :business_days, only: [:create, :show] do
    resources :business_hours, only: [:index, :new, :create, :edit, :update]
  end
  resources :schools, only: [:show, :edit, :update]
end
