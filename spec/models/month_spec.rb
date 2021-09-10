require 'rails_helper'

RSpec.describe Month, type: :model do
  describe "#create" do
    before do
      @month = FactoryBot.build(:month)
    end
    
    it 'monthが存在すれば登録できる' do
      expect(@month).to be_valid
    end
    
    it 'monthが空では登録できない' do
      @month.month = nil
      @month.valid?
      expect(@month.errors.full_messages).to include("Month can't be blank")
    end
    
    it '重複するmonthが存在する場合は登録できない' do
      month = FactoryBot.create(:month)
      @month.month = month.month
      @month.valid?
      expect(@month.errors.full_messages).to include("Month has already been taken")
    end
  end
end
