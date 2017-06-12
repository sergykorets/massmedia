class Post < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :author

  scope :most_recent, -> { order(id: :desc) }

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  validates_attachment_size :image, :in => 0.megabytes..2.megabytes

  def should_generate_new_friendly_id?
    name_changed?
  end

  def display_day_published
  	created_at.strftime('%-b %-d, %-Y')
  end
end
