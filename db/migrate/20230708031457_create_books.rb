class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|

      t.string :title
      t.string :author
      t.string :isbn
      t.datetime :sales_date
      t.text :item_caption
      t.text :item_url
      t.text :small_image_url
      t.text :medium_image_url
      t.text :large_image_url
      t.timestamps
    end
  end
end
