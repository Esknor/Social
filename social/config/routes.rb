Rails.application.routes.draw do
  resources :advertisings
  resources :posts
  resources :groups
  resources :userinfos
  resources :users
  resources :rooms
  resources :messages, only:[:create]
  resources :sessions, only:[:new, :create, :destroy]
  match '/signup', to: "users#new",             via: 'get'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'
  match '/party/:id', :to => "rooms#party", :as => :party, :via => :get

  get 'groups/:id/members' => 'groups#members'
  patch 'groups/:id/edit' => 'groups#update_perm'
  patch 'groups/:id/update_privacy' => 'groups#update_privacy'  

  root 'welcome#index'

end
