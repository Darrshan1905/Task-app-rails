Rails.application.routes.draw do
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'
  get 'profile', to: 'users#edit'
  patch 'profile', to: 'users#update'
  delete 'profile', to: 'users#destroy'

  get 'home/index'

  get 'projects/search'

  get 'projects/task_search'

  resources :projects do
    resources :tasks, only: [:new, :create, :edit, :update, :destroy] do
      resources :comments
    end
  end

  root 'home#index'

  match '*path', to: 'home#index', via: :all
end
