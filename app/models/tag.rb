class Tag < ApplicationRecord
  has_many :taggings
  has_many :tags, through: :taggings

  def self.search(search)
    if search
      where('name ILIKE ?', "%#{search}%")
    else
      all
    end
  end
end
