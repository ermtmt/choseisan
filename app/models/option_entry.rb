class OptionEntry < ActiveRecord::Base
  enum feeling: { NG: 0, Neither: 1, OK: 2 }

  validates :feeling, inclusion: { in: OptionEntry.feelings.keys }

  belongs_to :option
  belongs_to :event_entry

  scope :feeling_groups, ->(option_id) {
    where(option_id: option_id).group(:feeling).order(feeling: :asc).count
  }
end
