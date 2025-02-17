# frozen_string_literal: true

class DropdownComponent < ViewComponent::Base
  # @param trigger_text [String]
  # @param options [Array<String>]
  # @param form_path [String]
  def initialize(trigger_text:, options:, form_path:)
    @trigger_text = trigger_text
    @options = options
    @form_path = form_path
  end
end
