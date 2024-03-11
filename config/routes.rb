Rails.application.routes.draw do
  get 'home/index'

  resources :projects do
    resources :tasks do
      resources :comments
    end
  end

  root 'home#index'
end
