class AddSomeColumnsToComments < ActiveRecord::Migration
  def change
    add_column :comments, :name, :string
    add_column :comments, :public, :boolean
    add_column :comments, :description, :text
    add_column :comments, :user_id, :integer
  end
end
