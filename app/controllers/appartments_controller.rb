class AppartmentsController < ApplicationController
  skip_before_action :authenticate_account!, only: [:index, :show, :home]

  def home
  end

  def show
    @appartment = Appartment.find(params[:id])
    @booking = Booking.new

    # Let's DYNAMICALLY build the markers for the view.
    @markers = Gmaps4rails.build_markers(@appartment) do |appartment, marker|
      marker.lat appartment.latitude
      marker.lng appartment.longitude
    end
  end

  def new
    @appartment = Appartment.new
    # to pass those constants from the model to the view via the controller
    @property_types = Appartment::PROPERTY_TYPES
    @room_numbers = Appartment::ROOM_NUMBERS
    @capacities = Appartment::CAPACITIES
  end

  def create
    @appartment = Appartment.new(appartment_params)
    # linking the new appartment to the user on the current session (from current_account)
    @appartment.owner_id = current_account.user_id
    if @appartment.save
      redirect_to new_appartment_availability_period(@appartment)
    else
      @property_types = Appartment::PROPERTY_TYPES
      @room_numbers = Appartment::ROOM_NUMBERS
      @capacities = Appartment::CAPACITIES
      render :new
    end
  end

  def index
    @appartments = Appartment.all
    # Let's DYNAMICALLY build the markers for the view.
    @markers = Gmaps4rails.build_markers(@appartments) do |appartment, marker|
      marker.lat appartment.latitude
      marker.lng appartment.longitude
    end
  end

  def edit
    @appartment = Appartment.find(params[:id])
  end

  def update
    @appartment = Appartment.find(params[:id])
    @appartment.update(appartment_params)
    redirect_to appartment_path(@appartment)
  end

  def destroy
    @appartment = Appartment.find(params[:index])
    @appartment.destroy
    redirect_to appartments_path
  end

  protected

  def appartment_params
    params.require(:appartment).permit(:address, :property_type, :nbr_rooms, :capacity, :picture)

  end
end
