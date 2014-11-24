require_relative '../../db/config'



class Title < ActiveRecord::Base
  has_many :congress_member
end