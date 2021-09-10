class BusinessHour < ApplicationRecord
  belongs_to :business_day
  
  # callback
  after_update :update_business_day
  
  def today?(time)
    time.beginning_of_day == self.business_day.date.beginning_of_day
  end
  
  # 1時間前の記録を確認して引き継ぐ
  def check_previous_hour
    previous_hour = BusinessHour.find_by(hour: self.hour - 1, business_day_id: self.business_day_id)
    unless previous_hour.nil? || (self.maximum_stay > 0)
      self.update(current_stay: previous_hour.current_stay, maximum_stay: previous_hour.current_stay)
    end
  end
  
  private
  def update_business_day
    self.business_day.update({"max_of_#{self.hour}" => self.maximum_stay})
  end
end
