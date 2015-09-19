class AddToUsers < ActiveRecord::Migration
  def change
     add_column :users, :region, :string
     add_column :users, :profile, :string
  end
end
