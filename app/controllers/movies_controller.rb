class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    #sort_by = (params[:order] == 'starts_at' ? 'starts_at desc' : 'name')
   # sort_by = 'release_date desc'
   #@events = Event.find(:all, :order => sort_by)
   # respond_to do |format|
       # format.html # index.html.erb
       # format.xml { render :xml => @events }
    # end
   # @movies = Movie.all
  # @movies = Movie.find(:all, :order => sort_by)
  @all_ratings = Movie.get_ratings_list
    session[:params] = params
    sort_id = params[:sort_id]
    ratings = params[:ratings]
      
    if ratings == nil
      @movies = Movie.find(:all, :order => sort_id)
    else
      @movies = Movie.find(:all, :order => sort_id, :conditions => {:rating => ratings.keys}) 
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
