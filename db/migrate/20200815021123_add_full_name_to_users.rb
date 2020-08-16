class AddFullNameToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :full_name, :string
    add_column :users, :auth_token, :string
  end
end

