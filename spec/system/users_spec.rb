require 'rails_helper'

RSpec.describe User, type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }

  describe 'ユーザー作成/ユーザー編集' do
    describe 'ログイン前' do
      describe 'ユーザー新規登録' do
        context 'フォームの入力値が正常なとき' do
          it 'ユーザーの新規登録が成功すること' do
            visit signup_path
            fill_in 'ユーザー名', with: 'tester'
            fill_in 'メールアドレス', with: 'tester@example.com'
            fill_in 'パスワード', with: '1234abc'
            fill_in '確認用のパスワード', with: '1234abc'
            select '男'
            select '10代'
            click_button '登録'
            expect(current_path).to eq root_path
            expect(page).to have_content 'ユーザを登録しました。'
          end
        end
        context 'メールアドレスが未記入のとき' do
          it 'ユーザーの新規登録が失敗すること' do
            visit signup_path
            fill_in 'ユーザー名', with: 'tester'
            fill_in 'メールアドレス', with: nil
            fill_in 'パスワード', with: '1234abc'
            fill_in '確認用のパスワード', with: '1234abc'
            select '男'
            select '10代'
            click_button '登録'
            expect(current_path).to eq users_path
            expect(page).to have_content "Email can't be blank"
          end
        end
        context '登録済みメールアドレスが記入されたとき' do
          it 'ユーザーの新規登録が失敗すること' do
            visit signup_path
            fill_in 'ユーザー名', with: 'tester'
            fill_in 'メールアドレス', with: user.email
            fill_in 'パスワード', with: '1234abc'
            fill_in '確認用のパスワード', with: '1234abc'
            select '男'
            select '10代'
            click_button '登録'
            expect(current_path).to eq users_path
            expect(page).to have_content 'Email has already been taken'
          end
        end
      end
    end

    describe 'ログイン後' do
      before do
        login(user)
      end
      describe 'ユーザー編集' do
        context 'フォームの入力値が正常なとき' do
          it 'ユーザー情報の編集が成功すること' do
            visit edit_user_path(user)
            fill_in 'メールアドレス', with: 'test@example.com'
            select '男'
            select '10代'
            click_button '更新'
            expect(current_path).to eq user_path(user)
            expect(page).to have_content 'ユーザー情報を更新しました。'
          end
        end
      end

      describe 'パスワード変更' do
        context 'フォームの入力値が正常なとき' do
          it 'パスワード変更に成功すること' do
            visit edit_password_path(user)
            fill_in '現在のパスワード', with: user.password
            fill_in '新しいパスワード', with: user.password + '1'
            fill_in '新しいパスワード（確認用）', with: user.password + '1'
            click_button '更新'
            expect(current_path).to eq user_path(user)
            expect(page).to have_content 'パスワードを変更しました。'
          end
        end
      end
    end
  end
end
