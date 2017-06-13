class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :author

  validates_presence_of :content
  validates_presence_of :author_id
end
