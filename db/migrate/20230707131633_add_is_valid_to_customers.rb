class AddIsValidToCustomers < ActiveRecord::Migration[6.1]
  def change
    add_column :customers, :is_valid, :boolean
  end
end
