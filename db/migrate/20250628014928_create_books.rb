class CreateBooks < ActiveRecord::Migration[8.0]
  def change
    create_table :books do |t|
      t.string :isbn
      t.string :title
      t.string :subtitle
      t.string :publisher
      t.string :synopsis
      t.string :year
      t.string :format
      t.string :location
      t.string :cover_url
      t.string :provider
      t.string :width
      t.string :height
      t.string :unit
      t.integer :page_count
      t.float :retail_price

      t.timestamps
    end
  end
end
