class CreateSearchPrices < ActiveRecord::Migration[8.0]
  def change
    create_table :search_prices do |t|
      t.string :price
      t.string :product
      t.string :link
      t.string :image_link
      t.references :book

      t.timestamps
    end
  end
end
