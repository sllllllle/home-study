require 'rails_helper'

RSpec.describe Record, type: :system do
  let(:user) { FactoryBot.create(:user) }
  before { login(user) }

  describe "勉強の開始" do
    it "フォームの入力値が正常なとき、勉強を開始できること" do
      visit new_record_path(user)
      fill_in "学習の内容や意気込みなど（30文字以内）", with: "Docker環境構築"
      click_button "開始"
      expect(current_path).to eq records_path
      expect(page).to have_content "勉強を開始しました。"
    end
  end

  describe "勉強中の操作" do
  end

  describe "勉強中のUIの検証" do
  end
end