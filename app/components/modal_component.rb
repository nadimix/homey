# frozen_string_literal: true

class ModalComponent < ViewComponent::Base
  # @param trigger_text [String]
  # @param title [String]
  # @param placeholder_text [String]
  # @param cancel_text [String]
  # @param form_path [String]
  def initialize(trigger_text:, title:, placeholder_text:, cancel_text:, form_path:)
    @trigger_text = trigger_text
    @title = title
    @placeholder_text = placeholder_text
    @cancel_text = cancel_text
    @form_path = form_path
  end
end
