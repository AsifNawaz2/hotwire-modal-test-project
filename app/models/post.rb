# frozen_string_literal: true

# Post model
#
class Post < ApplicationRecord
  #
  # Validations
  #
  validates :title, presence: true, uniqueness: true
end
