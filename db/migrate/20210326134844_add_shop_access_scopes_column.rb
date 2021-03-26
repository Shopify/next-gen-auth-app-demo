class AddShopAccessScopesColumn < ActiveRecord::Migration[6.0]
  def change
    add_column :shops, :access_scopes, :string
  end
end
