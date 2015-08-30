class CreateOptionEntries < ActiveRecord::Migration
  def change
    create_table :option_entries do |t|
      t.integer :feeling, null: false, default: 0
      t.references :option, index: true, foreign_key: true, null: false
      t.references :event_entry, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end

    add_index :option_entries, [:option_id, :event_entry_id], unique: true
    add_index :option_entries, [:event_entry_id, :option_id], unique: true
  end
end
