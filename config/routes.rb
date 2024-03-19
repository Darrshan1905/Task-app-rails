Rails.application.routes.draw do
  devise_for :users
  get 'home/index'

  resources :projects do
    resources :tasks, only: [:new, :create, :edit, :update, :destroy] do
      resources :comments
    end
  end

  root 'home#index'

  match '*path', to: 'home#index', via: :all
end
