require 'rails_helper'

RSpec.describe School, type: :model do
  describe "#create" do
    before do 
      @school = FactoryBot.build(:school)
    end
    
    it 'name、seats、email、passewordとpassword_confirmationが存在すれば登録できる' do
      expect(@school).to be_valid
    end
    
    it 'nameが空では登録できない' do
      @school.name = ""
      @school.valid?
      expect(@school.errors.full_messages).to include("Name can't be blank")
    end
    
    it '重複するnameが存在する場合は登録できない' do
      school = FactoryBot.create(:school)
      @school.name = school.name
      @school.valid?
      expect(@school.errors.full_messages).to include("Name has already been taken")
    end
    
    it 'seatsが空では登録できない' do
      @school.seats = nil
      @school.valid?
      expect(@school.errors.full_messages).to include("Seats can't be blank")
    end
    
    it 'emailが空では登録できない' do
      @school.email = ""
      @school.valid?
      expect(@school.errors.full_messages).to include("Email can't be blank")
    end
    it 'passwordが空では登録できない' do
      @school.password = ""
      @school.valid?
      expect(@school.errors.full_messages).to include("Password can't be blank")
    end
  
    it 'passwordが６文字以上であれば登録できる' do
      @school.password = "123456"
      @school.password_confirmation = "123456"
      expect(@school).to be_valid
    end
    it 'passwordが５文字以下であれば登録できない' do
      @school.password = "12345"
      @school.password_confirmation = "12345"
      @school.valid?
      expect(@school.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
    it 'passwordとpassword_confirmationが不一致では登録できない' do
      @school.password = "aaaaaaaa"
      @school.password_confirmation = "12345678"
      @school.valid?
      expect(@school.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
  
    it '重複するemailが存在する場合は登録できない' do
      school = FactoryBot.create(:school)
      @school.email = school.email
      @school.valid?
      expect(@school.errors.full_messages).to include("Email has already been taken")
    end
  end
end
