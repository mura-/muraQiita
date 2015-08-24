class Tip < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :stocks

  acts_as_taggable
end
