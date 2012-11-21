class User < ActiveRecord::Base
  attr_accessible :email, :name, :username
  has_and_belongs_to_many :places
end
