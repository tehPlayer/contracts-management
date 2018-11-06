Rails.application.routes.draw do
  root to: 'contracts#index'

  scope module: 'api' do
    resources :categories, only: [:index]
  end

  resources :contracts, only: [:index, :new, :create]

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  devise_scope :user do
    get 'signin', to: 'devise/sessions#new'
    post 'signin', to: 'devise/sessions#create'
    get 'signup', to: 'devise/registrations#new'
    post 'signup', to: 'devise/registrations#create'
  end
end
