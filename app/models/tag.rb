class Tag < ActiveRecord::Base
  enum color: { gray: 0, blue: 1, green: 2, sky: 3, orange: 4, red: 5 }

  belongs_to :user
  has_many :taggings, dependent: :destroy
end
