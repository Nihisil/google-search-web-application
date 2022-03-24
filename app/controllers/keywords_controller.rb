# frozen_string_literal: true

class KeywordsController < ApplicationController
  def index
    query = params[:keyword]
    keywords = current_user.keywords
    keywords = keywords.search(query) if query
    render locals: {
      keywords: keywords,
      query: query
    }
  end

  def show
    keyword = current_user.keywords.find_by(id: params[:id])
    render locals: {
      keyword: keyword
    }
  end

  def create
    if save_keywords_from_file
      StartSearchKeywordsJob.perform_later(csv_form.keyword_ids)
      flash[:notice] = I18n.t('uploaded_keywords')
    else
      flash[:alert] = csv_form.errors.full_messages.first
    end
    redirect_to keywords_path
  end

  private

  def save_keywords_from_file
    csv_form.save(params[:file])
  end

  def csv_form
    @csv_form ||= CsvKeywordsForm.new(current_user)
  end
end
