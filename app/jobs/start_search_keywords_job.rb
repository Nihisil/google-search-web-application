# frozen_string_literal: true

class StartSearchKeywordsJob < ApplicationJob
  queue_as :default

  def perform(keyword_ids)
    keyword_ids.each_with_index do |keyword_id, index|
      DoSearchByKeywordJob.set(wait: index * 2).perform_later(keyword_id)
    end
  end
end
