# frozen_string_literal: true

class Keyword < ApplicationRecord
  belongs_to :user
  validates :keyword, presence: true, length: { maximum: 100 }
  enum status: { in_progress: 0, processed: 1, failed: 2 }

  scope :search, ->(query) { where('"keywords"."keyword" LIKE ?', "%#{sanitize_sql_like(query)}%") }
  default_scope { order(created_at: :desc) }

  def update_status(status)
    update(status: status)
  end

  def set_parsing_results(status, html, parsing_results)
    update(
      status: status,
      html: html,
      total_links_count: parsing_results[:total_links_count],
      total_search_results: parsing_results[:total_search_results],
      total_ads_count: parsing_results[:total_ads_count]
    )
  end
end
