class Dog < ActiveRecord::Base
	validates :name, :uniqueness => true
end
