# frozen_string_literal: true

class CsvKeywordsForm
  include ActiveModel::Model
  validates_with CsvFileValidator

  attr_reader :file, :user, :keyword_ids

  def initialize(user)
    @user = user
  end

  def save(file)
    @file = file

    return false unless valid?

    begin
      Keyword.transaction do
        # rubocop:disable Rails/SkipsModelValidations
        @keyword_ids = user.keywords.insert_all(processed_keywords).map { |keyword_hash| keyword_hash['id'] }
        # rubocop:enable Rails/SkipsModelValidations
      end
    rescue ActiveRecord::StatementInvalid, ArgumentError
      errors.add(:base, 'One or more keywords are invalid')
    end

    errors.empty?
  end

  private

  def processed_keywords
    CSV.read(file.tempfile).filter_map do |keyword|
      return nil if keyword.blank?

      {
        user_id: user.id,
        keyword: keyword,
        status: :in_progress
      }
    end
  end
end
