class AddUserRolesRelationship < ActiveRecord::Migration[6.0]
  def change
    create_table :user_roles do |t|
      t.integer :user_id
      t.integer :role_id
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
