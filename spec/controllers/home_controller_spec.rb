# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HomeController, type: :request do
  render_views

  describe 'GET #index' do
    it 'has success status' do
      get :index

      expect(response).to have_http_status(:success)
    end

    it 'renders page content' do
      get :index

      expect(response.body).to include('Google Search App')
    end
  end
end
