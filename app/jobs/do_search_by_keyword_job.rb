# frozen_string_literal: true

class DoSearchByKeywordJob < ApplicationJob
  queue_as :default

  def perform(keyword_id)
    keyword = Keyword.find(keyword_id)
    begin
      html = Google::SearchService.new.do_search keyword.keyword
      return keyword.update_status(:failed) unless html

      save_parsing_results(keyword, html, Google::ParserService.new(html).parse)
    rescue StandardError
      keyword.update_status(:failed)
    end
  end

  private

  def save_parsing_results(keyword, html, parsing_results)
    Keyword.transaction do
      keyword.set_parsing_results(:processed, html, parsing_results)
    end
  end
end
