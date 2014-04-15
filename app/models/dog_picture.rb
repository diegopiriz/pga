class DogPicture < ActiveRecord::Base
  belongs_to :dog

  attr_accessor :x1, :x2, :y1, :y2 
end
