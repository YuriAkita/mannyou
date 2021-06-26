FactoryBot.define do
  factory :task do
    title { 'Factoryで作ったデフォルトのタイトル１' }
    content { 'Factoryで作ったデフォルトのコンテント１' }
    task_deadline { '002021-04-01' }
    status { '完了' }
    priority { 1 }
    after(:build) do |task|
      label_category = create(:label_category)
      task.labelings << build(:labeling, task: task, label_category: label_category)
    end
  end

  factory :second_task, class: Task do
    title { 'Factoryで作ったデフォルトのタイトル２' }
    content { 'Factoryで作ったデフォルトのコンテント２' }
    task_deadline { '002021-11-01' }
    status { '着手中' }
    priority { 2 }
  end
end
