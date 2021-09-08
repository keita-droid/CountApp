class HomeController < ApplicationController
  def index
    t = Time.current
    @today = BusinessDay.find_by(date: t, school_id: current_school.id)
    @month = Month.find_by(month: t.beginning_of_month)
    @monthly_data = @month.business_days.where(school_id: current_school.id).includes(:school) unless @month.nil?
    months = Month.order("month DESC").limit(5)
    @months = months.reverse
  end
end
