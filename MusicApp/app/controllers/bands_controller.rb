class BandsController < ApplicationController

  #3
  def index
    @bands = Band.all
    # generate an instance of all bands
    render :index
    # list of all the bands in our table
  end

  #2
  def create
    # submits new band to be added to database
    # redirect to index page

    @band = current_user.bands.new(band_params)

    if @band.save
      redirect_to bands_url
    else
      flash.now[:errors] = @band.errors.full_messages
      render :new
    end
  end

  #1
  def new
    @band = Band.new
    render :new
    # submission form for new band
  end

  def edit
    @cat = current_user.bands.find_by(params[:id])
    render :edit
    # form page to edit information
  end

  def show
    @band = Band.find(params[:id])
    render :show
    # band's profile page
  end

  def update
    # updates band info in database
    #redirect to band's own profile page
  end

  def destroy
    # delete band from database
    # redirect to index so users can see their band has been deleted
  end

  private
  def band_params
    params.require(:band).permit(:name)
  end

end
