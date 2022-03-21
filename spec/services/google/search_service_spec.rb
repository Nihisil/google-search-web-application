# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Google::SearchService, type: :service do
  describe '#do_search' do
    it 'returns http response', vcr: 'services/google/buy_car' do
      result = described_class.new.do_search(keyword: 'buy car')
      expect(result).to be_an_instance_of(HTTParty::Response)
    end
  end
end
