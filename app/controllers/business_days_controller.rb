class BusinessDaysController < ApplicationController
  
  def create
    day = Date.parse(create_params[:date])
    days = []
    
    # 1ヶ月分のレコードをまとめて作成
    while day.month == Date.parse(create_params[:date]).month
      days << BusinessDay.new(date: day, month_id: create_params[:month_id], weekend_operation: weekend_or_weekday?(day), school_id: current_school.id)
      day = day.tomorrow
    end
    BusinessDay.import days
    
    redirect_to controller: :months, action: :show, id: create_params[:month_id]
  end
  
  def show
    @business_day = BusinessDay.find(params[:id])
  end
  
  private
  def create_params
    params.require(:business_day).permit(:date, :month_id)
  end
  
  def weekend_or_weekday?(day)
    # 土曜または日曜の場合はtrueを返す
    wd = day.wday
    if wd == 0 || wd == 6
      true
    else
      false
    end
  end
end
