# frozen_string_literal: true

module Form
  module CSVKeywordHelper
    def save_form_with_csv_file(file_name)
      form = CsvKeywordsForm.new(Fabricate(:user))
      file = file_fixture("csv/#{file_name}")
      type = MIME::Types.type_for(file.extname).first.content_type
      form.save(ActionDispatch::Http::UploadedFile.new({ tempfile: file, type: type }))
      form
    end
  end
end

RSpec.configure do |config|
  config.include Form::CSVKeywordHelper, type: :form
end
