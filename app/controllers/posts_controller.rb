class PostsController < ApplicationController
  
  before_filter :require_admin, :except => [:index, :show]
  
  # GET /posts
  # GET /posts.json
  def index
    if admin?
      @posts = Post.descending_date.paginate :page => params[:page], :per_page => 5
    else
      @posts = Post.published.descending_date.paginate :page => params[:page], :per_page => 5
    end
    

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts, :only => [:title, :content] }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    if admin?
      @post = Post.find_by_slug(params[:id]) 
    else
      @post = Post.published.find_by_slug(params[:id]) 
    end
   
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post, :only => [:title, :content] }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post, :only => [:title, :content] }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find_by_slug(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(params[:post])

    respond_to do |format|
      if @post.save
        
        @post.update_attribute('published_at', Time.now) if params[:commit] == 'Publish'
        
        if params[:commit] == 'Publish'
          format.html { redirect_to @post, notice: 'Post was successfully published.' }
        else
          format.html { redirect_to edit_post_path(@post), notice: 'Post was successfully created.' }
        end
        
        format.json { render json: @post, status: :created, location: @post, :only => [:title, :content] }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find_by_slug(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        @post.update_attribute('published_at', Time.now) if params[:commit] == 'Publish'
        @post.update_attribute('published_at', nil) if params[:commit] == 'Unpublish'
        
        if params[:commit] == 'Publish'
          format.html { redirect_to @post, notice: 'Post was successfully published.' }
        else
          format.html { redirect_to edit_post_path(@post), notice: 'Post was successfully updated.' }
        end
        
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find_by_slug(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :ok }
    end
  end
end
