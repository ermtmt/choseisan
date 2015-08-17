class Event < ActiveRecord::Base
  validates :title, length: { maximum: 50 }, presence: true
  validates :memo,  length: { maximum: 200 }

  before_create :generate_hash_id

  belongs_to :owner, class_name: 'User', foreign_key: :user_id

  def generate_hash_id
    self.hash_id = SecureRandom.hex
  end
end
