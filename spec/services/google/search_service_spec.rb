# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Google::SearchService, type: :service do
  describe '#call' do
    it 'returns http response', vcr: 'services/google/buy_car' do
      result = described_class.new('buy car').call
      expect(result).to be_an_instance_of(HTTParty::Response)
    end
  end
end
