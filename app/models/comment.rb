class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :author
  belongs_to :commentable, polymorphic: true

  validates_presence_of :content
  validates_presence_of :author_id

  scope :desc, -> { order(created_at: :desc) }

  def owner?(user)
  	self.author == user
  end

end
