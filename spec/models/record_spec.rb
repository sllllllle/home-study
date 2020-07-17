require 'rails_helper'

RSpec.describe Record, type: :model do
  before do
    @record = FactoryBot.create(:record)
  end
  it '有効なファクトリを持つこと' do
    expect(@record). to be_valid
  end

  it 'ユーザーと開始時刻があれば有効であること' do
    @user = FactoryBot.create(:user)
    record = Record.new(
      user: @user,
      label: nil,
      start_time: '2000-01-01 02:11:21'
    )
    expect(record).to be_valid
  end

  describe '存在性の検証' do
    it 'ユーザーが無ければ無効であること' do
      record = FactoryBot.build(:record, user: nil)
      expect(record).to_not be_valid
    end
  end

  describe '文字数の検証' do
    it '30文字以内であれば有効であること' do
      record = FactoryBot.create(:record)
      record.label = 'a' * 30
      expect(record).to be_valid
    end

    it '30文字を超える場合無効であること' do
      record = FactoryBot.create(:record)
      record.label = 'a' * 31
      expect(record).to_not be_valid
    end

    it '開始時刻がなければ無効であること' do
      record = FactoryBot.create(:record)
      record.start_time = nil
      expect(record).to_not be_valid
    end
  end

  describe 'メソッドの検証' do
    it '時間の計測を一時停止できること' do
    end

    it '時間の計測を再開できること' do
    end
  end
end
