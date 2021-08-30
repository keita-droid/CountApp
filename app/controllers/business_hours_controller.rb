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
    t = Time.current
    @business_hour = BusinessHour.find(params[:id])
    if t.hour == @business_hour.hour
      # 今の時間帯の更新（カウントまたは編集）
      @business_hour.update(update_params)
      unless params[:status] == "edit"
        redirect_to business_day_business_hours_path(@business_hour.business_day)
      end
    elsif t.hour == @business_hour.hour + 1
      # 時間帯を跨いだ場合、次の時間のレコードを取得してアップデート
      business_hour = BusinessHour.find_by(id: params[:id].to_i + 1)
      unless business_hour.nil?
        if business_hour.hour == t.hour
          business_hour.check_previous_hour
          business_hour.update(update_params)
        end
      end
      redirect_to business_day_business_hours_path(business_day_id: params[:business_day_id])
    elsif params[:status] == "edit"
      # 現在でない時間帯の編集
      @business_hour.update(update_params)
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
    set = params.require(:business_hour).permit(:current_stay, :maximum_stay, :coming, :leaving, :leave_count)
    
    case params[:status]
    when "come"
      come_one(set)
    when "leave"
      leave_one(set)
    when "edit" 
      set
    end
  end
  
  def come_one(set)
    unless set[:leave_count].to_i > 0
      set[:current_stay] = "#{set[:current_stay].to_i + 1}"
      set[:maximum_stay] = "#{set[:maximum_stay].to_i + 1}"
      set[:coming] = "#{set[:coming].to_i + 1}"
      return set
    else
      set[:current_stay] = "#{set[:current_stay].to_i + 1}"
      set[:leave_count] = "#{set[:leave_count].to_i - 1}"
      set[:coming] = "#{set[:coming].to_i + 1}"
      return set
    end
  end
  
  def leave_one(set)
    unless set[:current_stay].to_i == 0
      set[:current_stay] = "#{set[:current_stay].to_i - 1}"
      set[:leaving] = "#{set[:leaving].to_i + 1}"
      set[:leave_count] = "#{set[:leave_count].to_i + 1}"
      return set
    else
      return set
    end
  end
  
end
