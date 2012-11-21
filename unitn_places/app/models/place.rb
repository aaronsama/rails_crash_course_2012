class Place < ActiveRecord::Base
  MARKS = (1..5)
  validates :name, :latitude, :longitude, :presence => true
  validates :mark, :inclusion => MARKS

  attr_accessible :latitude, :longitude, :mark, :name

  has_many :comments
  has_and_belongs_to_many :users

  def self.search(search_term)
    if search_term.blank?
      self.all
    else
      self.where("name LIKE ?", "%#{search_term}%")
    end
  end
end
