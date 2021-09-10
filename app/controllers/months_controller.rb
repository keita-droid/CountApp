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
    @prev_month = @month.prev_month
    @next_month = @month.next_month
    @monthly_data = @month.business_days.where(school_id: current_school.id).includes(:school)
    
    @business_day = BusinessDay.new
  end
  
  private
  def create_params
    params.require(:month).permit(:month)
  end
end
