class AppartmentsController < ApplicationController
  skip_before_action :authenticate_account!, only: [:index, :show, :home]
  #   scope :address, -> (address) { where address: address }
  # scope :property_type, -> (property_type) { where property_type: property_type }
  # scope :nbr_rooms, -> (nbr_rooms) { where nbr_rooms: nbr_rooms }
  # scope :capacity, -> (capacity) { where capacity: capacity }

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
      redirect_to appartment_path(@appartment)
    else
      @property_types = Appartment::PROPERTY_TYPES
      @room_numbers = Appartment::ROOM_NUMBERS
      @capacities = Appartment::CAPACITIES
      render :new
    end
  end

  def index



    @filter = Appartment.new(params[:filter])

    # p 'printing the parameters'
    # p params[:appartment][:address]

    if params[:appartment].nil?
    @appartments = Appartment.all
  else
  # p 'printing the params'
    # p params[:appartment][:capacity]
    @appartments = Appartment.all
    @appartments = @appartments.where(address: params[:appartment][:address]) if params[:appartment][:address].present?
    @appartments = @appartments.where(property_type: params[:appartment][:property_type]) if params[:appartment][:property_type].present?
    @appartments = @appartments.where(nbr_rooms: params[:appartment][:nbr_rooms]) if params[:appartment][:nbr_rooms].present?
    p "print appt"
    p @appartments
    @appartments = @appartments.where(capacity: params[:appartment][:capacity]) if params[:appartment][:capacity].present?
  end
    # @appartments = Appartment.all


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

  def filtering_params(params)
    params.slice(:address, :property_type, :nbr_rooms, :capacity, :picture)

  end
end
