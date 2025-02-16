# frozen_string_literal: true

class FlashMessageComponent < ViewComponent::Base
  def initialize(type:, body:)
    @type = type
    @body = body
  end
end
