class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  belongs_to :comment
  has_many :comments
end
