class CreateEventEntries < ActiveRecord::Migration
  def change
    create_table :event_entries do |t|
      t.references :event, index: true, foreign_key: true, null: false
      t.references :user, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
