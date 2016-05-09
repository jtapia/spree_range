class AddSpreeRangeCategoriesTable < ActiveRecord::Migration
  def change
    create_table :spree_range_categories do |t|
      t.integer  :range_id
      t.string   :name
      t.string   :description
      t.string   :image_file_name
      t.string   :image_content_type
      t.integer  :image_file_size
      t.datetime :image_updated_at

      t.timestamps
    end
  end
end