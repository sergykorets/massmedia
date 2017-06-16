class Tag < ApplicationRecord
  has_many :taggings
  has_many :tags, through: :taggings
  has_many :comments, as: :commentable, dependent: :destroy

  validates_uniqueness_of :name

  def self.search(search)
    if search
      where('name ILIKE ?', "%#{search}%")
    else
      all
    end
  end
end
