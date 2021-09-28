require 'rails_helper'

RSpec.describe "教室ログイン", type: :system do
  before do
    @school = FactoryBot.create(:school)
  end

  context 'ログインできるとき' do
    it '保存されている教室情報と合致すればログインできる' do
      # トップページに移動する
      visit root_path
      # 自動的にログインページにリダイレクトされることを確認する
      expect(current_path).to eq(new_school_session_path)
      # 正しい教室情報を入力する
      fill_in 'school[email]', with: @school.email
      fill_in 'school[password]', with: @school.password
      # ログインボタンを押す
      find('input[name="commit"]').click
      # トップページに遷移することを確認する
      expect(current_path).to eq(root_path)
      # カーソルを合わせるとログアウトボタンが表示されることを確認する
      expect(
        find('.gnav').hover
      ).to have_content('ログアウト')
    end
  end
  
  context 'ログインできないとき' do
    it '保存されている教室情報と合致しないとログインできない' do
      # トップページに移動する
      visit root_path
      # 自動的にログインページにリダイレクトされることを確認する
      expect(current_path).to eq(new_school_session_path)
      # ユーザー情報を入力する
      fill_in 'school[email]', with: ''
      fill_in 'school[password]', with: ''
      # ログインボタンを押す
      find('input[name="commit"]').click
      # ログインページに戻されることを確認する
      expect(current_path).to eq(new_school_session_path)
    end
  end
end
