FactoryBot.define do
  factory :history_entry do
    user
    project

    factory :status_change do
      entry_type { :status_change }
      body { "Status changed to: #{Project.statuses.keys.sample}" }
    end

    factory :comment do
      entry_type { :comment }
      body { "This is a comment" }
    end
  end
end
