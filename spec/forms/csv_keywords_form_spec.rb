# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CsvKeywordsForm, type: :form do
  describe '#save' do
    it 'saves valid keywords' do
      save_form_with_csv_file('valid.csv')
      expect(Keyword.count).to eq(2)
    end

    it 'validates that empty file cant be uploaded' do
      form = save_form_with_csv_file('empty.csv')
      expect(form.errors.full_messages.first).to eq 'Allowed number of keywords between 1 and 100'
    end

    it 'validates big csv file cant be uploaded' do
      form = save_form_with_csv_file('big.csv')
      expect(form.errors.full_messages.first).to eq 'Allowed number of keywords between 1 and 100'
    end

    it 'validates that only csv file can be uploaded' do
      form = save_form_with_csv_file('non_csv.txt')
      expect(form.errors.full_messages.first).to eq 'File should be CSV'
    end

    it 'validates that valid keywords can be used' do
      form = save_form_with_csv_file('non_valid.csv')
      expect(form.errors.full_messages.first).to eq 'One or more keywords are invalid'
    end
  end
end
