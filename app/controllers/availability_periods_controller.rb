class AvailabilityPeriodsController < ApplicationController

  def new
    @availability_period = AvailabilityPeriod.new
    @appartment = Appartment.find(params[:appartment_id])
  end

  def create
    pars = availability_period_params.merge({appartment_id: params[:appartment_id]})
    @availability_period = AvailabilityPeriod.new(pars)
    @appartment = Appartment.find(params[:appartment_id])
    if @availability_period.save
      @errors = []
      redirect_to appartment_path(@appartment)
    else
      @errors = @availability_period.errors.messages
      render :new
    end
  end

  def destroy

  end

  protected

  def availability_period_params
    params.require(:availability_period).permit(:start_date, :end_date)
  end
end
