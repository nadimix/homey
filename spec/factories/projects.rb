FactoryBot.define do
  factory :project do
    client

    trait :with_agent do
      after(:create) do |project|
        project.agents << create(:agent)
      end
    end

    trait :with_vendor do
      after(:create) do |project|
        project.vendors << create(:vendor)
      end
    end
  end
end
