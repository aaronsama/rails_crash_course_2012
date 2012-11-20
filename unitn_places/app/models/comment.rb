class Comment < ActiveRecord::Base
  attr_accessible :content, :title
  belongs_to :place
end
