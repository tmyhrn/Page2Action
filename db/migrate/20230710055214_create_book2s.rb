class CreateBook2s < ActiveRecord::Migration[6.1]
  def change
    create_table :book2s, id: false do |t|
      t.string :title
      t.string :author
      t.bigint :isbn, null: false, primary_key: true
      t.string :url
      t.string :image_url

      t.timestamps
    end
  end
end
