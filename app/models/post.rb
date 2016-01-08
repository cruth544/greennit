class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :subgreen
  has_many :comments
  mount_uploader :picture, PictureUploader
end
