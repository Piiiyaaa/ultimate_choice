class RemoveEmailFromUsers < ActiveRecord::Migration[7.0]
  def up
    remove_index :users, :email if index_exists?(:users, :email)
    remove_column :users, :email
    add_index :users, :name, unique: true unless index_exists?(:users, :name)
  end

  def down
    add_column :users, :email, :string
    add_index :users, :email, unique: true
  end
end