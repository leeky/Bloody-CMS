class EventsController < ApplicationController
  
  before_filter :require_admin, :except => [:index, :show]
  
  # GET /events
  # GET /events.json
  def index
    unless params[:past]
      events = Event.coming_up.by_date
    else
      events = Event.past.by_date
    end
    if admin?
      @events = events.paginate :page => params[:page], :per_page => 5
    else
      @events = eventst.published.paginate :page => params[:page], :per_page => 5
    end
    

    respond_to do |format|
      format.html # index.html.erb
      format.rss
      format.json { render json: @events, :only => [:title, :description] }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    if admin?
      @event = Event.find_by_slug(params[:id]) 
    else
      @event = Event.published.find_by_slug(params[:id]) 
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @event = Event.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/1/edit
   def edit
     @event = Event.find_by_slug(params[:id])
   end

   # POST /events
   # POST /events.json
   def create
     @event = Event.new(params[:event])

     respond_to do |format|
       if @event.save

         @event.update_attribute('published_at', Time.now) if params[:commit] == 'Publish'

         if params[:commit] == 'Publish'
           format.html { redirect_to @event, notice: 'Event was successfully published.' }
         else
           format.html { redirect_to edit_event_path(@event), notice: 'Event was successfully created.' }
         end

         format.json { render json: @event, status: :created, location: @event, :only => [:title, :description] }
       else
         format.html { render action: "new" }
         format.json { render json: @event.errors, status: :unprocessable_entity }
       end
     end
   end

   # PUT /events/1
   # PUT /events/1.json
   def update
     @event = Event.find_by_slug(params[:id])

     respond_to do |format|
       if @event.update_attributes(params[:event])
         @event.update_attribute('published_at', Time.now) if params[:commit] == 'Publish'
         @event.update_attribute('published_at', nil) if params[:commit] == 'Unpublish'

         if params[:commit] == 'Publish'
           format.html { redirect_to @event, notice: 'Event was successfully published.' }
         else
           format.html { redirect_to edit_event_path(@event), notice: 'Event was successfully updated.' }
         end

         format.json { head :ok }
       else
         format.html { render action: "edit" }
         format.json { render json: @event.errors, status: :unprocessable_entity }
       end
     end
   end

   # DELETE /events/1
   # DELETE /events/1.json
   def destroy
     @event = Event.find_by_slug(params[:id])
     @event.destroy

     respond_to do |format|
       format.html { redirect_to events_url }
       format.json { head :ok }
     end
   end
end
