class Month < ApplicationRecord
  has_many :business_days
  
  # validation
  validates :month, presence: true, uniqueness: true
  
  # インスタンスの翌月のレコードを取得
  def next_month
    Month.find_by(month: self.month.next_month)
  end
  
  # インスタンスの先月のレコードを取得
  def prev_month
    Month.find_by(month: self.month.prev_month)
  end
end
