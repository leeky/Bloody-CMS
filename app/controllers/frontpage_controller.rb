class FrontpageController < ApplicationController
  def index
    root_options = Settings.get('root_url').split("#")
    if root_options[0] == 'pages'
      @page = Page.published.find_by_slug(root_options[1])
      return render "pages/show" if @page
    end
    
    if admin?
      redirect_to options_path, :alert => "Oops, your home page is missing. Please set a new homepage"
    end
  end
end
