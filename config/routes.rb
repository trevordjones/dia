Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'search#index'
  resources :favorites, only: %i(create index destroy)
end
