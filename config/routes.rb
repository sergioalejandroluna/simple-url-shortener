Rails.application.routes.draw do
  resources :visitors
  root :to => 'urls#new'
  resources :urls
  get '/:token' => 'urls#search'
end
