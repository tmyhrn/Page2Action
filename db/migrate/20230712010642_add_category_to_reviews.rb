class AddCategoryToReviews < ActiveRecord::Migration[6.1]
  def change
    add_column :reviews, :category, :string
  end
end
