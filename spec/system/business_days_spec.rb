require 'rails_helper'

RSpec.describe "月間記録の準備", type: :system do
  before do
    @school = FactoryBot.create(:school)
    sign_in @school
    @month = FactoryBot.create(:month)

    @days = 0
    day = @month.month
    while day.month == @month.month.month
      @days += 1
      day = day.tomorrow
    end
  end

  context "月データが存在するとき" do
    it "一ヶ月の日付データをまとめて作成できる" do
      # トップページに移動する
      visit root_path
      # 今月の日付データ作成ボタンがあることを確認する
      expect(page).to have_link('作成する', href: month_path(@month))
      # 月間記録ページに移動する
      visit month_path(@month)
      # 作成するとBusinessDayモデルのカウントが日数分上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change{ BusinessDay.count }.by(@days)
      # 月間記録ページに遷移することを確認する
      expect(current_path).to eq(month_path(@month))
      # テーブルが表示されていることを確認する
      day1 = @school.business_days.first
      day2 = @school.business_days.last
      expect(page).to have_content(day1.date_format)
      expect(page).to have_content(day2.date_format)
      # トップページに移動する
      visit root_path
      # テーブルが表示されていることを確認する
      expect(page).to have_content(day1.date_format)
      expect(page).to have_content(day2.date_format)
    end
  end
end
