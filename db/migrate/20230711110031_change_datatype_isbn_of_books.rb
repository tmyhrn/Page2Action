class ChangeDatatypeIsbnOfBooks < ActiveRecord::Migration[6.1]
  def change
    change_column :books, :isbn, :string, null: false
  end
end
