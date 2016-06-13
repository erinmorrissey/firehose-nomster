class PlacesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @places = Place.all.order(:id).paginate(:page => params[:page], :per_page => 1)
  end
  
  def new
    @place = Place.new
  end

  def create
    @place = current_user.places.create(place_params)
    if @place.valid?
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @place = Place.find(params[:id])
  end

  def edit
    @place = Place.find(params[:id])

    if @place.user != current_user
      return render text: 'Not Allowed', status: :forbidden
    end
  end

  # gets executed when user presses the button on the Edit Place form
  # the RETURN in the if statement prevents the rest of the code from
  #   running in the event that the wrong user triggered an update
  def update
    @place = Place.find(params[:id])

    if @place.user != current_user
      return render text: 'Not Allowed', status: :forbidden
    end

    @place.update_attributes(place_params)
    if @place.valid?
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @place = Place.find(params[:id])
    if @place.user != current_user
      return render text: 'Not Allowed', status: :forbidden
    end

    @place.destroy
    redirect_to root_path
  end

  private

  def place_params
    params.require(:place).permit(:name, :description, :address)
  end

end