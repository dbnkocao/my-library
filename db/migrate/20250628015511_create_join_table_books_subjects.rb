class CreateJoinTableBooksSubjects < ActiveRecord::Migration[8.0]
  def change
    create_join_table :books, :subjects do |t|
      t.index :book_id
      t.index :subject_id
    end
  end
end
