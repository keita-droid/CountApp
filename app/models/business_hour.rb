class BusinessHour < ApplicationRecord
  belongs_to :business_day
  
  # callback
  after_update :update_business_day
  
  # 入室
  def come_one
    unless self.leave_count > 0
      self.current_stay += 1
      self.maximum_stay += 1
      self.coming += 1
    else
      self.current_stay += 1
      self.leave_count -= 1
      self.coming += 1
    end
    return self
  end
  
  # 退室
  def leave_one
    unless self.current_stay == 0
      self.current_stay -= 1
      self.leaving += 1
      self.leave_count += 1
    end
    return self
  end
  
  def today?(time)
    time.beginning_of_day == self.business_day.date.beginning_of_day
  end
  
  # 次の時間帯の記録を取得する
  def next_hour
    BusinessHour.find_by(hour: self.hour + 1, business_day_id: self.business_day_id)
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
