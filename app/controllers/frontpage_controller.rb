class FrontpageController < ApplicationController
  def index
    root_options = Settings.get('root').split("#")
    if root_options[0] == 'pages'
      @page = Page.find_by_slug(root_options[1])
      render "pages/show"
    end
  end
end
