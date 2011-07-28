Bloodycms::Application.routes.draw do
  resources :posts, :path => Option.get("blog:path") if Option.get('blog:enabled')
  resources :pages, :except => :index
  resources :authentications
  
  match "/admin/options" => "options#index", :as => "options"
  
  #authentication
  match '/auth/:provider/callback' => 'authentications#create'
  match '/auth/failure' => redirect("/")
  match '/login' => redirect('/auth/twitter'), :as => "login"
  match '/logout' => "authentications#destroy", :as => "logout"
  
  
  #pages to root domain
  match "/:id" => "pages#show", :as => "root_page", :method => :get

  #the root url can be configured
  Option.set('root', "posts#index")
  if Option.get("installed?") && !Option.get('root').blank?
    root :to => Option.get('root')
  else 
    root :to => 'options#index'
  end
  
  # root :to => 'posts#index' unless CONFIG['pages']['root_page'] && CONFIG['pages']['enabled']
  # root :to => 'pages#show', :id => CONFIG['pages']['root_page'] if CONFIG['pages']['root_page'] && CONFIG['pages']['enabled']
end
