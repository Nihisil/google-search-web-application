# frozen_string_literal: true

class Keyword < ApplicationRecord
  belongs_to :user
  validates :keyword, presence: true, length: { maximum: 100 }
  enum status: { in_progress: 0, processed: 1, error: 2 }
end
