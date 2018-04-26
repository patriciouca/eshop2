class Director < ActiveRecord::Base
	has_and_belongs_to_many :movies
	validates_presence_of :first_name, :last_name,:message => 'Debe incluir el nombre y los apellidos'
	validates_length_of :first_name,:last_name, :in => 2..255,:message => 'El serial debe estar entre 1 y 5 caracteres'
	def name
    	"#{first_name} #{last_name}"
  	end
end
