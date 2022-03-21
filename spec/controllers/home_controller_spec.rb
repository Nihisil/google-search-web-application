# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HomeController, type: :request do
  describe 'GET #index' do
    it 'has success status' do
      get :index

      expect(response).to have_http_status(:success)
    end
  end
end
