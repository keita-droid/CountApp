class BusinessHoursController < ApplicationController
  
  def index
    @t = Time.current
    hour = @t.hour
    @today = BusinessDay.find(params[:business_day_id])
    @current_hour = BusinessHour.find_by(hour: hour, business_day_id: @today.id)
    @current_hour.check_previous_hour unless @current_hour.nil?
  end
  
  def new
    @today = BusinessDay.find(params[:business_day_id])
  end
  
  def create
    t = Time.current
    day = BusinessDay.find(params[:business_day_id])
    hour = weekend_operation(day)
    hours = []
    
    # 6時間分のレコードをまとめて作成
    6.times do
      hours << BusinessHour.new(business_day_id: create_params[:business_day_id], hour: hour)
      hour += 1
    end
    BusinessHour.import hours
    if t.beginning_of_day == day.date.beginning_of_day
      redirect_to action: :index
    else
      redirect_to business_day_path(day)
    end
  end
  
  def edit
    @business_day = BusinessDay.find(params[:business_day_id])
    @business_hour = BusinessHour.find(params[:id])
  end
  
  def update
    @t = Time.current
    @business_hour = BusinessHour.find(params[:id])
    
    # 通常の編集
    if params[:status] == "edit"
      @business_hour.update(update_params)

    # カウント（現在の時間帯の更新）
    elsif @t.hour == @business_hour.hour
      business_hour = count(@business_hour)
      business_hour.save
      redirect_to business_day_business_hours_path(@business_hour.business_day)
    
    # 時間帯を跨いだ場合、次の時間の記録を取得してカウント
    elsif @t.hour == @business_hour.hour + 1
      business_hour = @business_hour.next_hour
      unless business_hour.nil?
        business_hour.check_previous_hour
        business_hour = count(business_hour)
        business_hour.save
      end
      redirect_to business_day_business_hours_path(@business_hour.business_day)
    end
  end
  
  private
  def create_params
    params.permit(:business_day_id, :weekend_operation)
  end
  
  def weekend_operation(day)
    if params[:weekend_operation] == "true"
      if day.weekend_operation == false
        day.update(weekend_operation: create_params[:weekend_operation])
      end
      13
    else
      16
    end
  end
  
  def update_params
    params.require(:business_hour).permit(:current_stay, :maximum_stay, :coming, :leaving, :leave_count)
  end
  
  def count(business_hour)
    case params[:status]
    when "come"
      business_hour.come_one
    when "leave"
      business_hour.leave_one
    end
  end
end
