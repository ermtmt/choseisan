class EventEntry < ActiveRecord::Base
  validates :comment, length: { maximum: 50 }

  before_save :build_option_entries_from_feelings

  belongs_to :event
  belongs_to :user
  has_many :option_entries, foreign_key: :event_entry_id, dependent: :destroy

  accepts_nested_attributes_for :option_entries

  attr_accessor :feelings

  private
    def build_option_entries_from_feelings
      update_attributes = []
      feelings.each do |option_entry_id, attrs|
        option_entry_attributes = {}
        # データがない場合があるため、findではなくfind_by
        option_entry = option_entries.find_by(id: option_entry_id)
        if option_entry.blank?
          option_entry_attributes.merge!(id: nil, event_entry: self)
        else
          option_entry_attributes.merge!(option_entry.attributes)
        end
        option_entry_attributes.merge!(attrs)
        update_attributes << option_entry_attributes
      end
      self.attributes = { option_entries_attributes: update_attributes }
    end
end
