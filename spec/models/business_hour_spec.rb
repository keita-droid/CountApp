require 'rails_helper'

RSpec.describe BusinessHour, type: :model do
  before do
    @business_hour = FactoryBot.build(:business_hour)
  end
  
  describe "#create" do
    it 'hourに時間帯、その他の初期値を0で、business_dayに従属するレコードを登録できる' do
      expect(@business_hour).to be_valid
    end
  end
  
  describe "#update" do
  end
end
