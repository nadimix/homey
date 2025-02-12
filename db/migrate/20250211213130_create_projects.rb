class CreateProjects < ActiveRecord::Migration[8.0]
  def change
    create_table :projects do |t|
      t.integer :status, default: 0
      t.integer :client_id, null: false
      t.integer :agent_id
      t.integer :vendor_id

      t.timestamps
    end

    add_index :projects, :client_id
    add_index :projects, :agent_id
    add_index :projects, :vendor_id

    add_foreign_key :projects, :users, column: :client_id
    add_foreign_key :projects, :users, column: :agent_id
    add_foreign_key :projects, :users, column: :vendor_id
  end
end
