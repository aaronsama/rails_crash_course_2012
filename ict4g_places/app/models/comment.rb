class Comment < ActiveRecord::Base
  attr_accessible :content, :title, :place_id
  belongs_to :place
end
