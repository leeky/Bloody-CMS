class PagesController < ApplicationController
  
  before_filter :require_admin, :except => :show


  # GET /pages/1
  # GET /pages/1.json
  def show
    if admin?
      @page = Page.find_by_slug(params[:id]) 
    else
      @page = Page.published.find_by_slug(params[:id]) 
    end
   
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @page }
    end
  end

  # GET /pages/new
  # GET /pages/new.json
  def new
    @page = Page.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @page }
    end
  end

  # GET /pages/1/edit
  def edit
    @page = Page.find_by_slug(params[:id])
  end

  # POST /pages
  # POST /pages.json
  def create
    @page = Page.new(params[:page])

    respond_to do |format|
      if @page.save
        @page.update_attribute('published_at', Time.now) if params[:commit] == 'Publish'
        
        if params[:commit] == 'Publish'
          format.html { redirect_to root_page_path(@page), notice: 'Page was successfully published.' }
        else
          format.html { redirect_to edit_page_path(@post), notice: 'Page was successfully created.' }
        end
        format.json { render json: @page, status: :created, location: @page }
      else
        format.html { render action: "new" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pages/1
  # PUT /pages/1.json
  def update
    @page = Page.find_by_slug(params[:id])

    respond_to do |format|
      if @page.update_attributes(params[:page])
        @page.update_attribute('published_at', Time.now) if params[:commit] == 'Publish'
        @page.update_attribute('published_at', nil) if params[:commit] == 'Unpublish'
        
        if params[:commit] == 'Publish'
          format.html { redirect_to root_page_path(@page), notice: 'Page was successfully published.' }
        else
          format.html { redirect_to edit_page_path(@page), notice: 'Page was successfully updated.' }
        end
        
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    @page = Page.find_by_slug(params[:id])
    @page.destroy

    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :ok }
    end
  end
end
