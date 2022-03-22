# frozen_string_literal: true

class CsvFileValidator < ActiveModel::Validator
  def validate(form)
    @form = form

    validate_file
  end

  private

  attr_reader :form

  def file
    form.file
  end

  def validate_file
    unless file
      form.errors.add(:base, 'File is required')
      return
    end

    unless valid_csv_file_type?
      form.errors.add(:base, 'Uploaded file should be valid CSV')
      return
    end

    form.errors.add(:base, 'Allowed number of keywords between 1 and 100') unless valid_keywords_count?
  end

  def valid_keywords_count?
    CSV.read(file.tempfile).count.between?(1, 100)
  end

  def valid_csv_file_type?
    file.content_type == 'text/csv'
  end
end
