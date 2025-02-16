# frozen_string_literal: true

class FlashMessageComponent < ViewComponent::Base
  # @param [String] body
  def initialize(body:)
    @body = body
  end
end
