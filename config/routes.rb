Rails.application.routes.draw do
  get 'info/about'
  get 'welcome/home'
  get 'welcome/registered', to: 'welcome#registered'
  get 'welcome/loggedin', to: 'welcome#loggedin'
  get 'createmods', to: 'mods#new'
  get 'mods', to: 'mods#index'

  get 'signup', to: 'users#new'
  post 'users', to: 'users#create'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'search', to: 'mods#search'


  get 'users/:id/complete', to: 'users#complete' #check why need this line
  resources :users,expect:[:new] 
  resources :mods

  root 'welcome#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
