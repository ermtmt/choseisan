class Option < ActiveRecord::Base
  validates :text, length: { maximum: 30 }, presence: true

  belongs_to :event
end
