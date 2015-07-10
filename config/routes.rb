Rails.application.routes.draw do

  resources :users
  resources :questions
  resources :answers
  resources :comments

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create', as: 'create_session'
  delete 'logout' => 'sessions#destroy'

  root 'welcome#index'

end
