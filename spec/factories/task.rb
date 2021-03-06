FactoryGirl.define do
  factory :task do
    title { Faker::Name.title }
    priority 1
  end

  factory :active_task, parent: :task do
    completed false
  end

  factory :completed_task, parent: :task do
    completed true
  end
end
