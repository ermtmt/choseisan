class OptionEntry < ActiveRecord::Base
  enum feeling: { NG: 0, Neither: 1, OK: 2 }

  validates :feeling, inclusion: { in: OptionEntry.feelings.keys }

  belongs_to :option
  belongs_to :event_entry

  scope :feeling_groups, ->(option_id) {
    where(option_id: option_id).group(:feeling).order(feeling: :asc).count
  }

  def self.option_entries(options, event_entry)
    option_entries = []
    options.each.with_index(0 - options.length) do |option, index|
      option_entry = OptionEntry.find_or_initialize_by(option: option, event_entry: event_entry) do |option_entry|
        option_entry.attributes = { id: index, option: option, event_entry: event_entry }
      end
      option_entries << option_entry
    end
    option_entries
  end
end
