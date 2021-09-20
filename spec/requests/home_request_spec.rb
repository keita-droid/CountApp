require 'rails_helper'

RSpec.describe "Home", type: :request do
  
  before do
    @school = FactoryBot.create(:school)
    sign_in @school
  end

  describe "GET #index" do
    it "indexアクションにリクエストすると正常にレスポンスが返ってくる" do
      get root_path
      expect(response.status).to eq(200)
    end
    it "indexアクションにリクエストするとレスポンスにログイン中の教室名が存在する" do
      get root_path
      expect(response.body).to include(@school.name)
    end
    it "indexアクションにリクエストするとレスポンスに座席数が存在する" do
      get root_path
      expect(response.body).to include("#{@school.seats}席")
    end
    
    context '月データと日付データが未作成の場合' do
      it "indexアクションにリクエストするとレスポンスに今月のデータが未作成という表示が存在する" do
        get root_path
        expect(response.body).to include("今月のデータがありません")
      end
      it "indexアクションにリクエストするとレスポンスに月データ作成ボタンが存在する" do
        get root_path
        expect(response.body).to include(new_month_path)
      end
      it "indexアクションにリクエストするとレスポンスに月一覧の内容が存在しない" do
        get root_path
        expect(response.body).to_not include("続きを見る")
      end
      it "indexアクションにリクエストするとレスポンスにカウント機能へのリンクは存在しない" do
        get root_path
        expect(response.body).to_not include("カウントする")
      end
    end
    
    context '月データは作成済みだが日付データは未作成の場合' do
      before do
        @month = FactoryBot.create(:month)
      end
      it "indexアクションにリクエストするとレスポンスに今月のデータが未作成という表示が存在する" do
        get root_path
        expect(response.body).to include("今月のデータがありません")
      end
      it "indexアクションにリクエストするとレスポンスに日付データ作成ボタンが存在する" do
        get root_path
        expect(response.body).to include(month_path(@month))
      end
      it "indexアクションにリクエストするとレスポンスに作成済みの月一覧が存在する" do
        get root_path
        expect(response.body).to include(@month.month.strftime("%Y年%m月"))
      end
      it "indexアクションにリクエストするとレスポンスにカウント機能へのリンクは存在しない" do
        get root_path
        expect(response.body).to_not include("カウントする")
      end
    end
    
    context '月データと日付データが作成済みの場合' do
      before do
        @business_day = FactoryBot.create(:business_day)
        @month = @business_day.month
        @school = @business_day.school
        sign_in @school
      end
      it "indexアクションにリクエストするとレスポンスに作成済みの今月の記録一覧に今日の日付が存在する" do
        get root_path
        expect(response.body).to include(@business_day.date_format)
      end
      it "indexアクションにリクエストするとレスポンスに作成済みの今月の記録一覧に埋まり率が存在する" do
        get root_path
        expect(response.body).to include("#{@business_day.use_rate}%")
      end
      it "indexアクションにリクエストするとレスポンスに作成済みの月一覧が存在する" do
        get root_path
        expect(response.body).to include(@month.month.strftime("%Y年%m月"))
      end
      context '時間データ未作成' do
        it "indexアクションにリクエストするとレスポンスに時間データ作成ボタンが存在する" do
          get root_path
          expect(response.body).to include(new_business_day_business_hour_path(@business_day))
        end
      end
      context '時間データ作成済み' do
        it "indexアクションにリクエストするとレスポンスにカウント機能へのリンクが存在する" do
          @business_hour = BusinessHour.create(business_day_id: @business_day.id, hour: 16)
          get root_path
          expect(response.body).to include(business_day_business_hours_path(@business_day))
        end
      end
    end
  end
end
