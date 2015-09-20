class CreateTagsAndTaggings < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :label, null:false
      t.integer :color, null:false, default: 0

      t.references :user, index: true, foreign_key: true, null:false

      t.timestamps null: false
    end

    create_table :taggings do |t|
      t.references :event, index:true, foreign_key: true, null:false
      t.references :tag, index:true, foreign_key: true, null:false

      t.timestamps null: false
    end
    add_index :taggings, [:event_id, :tag_id], unique: true
    add_index :taggings, [:tag_id, :event_id], unique: true
  end
end
