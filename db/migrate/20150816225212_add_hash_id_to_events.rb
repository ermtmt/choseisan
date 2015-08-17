class AddHashIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :hash_id, :string
    Event.all.each do |event|
      event.hash_id = SecureRandom.hex
      event.save!
    end
    change_column :events, :hash_id, :string, null: false

    add_index :events, :hash_id, unique: true
  end
end
