Bloodycms::Application.routes.draw do
  resources :posts, :path => Settings.get("blog:path", "blog") if Settings.get('blog:enabled?')
  resources :pages, :except => :index
  resources :authentications
  resources :admins
  
  match "/admin/options" => "options#index", :as => "options"
  match "/admin/options" => "options#index", :as => "options"
  
  
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
