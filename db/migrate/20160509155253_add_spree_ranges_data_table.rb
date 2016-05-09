class AddSpreeRangesDataTable < ActiveRecord::Migration
  def change
    create_table :spree_ranges do |t|
      t.string    :name
      t.integer   :start_range
      t.integer   :end_range
      t.integer   :include_range

      t.timestamps
    end
  end
end
