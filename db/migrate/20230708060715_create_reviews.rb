class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|

      t.string :customer_id
      t.string :book_id
      t.string :star
      t.text :impression
      t.string :action
      t.timestamps
    end
  end
end
