require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    @task = FactoryBot.create(:task, title: '該当タスクの内容が表示される')
    task1 = FactoryBot.create(:task, title: 'task1', task_deadline: '002021-11-01')
    task2 = FactoryBot.create(:task, title: 'task2', task_deadline: '002021-12-01')
    task3 = FactoryBot.create(:task, title: 'task3', task_deadline: '002022-01-01')
  end
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
       visit new_task_path
       # binding.irb
       fill_in 'task[title]', with: 'test_title'
       fill_in 'task[content]', with: 'test_content'
       fill_in 'task[task_deadline]', with: '002021-12-24'
       # binding.irb
       click_button '投稿する'
       expect(page).to have_content 'test_title'
       expect(page).to have_content 'test_content'
       expect(page).to have_content '2021-12-24'
      end
    end

    context '終了期限でソートするをクリックした場合' do
      it '終了期限が一番長いものが一番上に表示される' do
        visit tasks_path
        task_list = all('.task_row')
        click_link '終了期限でソートする'
        expect(task_list[0]).to have_content 'task3'
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
