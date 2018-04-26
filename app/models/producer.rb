class Producer < ActiveRecord::Base
	has_many :movies
	validates_presence_of :name,:message => 'Debe incluir el nombre'
  	validates_uniqueness_of :name,:message => 'Ya existe otro nombre igual'
  	validates_length_of :name, :in => 2..255,:message => 'El nombre debe estar entre 2 y 255 caracteres'
end
