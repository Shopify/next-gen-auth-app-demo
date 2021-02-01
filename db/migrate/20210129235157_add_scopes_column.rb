class AddScopesColumn < ActiveRecord::Migration[6.0]
  def change
    add_column :shops, :scopes, :string
  end
end
