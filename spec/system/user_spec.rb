require 'rails_helper'

RSpec.describe 'ログインとログアウト', type: :system do

  describe 'ユーザ登録' do

    context 'ユーザの新規登録をした場合' do
      it 'ユーザの新規作成ができる' do
        visit new_user_path
        fill_in 'user[name]', with: 'akita_yuri'
        fill_in 'user[email]', with: 'akita_yuri@email.com'
        fill_in 'user[password]', with: 'yuridayo'
        fill_in 'user[password_confirmation]', with: 'yuridayo'
        click_button 'commit'
        expect(page).to have_content 'ログインしました！'
      end
    end

    context 'ユーザがログインせずタスク一覧画面に飛ぼうとした場合' do
      it 'ログイン画面に遷移する' do
        visit tasks_path
        expect(page).to have_link "LOGIN"
      end
    end
  end

  describe 'セッション機能' do

    let!(:user) { FactoryBot.create(:user) }
    let!(:second_user) { FactoryBot.create(:second_user) }
    let!(:task) { FactoryBot.create(:task, user: second_user) }

    context 'ユーザー登録を既にしている場合' do
      it 'ログインができる' do
        visit new_session_path
        fill_in 'session[email]', with: 'test1@email.com'
        fill_in 'session[password]', with: 'test123'
        click_button 'commit'
        expect(page).to have_content 'test1のページ'
      end
    end

    before do
      visit new_session_path
      fill_in 'session[email]', with: 'test1@email.com'
      fill_in 'session[password]', with: 'test123'
      click_button 'commit'
    end

    context 'ユーザー詳細画面に遷移した場合' do
      it 'ユーザー詳細画面を表示する' do
        visit user_path(user.id)
        expect(page).to have_content 'test1のページ'
      end
    end

    context '一般ユーザが他人の詳細画面に飛ぼうとした場合' do
      it 'タスク一覧画面に遷移する' do
        visit user_path(second_user.id)
        expect(page).to have_content '権限がありません'
      end
    end

    context 'ログインユーザーがログアウトした場合' do
      it 'ログアウトができる' do
        click_link 'LOGOUT'
        expect(page).to have_content 'ログアウトしました'
      end
    end
  end

  describe '管理画面' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:second_user) { FactoryBot.create(:second_user) }

    context '管理ユーザーがログインした場合' do
      it '管理画面にアクセスができる' do
        visit new_session_path
        fill_in 'session[email]', with: 'admin_user@mail.com'
        fill_in 'session[password]', with: '9999999'
        click_button 'commit'
        visit admin_users_path
        expect(page).to have_content '管理者画面'
      end
    end

    context '一般ユーザーがログインした場合' do
      it '管理画面にアクセスができない' do
        visit new_session_path
        fill_in 'session[email]', with: 'test1@email.com'
        fill_in 'session[password]', with: 'test123'
        click_button 'commit'
        visit admin_users_path
        expect(page).to have_content '管理者以外はアクセスできません'
      end
    end

    before do
      visit new_session_path
      fill_in 'session[email]', with: 'admin_user@mail.com'
      fill_in 'session[password]', with: '9999999'
      click_button 'commit'
    end

    context '管理者ユーザーがユーザの新規登録をした場合' do
      it '作成された該当ユーザーの情報が表示される' do
        visit new_admin_user_path
        fill_in 'user[name]', with: 'akita_yuri'
        fill_in 'user[email]', with: 'akita_yuri@mail.com'
        fill_in 'user[password]', with: 'yuridayo'
        fill_in 'user[password_confirmation]', with: 'yuridayo'
        check 'user[admin]'
        click_button 'commit'
        expect(page).to have_content 'akita_yuri'
      end
    end

    context '管理者ユーザーがユーザ詳細画面へ遷移した場合' do
      it '該当ユーザーの詳細画面が表示される' do
        visit admin_user_path(user.id)
        expect(page).to have_content 'test1@email.com'
      end
    end

    context '管理者ユーザーが編集画面からユーザーを編集した場合' do
      it '該当ユーザーが編集できる' do
        visit edit_admin_user_path(user.id)
        sleep(1)
        fill_in 'user[name]', with:'test10'
        check 'user[admin]'
        click_button 'commit'
        expect(page).to have_content 'test10'
      end
    end

    context '管理者ユーザーがユーザーを削除した場合' do
      it '該当ユーザーが削除できる' do
        visit admin_users_path
        all('tr td')[15].click_link '削除'
        page.driver.browser.switch_to.alert.accept
        expect(page).to_not have_content 'test1@email.com'
      end
    end
  end
end
