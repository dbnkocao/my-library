class CreateJoinTableLibrariesBooks < ActiveRecord::Migration[8.0]
  def change
    create_join_table :libraries, :books do |t|
      t.index :library_id
      t.index :book_id
    end
  end
end
