class Event < ActiveRecord::Base
  validates :title, length: { maximum: 50 }, presence: true
  validates :memo,  length: { maximum: 200 }
  validates :options_text,  length: { maximum: 2000 }, presence: true

  before_create :generate_hash_id

  belongs_to :owner, class_name: 'User', foreign_key: :user_id
  has_many :options, class_name: 'Option', foreign_key: :event_id, dependent: :destroy

  attr_accessor :options_text

  def generate_hash_id
    self.hash_id = SecureRandom.hex
  end
end
