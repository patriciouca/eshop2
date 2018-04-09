class Director < ActiveRecord::Base
	validates_presence_of :first_name, :last_name
	validates_length_of :first_name,:last_name, :in => 2..255
	def name
    	"#{first_name} #{last_name}"
  	end
end
