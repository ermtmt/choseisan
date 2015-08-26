class User < ActiveRecord::Base
  # :confirmable
  # :lockable
  # :timeoutabl
  # :omniauthable
  # :recoverable
  # :rememberable
  # :trackable
  # :validatable
  devise :database_authenticatable,
         :registerable

  validates :login_id, length: { maximum: 10 }, presence: true, uniqueness: true
  validates :password, length: { maximum: 10 }, presence: true
  validates :name,     length: { maximum: 10 }, presence: true

  has_many :created_events, class_name: 'Event', foreign_key: :user_id
  has_many :event_entries, foreign_key: :event_id, dependent: :destroy
end

