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
    save_keywords
    errors.empty?
  end

  private

  def save_keywords
    Keyword.transaction do
      # rubocop:disable Rails/SkipsModelValidations
      user.keywords.destroy_all
      @keyword_ids = user.keywords.insert_all(processed_keywords).map { |result| result['id'] }
      # rubocop:enable Rails/SkipsModelValidations
    end
  rescue ActiveRecord::StatementInvalid, ArgumentError
    errors.add(:base, 'One or more keywords are invalid')
  end

  def processed_keywords
    CSV.read(file.tempfile).filter_map do |row|
      return nil if row.empty?

      keyword = row[0]
      return nil if keyword.blank?

      {
        user_id: user.id,
        keyword: keyword,
        status: :in_progress
      }
    end
  end
end
