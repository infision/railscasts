Railscasts::Application.routes.draw do
  get "admin/add_moderator"

  root :to => "episodes#index"

	get   '/login', :to => 'users#new', :as => :login
	match '/auth/:provider/callback', :to => 'users#create'
	match '/auth/failure', :to => 'users#failure'
	match '/admin/add', :to => 'admin#add_moderator'
	match '/user/:id/make_moderator' => 'users#make_moderator', :as => :make_moderator
	match '/user/:id/remove_moderator' => 'users#remove_moderator', :as => :remove_moderator

  #match "/auth/:provider/callback", :to => "users#create"
  match "about" => "info#about", :as => "about"
  match "give_back" => "info#give_back", :as => "give_back"
  match "moderators" => "info#moderators", :as => "moderators"
  #match "login", :to => "users#new", :as => "login" #default was users"login
	match "auth/failure", :to => "users#failure" #
  match "logout" => "users#logout", :as => "logout"
  match "feedback" => "feedback_messages#new", :as => "feedback"
  match "episodes/archive" => redirect("/?view=list")
  match 'unsubscribe/:token' => 'users#unsubscribe', :as => "unsubscribe"
  post "versions/:id/revert" => "versions#revert", :as => "revert_version"

  resources :users do
    member { put :ban }
  end
  resources :comments
  resources :episodes
  resources :feedback_messages

  match "tags/:id" => redirect("/?tag_id=%{id}")
end
