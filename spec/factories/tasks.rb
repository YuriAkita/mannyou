FactoryBot.define do
  factory :task do
    # 下記の内容は実際に作成するカラム名に合わせて変更してください
    title { 'Factoryで作ったデフォルトのタイトル１' }
    content { 'Factoryで作ったデフォルトのコンテント１' }
    task_deadline { '002021-08-01' }
  end

  factory :task_deadline do
    title { 'Factoryで作った終了期限が一番上にくるはずのタイトル2' }
    content { 'Factoryで作った終了期限が一番上にくるはずのコンテント2' }
    task_deadline { '002021-10-01' }
  end

  factory :second_task, class: Task do
    title { 'Factoryで作ったデフォルトのタイトル２' }
    content { 'Factoryで作ったデフォルトのコンテント２' }
    task_deadline { '002021-12-30' }
  end
end
