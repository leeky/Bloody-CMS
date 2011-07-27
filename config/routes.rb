Bloodycms::Application.routes.draw do
  resources :posts, :path => Option.get("blog:path") if Option.get('blog:enabled')
  resources :pages, :except => :index
  resources :authentications
  
  #authentication
  match '/auth/:provider/callback' => 'authentications#create'
  match '/auth/failure' => redirect("/")
  match '/login' => redirect('/auth/twitter'), :as => "login"
  match '/logout' => "authentications#destroy", :as => "logout"
  
  
  #pages to root domain
  match "/:id" => "pages#show", :as => "root_page", :method => :get

  #the root url can be configured
  root :to => Option.get('root') if Option.get("installed?")
  root :to => 'installer#index' unless Option.get("installed?")
  # root :to => 'posts#index' unless CONFIG['pages']['root_page'] && CONFIG['pages']['enabled']
  # root :to => 'pages#show', :id => CONFIG['pages']['root_page'] if CONFIG['pages']['root_page'] && CONFIG['pages']['enabled']
end
