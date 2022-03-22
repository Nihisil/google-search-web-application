# frozen_string_literal: true

module Google
  class ParserService
    def initialize(html)
      @html = html
      @document = Nokogiri::HTML.parse(html)
    end

    def parse
      {
        total_links_count: total_links_count,
        total_search_results: total_search_results,
        total_ads_count: total_ads_count
      }
    end

    def total_links_count
      @document.css('a').count
    end

    def total_search_results
      strip_string @document.css('div#result-stats').text
    end

    def total_ads_count
      @document.css('div[data-text-ad]').count
    end

    private

    def strip_string(input)
      nil unless input
      # remove non break spaces and strip string
      input.delete(' ').strip
    end
  end
end
