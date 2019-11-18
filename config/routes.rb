Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api, defaults: {format: :json} do
    resource :cart, only: [:create, :update, :show]
    resource :cost, only: [:show]
    resources :items, only: [:index]
  end
  root to: 'static_pages#root'
end
