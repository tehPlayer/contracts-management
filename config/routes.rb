Rails.application.routes.draw do
  root to: 'contracts#index'

  scope module: 'api' do
    resources :categories, only: [:index]
  end

  resources :contracts, except: [:show, :destroy, :edit] do
    collection do
      get 'edit/:id' => 'contracts#edit', as: :edit
    end
  end

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
