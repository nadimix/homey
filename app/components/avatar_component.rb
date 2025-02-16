# frozen_string_literal: true

class AvatarComponent < ViewComponent::Base
  # @param user [User]
  # @param size [String] 'lg' or 'sm'
  def initialize(user:, size: "lg")
    @user = user
    @size = size
  end
end
