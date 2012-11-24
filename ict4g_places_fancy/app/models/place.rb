class Place < ActiveRecord::Base
  attr_accessible :latitude, :longitude, :mark, :name
  has_many :comments

  MARKS = (1..5)
  validates :name, :presence => true
  validates :mark, :presence => true, :inclusion => MARKS

  def self.search(search_term)
    if search_term.blank?
      self.all
    else
      self.where("name LIKE ?", "%#{search_term}%")
    end
  end
end
