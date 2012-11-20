class Place < ActiveRecord::Base
  attr_accessible :lat, :lon, :mark, :name
  has_many :comments

end
