class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      t.string :login_id,           null: false, default: ""
      t.string :encrypted_password, null: false, default: ""
      t.string :name,               null: false, default: ""

      t.timestamps null: false
    end

    add_index :users, :login_id, unique: true
  end
end
