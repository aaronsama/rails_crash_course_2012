class Book < ActiveRecord::Base
  attr_accessible :description, :mark, :title
  validates :title, :presence => true

  def self.possible_marks
    (1..5)
  end

  validates :mark, :presence => true, :inclusion => self.possible_marks

  def self.search(search_term)
    if search_term
      self.where("title LIKE ?", "%#{search_term}%")
    else
      self.all
    end
  end

end
