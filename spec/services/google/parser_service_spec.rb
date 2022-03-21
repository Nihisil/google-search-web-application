# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Google::ParserService, type: :service do
  describe 'parse html' do
    it 'counts total links number', vcr: 'services/google/buy_car' do
      html = Google::SearchService.new.do_search(keyword: 'buy car')
      expect(described_class.new(html: html).total_links_count).to eq(86)
    end

    it 'counts total search results', vcr: 'services/google/buy_car' do
      html = Google::SearchService.new.do_search(keyword: 'buy car')
      expect(described_class.new(html: html).total_search_results).to eq('About 11.460.000.000 results (0,91 seconds)')
    end

    it 'counts total ads number', vcr: 'services/google/buy_car' do
      html = Google::SearchService.new.do_search(keyword: 'buy car')
      expect(described_class.new(html: html).total_ads_count).to eq(2)
    end
  end
end
