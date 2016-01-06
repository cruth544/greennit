class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :subgreen
  has_many :comments
end
