class AddStatusToOption < ActiveRecord::Migration
  def change
    add_column :options, :status, :integer, null: false, default: 0, after: :text
  end
end
