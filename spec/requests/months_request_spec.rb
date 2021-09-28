require 'rails_helper'

RSpec.describe "Months", type: :request do
  
  before do
    @school = FactoryBot.create(:school)
    sign_in @school
    
    @month = FactoryBot.create(:month)
  end
  
  describe "GET #index" do
    it "indexアクションにリクエストすると正常にレスポンスが返ってくる" do
      get months_path
      expect(response.status).to eq(200)
    end
    
    context '月データが存在する場合' do
      it "indexアクションにリクエストするとレスポンスに作成済みの月一覧が存在する" do
        get months_path
        expect(response.body).to include(@month.month.strftime("%Y年%m月"))
      end
    end
  end
  
  describe "GET #new" do
    it "newアクションにリクエストすると正常にレスポンスが帰ってくる" do
      get new_month_path
      expect(response.status).to eq(200)
    end
    it "newアクションにリクエストするとレスポンスのフォームに現在の年月が表示される" do
      t = Time.current
      get new_month_path
      expect(response.body).to include("<option value=\"#{t.year}\" selected=\"selected\">")
      expect(response.body).to include("<option value=\"#{t.month}\" selected=\"selected\">")
    end
  end
  
  describe "GET #show" do
    it "showアクションにリクエストすると正常にレスポンスが帰ってくる" do
      get month_path(@month)
      expect(response.status).to eq(200)
    end
    it "showアクションにリクエストするとレスポンスに年月の表示が存在する" do
      get month_path(@month)
      expect(response.body).to include("#{@month.month.strftime("%Y年%m月")}の記録")
    end
    
    context '日付データが存在しない場合' do
      it "showアクションにリクエストするとレスポンスにテーブルが未作成という表示が存在する"  do
        get month_path(@month)
        expect(response.body).to include("テーブルがありません")
      end
      it "showアクションにリクエストするとレスポンスにテーブル作成ボタンが存在する"  do
        get month_path(@month)
        expect(response.body).to include(business_days_path)
      end
      it "showアクションにリクエストするとレスポンスにテーブルが存在しない" do
        get month_path(@month)
        expect(response.body).not_to include("table")
      end
    end
    
    context '日付データが存在する場合' do
      before do
        @business_day = BusinessDay.create(month_id: @month.id, date: @month.month, school_id: @school.id)
      end
      
      it "showアクションにリクエストするとレスポンスにテーブルが存在する" do
        get month_path(@month)
        expect(response.body).to include("table")
      end
      it "showアクションにリクエストするとレスポンスに埋まり率が存在する" do
        get month_path(@month)
        expect(response.body).to include("#{@business_day.use_rate}%")
      end
    end
  end
end
