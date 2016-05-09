class AddSpreeRangesDataTable < ActiveRecord::Migration
  def change
    create_table :spree_ranges do |t|
      t.string    :name
      t.integer   :start_range
      t.integer   :end_range
      t.integer   :include_range

      t.string   :image_file_name
      t.string   :image_content_type
      t.integer  :image_file_size
      t.datetime :image_updated_at

      t.timestamps
    end
  end
end
