class Option < ActiveRecord::Base
  validates :text, length: { maximum: 30 }, presence: true

  belongs_to :event
  has_many :option_entries, foreign_key: :option_id, dependent: :destroy

  attr_accessor :count_ng, :count_neither, :count_ok, :rate

  def calc_option_entry
    feeling_counts = OptionEntry.feeling_groups(self.id)
    self.count_ng      = feeling_counts[0] || 0
    self.count_neither = feeling_counts[1] || 0
    self.count_ok      = feeling_counts[2] || 0
    sum = 0
    sum += self.count_ok * 100
    sum += self.count_neither * 50
    all_count = self.count_ng + self.count_neither + self.count_ok
    self.rate = (all_count == 0) ? 0 : sum / all_count
  end
end
