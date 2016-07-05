class SegmentAddName < ActiveRecord::Migration[5.0]
  def change
  	add_column :segments, :name, :string
  end
end
