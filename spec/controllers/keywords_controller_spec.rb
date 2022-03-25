# frozen_string_literal: true

require 'rails_helper'

RSpec.describe KeywordsController, type: :controller do
  describe 'GET #index' do
    it 'cant be accessed without sign in' do
      get :index
      expect(response).to have_http_status(:redirect)
    end

    it 'renders page for auth user' do
      sign_in Fabricate(:user)
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do
    it 'renders page for auth user' do
      keyword = Fabricate(:keyword)
      sign_in keyword.user
      get :show, params: { id: keyword.id }

      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    it 'shows keywords page after file upload' do
      sign_in Fabricate(:user)
      file = Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', 'csv', 'valid.csv'), 'text/csv')
      post :create, params: { file: file }

      expect(response).to redirect_to keywords_path
    end
  end
end
