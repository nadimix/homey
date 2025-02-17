# frozen_string_literal: true

class HistoryEntryComponent < ViewComponent::Base
  # @param entry [HistoryEntry]
  def initialize(entry:)
    @entry = entry
  end
end
