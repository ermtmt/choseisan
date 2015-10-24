class OptionEntry < ActiveRecord::Base
  enum feeling: { NG: 0, Neither: 1, OK: 2 }

  validates :feeling, inclusion: { in: OptionEntry.feelings.keys }

  belongs_to :option
  belongs_to :event_entry
end
