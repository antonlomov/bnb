class AppartmentsController < ApplicationController
  skip_before_action :authenticate_account!, only: [:index, :show, :home]

  def home
  end

  def show
    @appartment = Appartment.find(params[:id])
  end

  def new
    @appartment = Appartment.new
    @property_types = Appartment::PROPERTY_TYPES
    @room_numbers = Appartment::ROOM_NUMBERS
    @capacities = Appartment::CAPACITIES
  end

  def create
    @appartment = Appartment.new(appartment_params)
    if @appartment.save
      redirect_to appartments_path(@appartment)
    else
      render :new
    end
  end

  def index
    @appartments = Appartment.all
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
    params.require(:appartment).permit(:address, :property_type, :nbr_rooms, :capacity)
  end
end
