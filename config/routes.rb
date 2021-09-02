Rails.application.routes.draw do
  resources :visitors
  root :to => 'urls#new'
  resources :urls
  get '/:token' => 'urls#search'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
