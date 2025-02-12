class HistoryEntry < ApplicationRecord
  belongs_to :user
  belongs_to :project

  enum :entry_type, { status_change: 0, comment: 1 }

  validates :body, :entry_type, presence: true
end
