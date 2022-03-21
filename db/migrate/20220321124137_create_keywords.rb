class CreateKeywords < ActiveRecord::Migration[7.0]
  def change
    create_table :keywords do |t|
      t.string :keyword
      t.integer :status
      t.text :html
      t.integer :total_links_count
      t.string :total_search_results
      t.integer :total_ads_count

      t.timestamps
    end
  end
end
