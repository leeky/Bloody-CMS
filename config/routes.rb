Bloodycms::Application.routes.draw do
  resources :sponsors, :path => Settings.get("sponsors:path", "sponsors") if Settings.get('sponsors:enabled?')
  match "/sponsors/image/:size/:id.png" => "sponsors#image" if Settings.get('sponsors:enabled?')
  resources :events,  :path => Settings.get("events:path", "events") if Settings.get('events:enabled?')
  resources :posts, :path => Settings.get("blog:path", "blog") if Settings.get('blog:enabled?')
  resources :pages, :except => :index
  resources :authentications
  resources :admins
  
  match "/options" => "options#index", :as => "options"  
  
  #authentication
  match '/auth/:provider/callback' => 'authentications#create'
  match '/auth/twitter/setup', :to => 'authentications#setup'
  match '/auth/failure' => redirect("/")
  match '/login' => redirect('/auth/twitter'), :as => "login"
  match '/logout' => "authentications#destroy", :as => "logout"
  
  
  #pages to root domain
  match "/:id" => "pages#show", :as => "root_page", :method => :get

  #the root url can be configured
  root :to => 'frontpage#index'
end
