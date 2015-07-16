Rails.application.routes.draw do

  # Stunning how concise but powerful this can get, no?
  resources :users
  resources :questions
  resources :answers
  resources :comments
  resources :tags
  resources :votes

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create', as: 'create_session'
  delete 'logout' => 'sessions#destroy'

  root 'welcome#index'

end
