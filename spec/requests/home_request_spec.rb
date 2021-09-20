require 'rails_helper'

RSpec.describe "Home", type: :request do
  
  before do
    @business_day = FactoryBot.create(:business_day)
    @month = @business_day.month
    @school = @business_day.school
    sign_in @school
  end

  describe "GET #index" do
    it "indexアクションにリクエストすると正常にレスポンスが返ってくる" do
      get root_path
      expect(response.status).to eq(200)
    end
    it "indexアクションにリクエストするとレスポンスに作成済みの月が存在する" do
      get root_path
      expect(response.body).to include(@month.month.strftime("%Y年%m月"))
    end
    it "indexアクションにリクエストするとレスポンスに作成済みの今月の記録一覧に今日の日付が存在する" do
      get root_path
      expect(response.body).to include(@business_day.date_format)
    end
    it "indexアクションにリクエストするとレスポンスに作成済みの今月の記録一覧に埋まり率が存在する" do
      get root_path
      expect(response.body).to include("#{@business_day.use_rate}%")
    end
    it "indexアクションにリクエストするとレスポンスにログイン中の教室名が存在する" do
      get root_path
      expect(response.body).to include(@school.name)
    end
    it "indexアクションにリクエストするとレスポンスに座席数が存在する" do
      get root_path
      expect(response.body).to include("#{@school.seats}席")
    end
    it "indexアクションにリクエストするとレスポンスにカウント機能に行くボタンが存在する" do
      get root_path
      expect(response.body).to include("カウントする")
    end
  end

end
