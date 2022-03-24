# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DoSearchByKeywordJob, type: :job do
  describe '#perform' do
    it 'process keyword job', vcr: 'services/google/buy_car' do
      keyword = Fabricate(:keyword)
      described_class.perform_now(keyword.id)
      expect(keyword.reload.status).to eq('processed')
    end
  end
end
