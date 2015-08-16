class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.text :memo
      t.references :user

      t.timestamps null: false
    end
  end
end
