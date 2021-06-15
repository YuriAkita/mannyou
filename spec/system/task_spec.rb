require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    @task = FactoryBot.create(:task, title: '該当タスクの内容が表示される')
    task1 = FactoryBot.create(:task, title: 'task1')
    task2 = FactoryBot.create(:task, title: 'task2')
    task3 = FactoryBot.create(:task, title: 'task3')
  end
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
       # 1. new_task_pathに遷移する（新規作成ページに遷移する）
       visit new_task_path
       # 2. 新規登録内容を入力する
       #「タスク名」というラベル名の入力欄と、「タスク詳細」というラベル名の入力欄にタスクのタイトルと内容をそれぞれ入力する
       # binding.irb
       fill_in 'task[title]', with: 'test_title'
       fill_in 'task[content]', with: 'test_content'
       # 3. 「登録する」というvalue（表記文字）のあるボタンをクリックする
       # ここに「登録する」というvalue（表記文字）のあるボタンをclick_onする（クリックする）する処理を書く
       click_button '投稿する'
       # 4. clickで登録されたはずの情報が、タスク詳細ページに表示されているかを確認する
       # （タスクが登録されたらタスク詳細画面に遷移されるという前提）
       expect(page).to have_content 'test_title'
       expect(page).to have_content 'test_content'
       # ここにタスク詳細ページに、テストコードで作成したデータがタスク詳細画面にhave_contentされているか（含まれているか）を確認（期待）するコードを書く
      end
    end
  end

  describe '一覧表示機能' do

    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task = FactoryBot.create(:task, title: 'task')
        visit tasks_path
        expect(page).to have_content 'task'
      end
    end
  end

  context 'タスクが作成日時の降順に並んでいる場合' do
    it '新しいタスクが一番上に表示される' do
      visit tasks_path
      task_list = all('.task_row')
      expect(task_list[0]).to have_content 'task3'
    end
  end

  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        visit tasks_path
        visit task_path(@task.id)
        expect(page).to have_content '該当タスクの内容が表示される'
      end
    end
  end
end
