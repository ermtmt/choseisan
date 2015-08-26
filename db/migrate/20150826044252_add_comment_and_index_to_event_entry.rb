class AddCommentAndIndexToEventEntry < ActiveRecord::Migration
  def change
    add_column :event_entries, :comment, :string
    
    add_index :event_entries, [:event_id, :user_id], unique: true
    add_index :event_entries, [:user_id, :event_id], unique: true
  end
end
