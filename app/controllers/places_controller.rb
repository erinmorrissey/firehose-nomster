class PlacesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]


  # very simple code to grab all places so they can be
  # displayed in the Index view (index.html.erb)
  def index
    @places = Place.all.order(:id).paginate(:page => params[:page], :per_page => 4)
  end


  # very simple code to create an empty Place and send the user
  # to the New view for it (new.html.erb), which will have a
  # form for creating the Place
  def new
    @place = Place.new
  end


  # code to create a new Place based on the parameters that
  # were submitted with the form (and are now available in the
  # params hash)
  def create
    @place = current_user.places.create(place_params)
    if @place.valid?
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end


  # very simple code to grab the proper Place so it can be
  # displayed in the Show view (show.html.erb)
  def show
    @place = Place.find(params[:id])
    @comment = Comment.new
    @photo = Photo.new
  end


  # very simple code to find the specific Place we want and send the
  # user to the Edit view for it(edit.html.erb), which has a
  # form for editing the Place
  def edit
    @place = Place.find(params[:id])

    if @place.user != current_user
      return render text: 'Not Allowed', status: :forbidden
    end
  end


  # gets executed when user presses the button on the Edit Place form
  # the RETURN in the if statement prevents the rest of the code from
  #   running in the event that the wrong user triggered an update

  # code to figure out which Place we're trying to update, then
  # actually update the attributes of that Place. Once that's
  # done, redirect us to somewhere like the Show page for that Place
  def update
    @place = Place.find(params[:id])

    if @place.user != current_user
      return render text: 'Not Allowed', status: :forbidden
    end

    @place.update_attributes(place_params)
    if @place.valid?
      redirect_to place_path(@place)
      # redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end


  # very simple code to find the Place we're referring to and
  # destroy it. Once that's done, redirect us to somewhere fun.
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