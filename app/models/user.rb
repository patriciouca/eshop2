class User < ActiveRecord::Base
  acts_as_authentic do |a|
    a.validate_login_field = true
    a.validate_password_field = true
    a.require_password_confirmation = true
    a.logged_in_timeout = 5.minutes # default is 10.minutes
    # default encryption system uses "SCrypt" and requires 'scrypt' gem
    # for using previous encryption system uncomment next statement
    # a.crypto_provider = Authlogic::CryptoProviders::Sha512
  end

  validates_presence_of :name, :login, :email, :password, :password_confirmation,:message => 'Debe rellenar todos los campos'
  validates_length_of :name, :in => 3..225,:message => 'El nombre debe estar entre 3 y 255 caracteres'
  validates_uniqueness_of :name, :login, :email,:message => 'El nombre,email o login ya existe en la base de datos'
end
