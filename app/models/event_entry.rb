class EventEntry < ActiveRecord::Base
  validates :comment, length: { maximum: 50 }

  belongs_to :event
  belongs_to :user
  has_many :option_entries, foreign_key: :event_entry_id, dependent: :destroy
end
