class Movie < ActiveRecord::Base
 	has_and_belongs_to_many :directors
  belongs_to :producer

  has_many :cart_items
  has_many :carts, :through => :cart_items

  has_attached_file :cover_image
  validates_attachment :cover_image,
  :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png"] }

  validates_length_of :title, :in => 1..255,:message => 'El titulo debe estar entre 1 y 255 caracteres'
  validates_presence_of :producer,:message => 'El productor debe estar incluido'
  validates_presence_of :directors,:message => 'El director debe estar incluido'
  validates_presence_of :produced_at,:message => 'Debe incluir la fecha'
  validates_numericality_of :length, :only_integer => true,:message => 'La duracion tiene que ser numero'
  validates_numericality_of :price,:message => 'El precio debe ser numero'
  validates_length_of :serial_number, :in => 1..5,:message => 'El serial debe estar entre 1 y 5 caracteres'
  validates_uniqueness_of :serial_number,:message => 'El serial debe ser unico'

  def director_names
    self.directors.map{|director| director.name}.join(", ")
  end

  def self.latest(num)
    all.order("movies.id desc").includes(:directors, :producer).limit(num)
  end
end

