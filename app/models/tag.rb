class Tag < ActiveRecord::Base
  enum color: { gray: 0, blue: 1, green: 2, sky: 3, orange: 4, red: 5 }

  validates :label, length: { maximum: 10 }, presence: true
  validates :color, inclusion: { in: Tag.colors.keys }, presence: true

  belongs_to :user
  has_many :taggings, dependent: :destroy
end
