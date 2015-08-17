class CreateEventOptions < ActiveRecord::Migration
  def change
    create_table :event_options do |t|
      t.string :option, null: false
      t.references :event, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
