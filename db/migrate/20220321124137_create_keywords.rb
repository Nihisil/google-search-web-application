class CreateKeywords < ActiveRecord::Migration[7.0]
  def change
    create_table :keywords do |t|
      t.references :user, null: false, foreign_key: true

      t.string :keyword
      t.integer :status
      t.text :html
      t.integer :total_links_count
      t.string :total_search_results
      t.integer :total_ads_count

      t.timestamps
    end

    add_check_constraint :keywords, 'char_length(keyword) <= 100', name: 'keywords_length'
  end
end
