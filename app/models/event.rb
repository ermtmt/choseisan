class Event < ActiveRecord::Base
  validates :title, length: { maximum: 50 }, presence: true
  validates :memo,  length: { maximum: 200 }
  validates :options_text,  length: { maximum: 2000 }

  before_create :validates_create, :generate_hash_id

  belongs_to :owner, class_name: 'User', foreign_key: :user_id
  has_many :options, foreign_key: :event_id, dependent: :destroy
  has_many :event_entries, foreign_key: :event_id, dependent: :destroy
  has_many :entry_users, through: :event_entries, source: :user
  has_many :taggings, foreign_key: :event_id, dependent: :destroy
  has_many :tags, through: :taggings, source: :tag

  attr_accessor :options_text
  attr_accessor :options_deletes

  scope :filter_tags, ->(tag_ids) {
    if tag_ids.present?
      joins{ tags }.where{ tags.id.in(tag_ids) }
    end
  }

  before_validation :build_options_from_options_text
  def build_options_from_options_text
    if options_text.present?
      options_text.each_line do |line|
        self.options.build(text: line.strip)
      end
    end
  end

  private
    def validates_create
      if self.options_text.blank?
        self.errors.add(:options_text, "を入力してください。")
        return false
      end
      return true
    end

    def generate_hash_id
      self.hash_id = SecureRandom.hex
    end
end
