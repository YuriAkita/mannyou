require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    @task = FactoryBot.create(:task, title: '該当タスクの内容が表示される', priority: '低')
    task1 = FactoryBot.create(:task, title: 'task1', task_deadline: '002021-11-01', status: '未着手', priority: '高')
    task2 = FactoryBot.create(:task, title: 'task2', task_deadline: '002021-12-01', status: '着手中', priority: '中')
    task3 = FactoryBot.create(:task, title: 'task3', task_deadline: '002022-01-01', status: '完了', priority: '低')
  end
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
       visit new_task_path
       fill_in 'task[title]', with: 'test_title'
       fill_in 'task[content]', with: 'test_content'
       fill_in 'task[task_deadline]', with: '002021-12-24'
       select '着手中', from: 'task[status]'
       select '低', from: 'task[priority]'
       click_button '投稿する'
       expect(page).to have_content 'test_title'
       expect(page).to have_content 'test_content'
       expect(page).to have_content '2021-12-24'
       expect(page).to have_content '着手中'
       expect(page).to have_content '低'
      end
    end

#Selenium::WebDriver::Error::StaleElementReferenceError:stale element reference: element is not attached to the page document
    context '終了期限でソートするをクリックした場合' do
      it '終了期限が一番短いものが一番上に表示される' do
        visit tasks_path
        click_link '終了期限でソートする'
        task_list = all('.task_row')
        expect(task_list[0]).to have_content '該当タスクの内容が表示される'
      end
    end
  end

#Failure/Error: expect(task_list[0]).to have_content 'test1'
  context '優先順位でソートするをクリックした場合' do
    it '優先度が高いものが上に表示される' do
      visit tasks_path
      click_link '優先順位でソートする'
      task_list = all('.task_row')
      expect(task_list[0]).to have_content 'test1'
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

    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        visit tasks_path
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'task3'
      end
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

  describe '検索機能' do
    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        visit tasks_path
        fill_in 'title', with: 'task3'
        click_button '検索する'
        expect(page).to have_content 'task3'
      end
    end

    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        visit tasks_path
        select '着手中', from: 'status'
        click_button '検索する'
        expect(page).to have_content 'task2'
      end
    end

    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        visit tasks_path
        fill_in 'title', with: 'task2'
        select '着手中', from: 'status'
        click_button '検索する'
        expect(page).to have_content 'task2'
      end
    end
  end

end
