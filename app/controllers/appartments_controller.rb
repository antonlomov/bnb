class AppartmentsController < ApplicationController
  skip_before_action :authenticate_account!, only: [:index, :show, :home]

  def home
    # we need this empty action for the routes root to know where to go
  end

  def index
    @appartments = Appartment.all
    # Let's DYNAMICALLY build the markers for the view.
    @markers = Gmaps4rails.build_markers(@appartments) do |appartment, marker|
      marker.lat appartment.latitude
      marker.lng appartment.longitude
    end
  end

  def for_owner
    @current_user_id = current_account.user.id
    @appartments = Appartment.find_apps_for_owner(@current_user_id)
    @markers = Gmaps4rails.build_markers(@appartment) do |appartment, marker|
      marker.lat appartment.latitude
      marker.lng appartment.longitude
    end
  end

  def show
    @appartment = Appartment.find(params[:id])
    # from user perspective
    @booking = Booking.new
    @errors = [] # for passing it in the render
    @dates = check_appartment_availability
    # from owner perspective
    @current_user_id = current_account.user.id
    @bookings = @appartment.bookings
    @availability_periods = @appartment.availability_periods
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
      redirect_to new_appartment_availability_period_path(@appartment)
    else
      @property_types = Appartment::PROPERTY_TYPES
      @room_numbers = Appartment::ROOM_NUMBERS
      @capacities = Appartment::CAPACITIES
      render :new
    end
  end

  def edit
    @appartment = Appartment.find(params[:id])
    @property_types = Appartment::PROPERTY_TYPES
    @room_numbers = Appartment::ROOM_NUMBERS
    @capacities = Appartment::CAPACITIES
    @errors = [] # for passing it in the render to form in the view
  end

  def update
    @appartment = Appartment.find(params[:id])
    @appartment.update(appartment_params)
    redirect_to appartment_path(@appartment)
  end

  def destroy
    @appartment = Appartment.find(params[:id])
    @appartment.destroy
    redirect_to for_owner_appartments_path
  end


  protected

  def check_appartment_availability
    @appartment = Appartment.find(params[:id])
    @available_ranges = @appartment.availability_periods
    @booked_ranges = @appartment.bookings
    @available_dates = check_available_ranges(@available_ranges)
    if @available_dates.uniq.nil?
      @available_dates
    else
      @available_dates.uniq!
    end
    @booked_dates = check_bookings_ranges(@booked_ranges)
    if @booked_dates.uniq.nil?
      @booked_dates
    else
      @booked_dates.uniq!
    end
    @bookable_dates = @available_dates - @booked_dates
  end

  def check_available_ranges(ranges)
    available_dates = []
    ranges.map do |range|
      available_dates << (range.start_date..range.end_date).to_a
      available_dates.flatten!
    end
    available_dates


  end

  def check_bookings_ranges(ranges)
    booked_dates = []
    ranges.map do |range|
      booked_dates << (range.start_date..range.end_date).to_a
      booked_dates.flatten!
    end
    booked_dates
  end

  def appartment_params
    params.require(:appartment).permit(:address, :property_type, :nbr_rooms, :capacity, :picture)

  end
end
