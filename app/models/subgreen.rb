class Subgreen < ActiveRecord::Base
  belongs_to :user
  has_many :posts
  has_and_belongs_to_many :users

end
