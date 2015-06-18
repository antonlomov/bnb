class AvailabilityPeriodsController < ApplicationController

  def new
    @availability_period = AvailabilityPeriod.new
    @appartment = Appartment.find(params[:appartment_id])
    @errors = []
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
    @availability_period = AvailabilityPeriod.find(params[:id])
    @appartment = Appartment.find(params[:appartment_id])
    @availability_period.destroy
    redirect_to appartment_path(@appartment)
  end


  protected

  def availability_period_params
    params.require(:availability_period).permit(:start_date, :end_date)
  end
end
