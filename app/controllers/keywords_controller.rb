# frozen_string_literal: true

class KeywordsController < ApplicationController
  def index
    render locals: {
      keywords: current_user.keywords
    }
  end

  def create
    if save_keywords_from_file
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