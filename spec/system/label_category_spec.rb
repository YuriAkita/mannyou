require 'rails_helper'
RSpec.describe 'ラベル機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:label_category) { FactoryBot.create(:label_category) }

  before do
    visit new_session_path
    fill_in 'session[email]', with: 'test1@email.com'
    fill_in 'session[password]', with: 'test123'
    click_button 'commit'
    visit tasks_path
  end

  describe '新規作成機能' do
    context 'ラベルをつけてタスクの新規作成した場合' do
      it '該当の投稿に作成したタスクが表示される' do
        visit new_task_path
        fill_in 'task[title]', with: 'test_title'
        fill_in 'task[content]', with: 'test_content'
        fill_in 'task[task_deadline]', with: '002021-12-24'
        select '着手中', from: 'task[status]'
        select '低', from: 'task[priority]'
        check "task[label_category_ids][]"
        click_button 'commit'
        visit tasks_path
        expect(page).to have_content 'label_test'
      end
    end
  end

end
