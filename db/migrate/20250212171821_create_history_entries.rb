class CreateHistoryEntries < ActiveRecord::Migration[8.0]
  def change
    create_table :history_entries do |t|
      t.references :user, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true
      t.integer :entry_type
      t.text :body

      t.timestamps
    end
  end
end
