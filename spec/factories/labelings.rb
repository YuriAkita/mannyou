FactoryBot.define do
  factory :labeling do
    association :task
    association :label_category
  end
end
