class MonthsController < ApplicationController
  
  def index
    @months = Month.order("month ASC")
  end
  
  def new
    @month = Month.new
  end
  
  def create
    month = Month.create(create_params)
    unless month.id.nil?
      redirect_to action: :show, id: month.id
    end
  end
  
  def show
    @month = Month.find(params[:id])
    all_monthly_data = @month.business_days
    @monthly_data = all_monthly_data.where(school_id: current_school.id).includes(:school)
    
    @business_day = BusinessDay.new
  end
  
  private
  def create_params
    params.require(:month).permit(:month)
  end
end
