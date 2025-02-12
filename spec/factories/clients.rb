FactoryBot.define do
  factory :client, parent: :user do
    trait :with_project do
      after(:create) do |client|
        user.projects << create(:project, client: client)
      end
    end
  end
end
