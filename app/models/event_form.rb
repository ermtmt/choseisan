class EventForm
  include ActiveModel::Model

  attr_accessor :title, :memo

  validates :title, length: { maximum: 50 }, presence: true
  validates :memo,  length: { maximum: 200 }
end
