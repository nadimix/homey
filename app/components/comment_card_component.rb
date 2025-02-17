# frozen_string_literal: true

class CommentCardComponent < ViewComponent::Base
  # @param user [User]
  # @param body [String]
  # @param created_at [Time]
  def initialize(user:, body:, created_at:)
    @user = user
    @body = body
    @created_at = created_at
  end
end
