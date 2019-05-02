Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show]
  resources :bands, only: [:new, :create, :edit, :show, :update, :destroy, :index]
end



