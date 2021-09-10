require 'rails_helper'

RSpec.describe BusinessDay, type: :model do
  describe "#create" do
    before do
      @business_day = FactoryBot.build(:business_day)
    end
    
    it 'date, weekend_operation, school_id, month_idが存在すれば登録できる' do
      expect(@business_day).to be_valid
    end
    
    it 'max_of_13からmax_of_21の値が空でも登録できる' do
      expect(@business_day).to be_valid
    end
    
    it 'weekend_operationの値が空でも登録できる' do
      @business_day.weekend_operation = nil
      expect(@business_day).to be_valid
    end
    
    it 'dateが空では登録できない' do
      @business_day.date = nil
      @business_day.valid?
      expect(@business_day.errors.full_messages).to include("Date can't be blank")
    end
    
    it 'dateが重複していても登録できる' do
      # モデルの設計上は、同一school_idでもdateを重複登録できてしまう。
      # 登録ボタンの非表示とコントローラのbefore_actionで回避している。
      business_day = FactoryBot.create(:business_day)
      @business_day.date = business_day.date
      expect(@business_day).to be_valid
    end
  end
end
