class Tip < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :stocks
end
