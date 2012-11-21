class Place < ActiveRecord::Base
  attr_accessible :lat, :lon, :mark, :name
  has_many :comments
  has_and_belongs_to_many :users
end
