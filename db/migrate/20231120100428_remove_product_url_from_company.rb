class RemoveProductUrlFromCompany < ActiveRecord::Migration[7.1]
  def change
    remove_column :companies, :product_url, :string
  end
end
