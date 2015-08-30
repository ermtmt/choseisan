class OptionEntry < ActiveRecord::Base
  belongs_to :option
  belongs_to :event_entry

  enum feeling: [:ng, :neither, :ok]
end
