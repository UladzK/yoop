class ArtistsController < ApplicationController
  before_filter :login_required, :except => [:index, :show]
  helper_method :sort_column, :sort_direction

  def index
    @artists = Artist.search(params[:search])
    if params[:search] == nil
      @artists = Artist.order(sort_column + " " + sort_direction)
    end
  end

  def show
    @artist = Artist.find(params[:id])
  end

  def new
    @artist = Artist.new
  end

  def create
    @artist = Artist.new(params[:artist])
    if @artist.save
      redirect_to @artist, :notice => "Successfully created artist."
    else
      render :action => 'new'
    end
  end

  def edit
    @artist = Artist.find(params[:id])
  end

  def update
    @artist = Artist.find(params[:id])
    if @artist.update_attributes(params[:artist])
      redirect_to @artist, :notice  => "Successfully updated artist."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @artist = Artist.find(params[:id])
    @artist.destroy
    redirect_to artists_url, :notice => "Successfully deleted artist."
  end

  private
  
  def sort_column
    Artist.column_names.include?( params[:sort] ) ? params[:sort] : "name"
    # params[:sort] || "name"
  end
  
  def sort_direction
    %w[asc desc].include?( params[:direction] ) ? params[:direction] : "asc"
  end 

end
