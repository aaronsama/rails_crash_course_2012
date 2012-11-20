class Book < ActiveRecord::Base
  MARKS = (1..5)

  attr_accessible :description, :mark, :title
  validates :title, :presence => true
  validates :mark, :presence => true, :inclusion => MARKS


  def self.search(search_term)
    if search_term
      self.where("title LIKE ?", "%#{search_term}%")
    else
      self.all
    end
  end

end
