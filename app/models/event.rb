class Event < ActiveRecord::Base
  validates :title, length: { maximum: 50 }, presence: true
  validates :memo,  length: { maximum: 200 }

  belongs_to :owner, class_name: 'User', foreign_key: :user_id
end
