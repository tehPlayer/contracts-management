Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get 'signin', to: 'devise/sessions#new'
    post 'signin', to: 'devise/sessions#create'
    get 'signup', to: 'devise/registrations#new'
  end
  root to: 'main#index'

end
