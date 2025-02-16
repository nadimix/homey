class HistoryEntry < ApplicationRecord
  belongs_to :user
  belongs_to :project

  enum :entry_type, { status_change: 0, comment: 1 }

  validates :body, :entry_type, presence: true
  validates :body, length: { maximum: 255 }

  after_create :broadcast_entry

  private

  def broadcast_entry
    broadcast_append_to(
      [ project, "history_entries" ],
      target: "history_entries",
      html: rendered_component
    )
  end

  def rendered_component
    ApplicationController.render(
      HistoryEntryComponent.new(entry: self),
      layout: false
    )
  end
end
