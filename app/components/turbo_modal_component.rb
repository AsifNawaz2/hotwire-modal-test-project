# frozen_string_literal: true

# Modal component
#
class TurboModalComponent < ViewComponent::Base
  # Turbo helpers
  include Turbo::FramesHelper

  def initialize(title:)
    @title = title
  end
end
