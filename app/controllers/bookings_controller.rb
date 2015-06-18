class BookingsController < ApplicationController
  def index
  end

  def create
    parsed_start_date = Date.strptime(booking_params[:start_date], "%m/%d/%Y")
    parsed_end_date = Date.strptime(booking_params[:end_date], "%m/%d/%Y")
    pars = {start_date: parsed_start_date, end_date: parsed_end_date, appartment_id: params[:appartment_id]}
    @booking = Booking.new(pars)
    # linking the new booking to the user on the current session (from current_account)
    @booking.user_id = current_account.user_id
    if @booking.save
      redirect_to booking_path(@booking)
    else
      @appartment = Appartment.find(params[:appartment_id])
      @errors = @booking.errors.messages
      # those 2 instance variables are passed with the render
      render 'appartments/show'
    end
  end

  def show
    @booking = Booking.find(params[:id])
    @appartment = @booking.appartment
    # Let's DYNAMICALLY build the markers for the view.
    @markers = Gmaps4rails.build_markers(@appartment) do |appartment, marker|
      marker.lat appartment.latitude
      marker.lng appartment.longitude
    end
  end

  def destroy
  end

  protected
  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end

end
