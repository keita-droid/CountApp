class BusinessDay < ApplicationRecord
  belongs_to :month
  belongs_to :school
  has_many :business_hours, dependent: :destroy
  
  # validation
  validates :date, presence: true
  
  # レコード（一日）の来校者数の取得
  def coming_sum
    sum = 0
    self.business_hours.each do |hour|
      sum += hour.coming
    end
    sum
  end
  
  # レコード（一日）あたりの最大人数の取得
  def maximums 
    array = [0]
    array.push(max_of_13, max_of_14, max_of_15, max_of_16, max_of_17, max_of_18, max_of_19, max_of_20, max_of_21)
    array.delete(nil)
    array.max
  end
  
  # 埋まり率の計算
  def use_rate
    num = maximums
    rate = num.to_f / self.school.seats * 100
    rate.round(1)
  end
  
  
  # 日付表示
  def date_format
    "#{date.strftime("%Y/%m/%d")}"
  end
  
  def weekday_format
    case date.wday
      when 0
        " (日)"
      when 1
        " (月)"
      when 2
        " (火)"
      when 3
        " (水)"
      when 4
        " (木)"
      when 5
        " (金)"
      when 6
        " (土)"
    end
  end
  
  # インスタンスの翌日のレコードを取得
  def tomorrow
    BusinessDay.find_by(date: self.date.tomorrow)
  end
  
  # インスタンスの前日のレコードを取得
  def yesterday
    BusinessDay.find_by(date: self.date.yesterday)
  end
end
