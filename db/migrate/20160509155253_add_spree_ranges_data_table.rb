class AddSpreeRangesDataTable < ActiveRecord::Migration
  def change
    create_table :spree_ranges do |t|
      t.string    :name
      t.integer   :start_range
      t.integer   :end_range
      t.string    :include_range, array: true

      t.timestamps
    end
  end
end
